//
//  AYCollectionViewController.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "AYAPI.h"
#import "AYCollectionViewController.h"
#import "AYListingCollection.h"
#import "AYListingImage.h"
#import "AYListingViewController.h"
#import "AYLoadingOverlayViewController.h"
#import "AYResultCollectionViewCell.h"
#import "NSObject+AYDebounce.h"


@interface AYCollectionViewController ()

@property (nonatomic, strong) NSArray *results;

- (NSString *)cellIdentifier;

@end


@implementation AYCollectionViewController


#pragma mark Lifecycle
//- (instancetype)init
//{
//    self = [super init];
//    if (!self) return nil;
//    
//    [self commonInit];
//    return self;
//}
//
//
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    
    [self commonInit];
    return self;
}


- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (!self) return nil;
    
    [self commonInit];
    return self;
}


//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (!self) return nil;
//    
//    [self commonInit];
//    return self;
//}
//
//
//+ (instancetype)new
//{
//    AYCollectionViewController *controller = [super new];
//    if (!controller) return nil;
//    
//    [controller commonInit];
//    return controller;
//}


- (void)commonInit
{
    self.title = @"Etsy!";
    self.results = NSMutableArray.array;
    self.searchResults = @[];
    self.loading = NO;
    self.batchSize = 30;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
//    [self.collectionView registerClass:AYResultCollectionViewCell.class forCellWithReuseIdentifier:self.cellIdentifier];
    
    _searchBar = UISearchBar.new;
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    self.navigationItem.titleView = _searchBar;
    
    [self getRecent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowListingSegue"])
    {
        NSIndexPath *selectedItem = [self.collectionView indexPathsForSelectedItems][0];
        AYListingViewController *vc = segue.destinationViewController;
        vc.listing = self.results[selectedItem.item];
    }
}


#pragma mark - Networking
- (void)search:(NSString *)term offset:(NSInteger)offset
{
    // TODO: Handle canceling existing requests
    if (self.isLoading) return;
    
    // TODO: This doesn't belong here
    if (self.results.count && ![self.currentSearchTerm isEqualToString:term])
    {
        [self resetSearch];
    }
    
    AYAPISuccess success = ^(NSURLSessionDataTask *task, id responseObject) {
        AYListingCollection *collection = [AYListingCollection listingCollectionFromResults:responseObject[@"results"]];
        self.results = [self.results arrayByAddingObjectsFromArray:collection.listings];
        [self.collectionView reloadData];
        [self AYLoadingHide];
        self.loading = NO;
    };
    
    AYAPIFailure failure = ^(NSURLSessionDataTask *task, NSError *error) {
        [self AYLoadingHide];
        [self presentError:error];
        self.loading = NO;
    };
    
    AYAPIRequestConfiguration *config = AYAPIRequestConfiguration.new;
    config.success = success;
    config.failure = failure;
    config.limit = @(self.batchSize);
    config.offset = @(offset);
    
    NSURLSessionDataTask *task = [AYAPI.supervisor search:term configuration:config];
    if (task)
    {
        self.currentSearchTerm = term;
        self.loading = YES;
        [self AYLoadingShow];
    }
}


- (void)requestNextBatch
{
    NSInteger cellTotal = [self.collectionView numberOfItemsInSection:0];
    NSInteger offset = floor(cellTotal/self.batchSize);
    [self search:self.currentSearchTerm offset:offset];
}


- (void)presentError:(NSError *)error
{
    NSString *title = NSLocalizedString(@"etsy.search.failure.title", @"Title of search failure message");
    NSString *message = NSLocalizedString(@"etsy.search.failure.message", @"Message shown when a search fails");
    NSString *dismissTitle = NSLocalizedString(@"etsy.button.dismiss", @"Button title to dismiss alert");
    
    UIAlertView *alert = [UIAlertView.alloc initWithTitle:title message:message delegate:nil cancelButtonTitle:dismissTitle otherButtonTitles:nil];
    [alert show];
}


//TODO: Die, die die!
- (void)getRecent
{
    [self search:@"halloween" offset:0];
}

#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.results.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = (self.isSearching ? self.searchCellIdentifier : self.cellIdentifier);
    AYResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    if (!self.results.count || self.results.count < indexPath.item) return cell;

    // TODO: Too brittle/dependent
    if (indexPath.item == self.results.count-1)
    {
        [self requestNextBatch];
    }
    
    [self configureCell:cell listing:self.results[indexPath.item]];
    
    return cell;
}


- (AYResultCollectionViewCell *)configureCell:(AYResultCollectionViewCell *)cell listing:(AYListing *)listing
{
    cell.titleLabel.text = listing.title;
    __weak AYResultCollectionViewCell *weakCell = cell;
    
    NSURL *url = listing.mainImage.mediumURL;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
    
    return cell;
}


#pragma mark - Search
- (void)searchCurrentTerm
{
    [self search:self.searchBar.text offset:0];
}


- (NSString *)searchCellIdentifier
{
    static NSString *cellID;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellID = @"AYResultCollectionViewSearchCellIdentifier";
    });
    
    return cellID;
}


- (void)resetSearch
{
    NSIndexPath *firstItem = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:firstItem atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    self.results = @[];
}


- (void)hideSearchFieldAnimated:(BOOL)animated
{
//    CGPoint offset = CGPointMake(0, CGRectGetHeight(self.searchDisplayController.searchBar.frame));
//    [self.collectionView setContentOffset:offset animated:animated];
}


#pragma mark - UISearchBarDelegate methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (!searchText.length) return;
    [self debounce:@selector(searchCurrentTerm) delay:.5];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [self resetSearch];
    [self.collectionView reloadData];
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


- (NSString *)cellIdentifier
{
    static NSString *cellID;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellID = @"AYResultCollectionViewCellIdentifier";
    });
    
    return cellID;
}

@end
