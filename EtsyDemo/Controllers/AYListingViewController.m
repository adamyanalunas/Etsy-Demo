//
//  AYListingViewController.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/29/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import <AFNetworking/UIImageView+AFNetworking.h>
#import "AYAPI.h"
#import "AYListingCollection.h"
#import "AYListingImageCollection.h"
#import "AYListingViewController.h"
#import "AYShop.h"
#import "UIViewController+AYLoading.h"


@interface AYListingViewController ()

- (NSString *)formattedListingPrice;
- (NSString *)listingDescription;
- (NSString *)listingName;
- (NSDictionary *)listingDataFromResults:(NSDictionary *)results;
- (NSDictionary *)shopDataFromResults:(NSDictionary *)results;
- (NSString *)shopName;

@end


@implementation AYListingViewController


#pragma mark - Lifecycle
+ (instancetype)viewControllerWithListing:(AYListing *)listing
{
    AYListingViewController *vc = [super new];
    if (!vc) return nil;
    
    vc.listing = listing;
    vc.title = listing.title;
    
    return vc;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.listing.title;
    
    self.shopNameLabel.text = @"";
    self.listingNameLabel.text = @"";
    self.listingPriceLabel.text = @"";
    self.listingDescriptionTextField.text = @"";
    
    [self loadListing:self.listing.listingID];
    [self AYLoadingSetup];
}


- (void)setup
{
    self.shopNameLabel.text = [self shopName];
    self.listingNameLabel.text = [self listingName];
    self.listingPriceLabel.text = [self formattedListingPrice];
    self.listingDescriptionTextField.text = [self listingDescription];
    
    NSURL *url = self.listing.mainImage.largeURL;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak typeof(self) weakSelf = self;
    [self.listingImageView setImageWithURLRequest:request
                              placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakSelf.listingImageView.image = image;
                                       [weakSelf.listingImageView setNeedsLayout];
                                   } failure:nil];
    
    self.pageControl.numberOfPages = self.listing.images.count;
    self.pageControl.currentPage = 0;
    
    // TODO: Cleanup
    // TODO: Whaddaya think, good place for a bit of ReactiveCocoa? Yeah.
    CGSize gallerySize = self.galleryScrollView.frame.size;
    CGSize contentSize = {gallerySize.width * self.listing.images.count, 300};
    self.galleryScrollView.contentSize = contentSize;
    self.galleryScrollView.bounds = (CGRect){
        .origin = {0, 0},
        .size = contentSize
    };
    self.galleryScrollView.contentInset = UIEdgeInsetsZero;
    for (int i=0; i<self.listing.images.count; i++)
    {
        CGFloat xOrigin = i * gallerySize.width;
        UIImageView *imageView = [UIImageView.alloc initWithFrame:(CGRect){xOrigin,0, gallerySize.width, gallerySize.height}];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.galleryScrollView addSubview:imageView];
        
        NSURL *url = ((AYListingImage *)self.listing.images[i]).largeURL;
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        __weak typeof(imageView) weakImageView = imageView;
        [imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            __strong typeof(weakImageView) strongImageView = weakImageView;
            strongImageView.image = image;
        } failure:nil];
    }
}


#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.galleryScrollView.frame.size.width;
    float fractionalPage = self.galleryScrollView.contentOffset.x / pageWidth;
    
    self.pageControl.currentPage = lround(fractionalPage) % self.pageControl.numberOfPages;
}



#pragma mark - Helpers
- (NSString *)listingDescription
{
    return self.listing.listingDescription;
}


- (NSString *)formattedListingPrice
{
    return self.listing.formattedPrice;
}


- (NSString *)listingName
{
    return self.listing.title;
}


- (NSString *)shopName
{
    return self.shop.name;
}


#pragma mark - Networking
- (void)loadListing:(NSUInteger)listingID
{
    __weak typeof(self) weakSelf = self;
    AYAPISuccess success = ^(NSURLSessionDataTask *task, id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSError *err;
        
        strongSelf.listing = [MTLJSONAdapter modelOfClass:AYListing.class fromJSONDictionary:[self listingDataFromResults:responseObject] error:&err];
        
        strongSelf.shop = [MTLJSONAdapter modelOfClass:AYShop.class fromJSONDictionary:[self shopDataFromResults:responseObject] error:&err];
        AYListingImageCollection *imageCollection = [AYListingImageCollection imageCollectionFromResults:responseObject];
        strongSelf.listing.images = imageCollection.images;
        
        [self setup];
        [self AYLoadingHide];
    };
    
    AYAPIFailure failure = ^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Listing load fail: %@", error);
        [self AYLoadingHide];
    };
    
    AYAPIRequestConfiguration *config = AYAPIRequestConfiguration.new;
    config.includes = [NSSet setWithObjects:@"MainImage", @"Images", @"Shop", @"User", nil];
    config.success = success;
    config.failure = failure;
    NSURLSessionDataTask *op = [AYAPI.supervisor listing:listingID configuration:config];
    
    if (op)
    {
        [self AYLoadingShow];
    }
}


- (NSDictionary *)listingDataFromResults:(NSDictionary *)results
{
    NSArray *listings = results[@"results"];
    return (listings.count ? listings[0] : nil);
}


- (NSDictionary *)shopDataFromResults:(NSDictionary *)results
{
    // TODO: Wow. I wrote this and I'm impressed with how fragile it is.
    NSArray *shops = results[@"results"];
    return (shops.count ? shops[0][@"Shop"] : nil);
}


@end
