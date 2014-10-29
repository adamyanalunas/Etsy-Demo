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
#import "AYLoadingOverlayViewController.h"
#import "AYResultCollectionViewCell.h"


@interface AYCollectionViewController ()

@property (nonatomic, strong) NSArray *results;

@end


@implementation AYCollectionViewController

static NSString * const reuseIdentifier = @"AYResultCollectionViewCell";


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
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self getRecent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Networking
- (void)search:(NSString *)term offset:(NSInteger)offset
{
    AYAPISuccess success = ^(NSURLSessionDataTask *task, id responseObject) {
        AYListingCollection *collection = [AYListingCollection listingCollectionFromResults:responseObject[@"results"]];
        self.results = collection.listings;
        [self.collectionView reloadData];
        [self AYLoadingHide];
    };
    
    AYAPIFailure failure = ^(NSURLSessionDataTask *task, NSError *error) {
        [self AYLoadingHide];
        NSLog(@"%@", error);
    };
    
    [self AYLoadingShow];
    
    NSDictionary *options = @{
                              @"success": success,
                              @"failure": failure,
                              @"offset" : @(offset)
                              };
    [AYAPI.supervisor search:term options:options];
}


//TODO: Die, die die!
- (void)getRecent
{
    [self search:@"halloween" offset:0];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.results.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AYResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AYResultCollectionViewCellIdentifier" forIndexPath:indexPath];
    
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

@end
