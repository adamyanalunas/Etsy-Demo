//
//  AYListingViewController.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/29/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import <AFNetworking/UIImageView+AFNetworking.h>
#import "AYAPI.h"
#import "AYListingViewController.h"
#import "AYShop.h"
#import "UIViewController+AYLoading.h"


@interface AYListingViewController ()

- (NSString *)formattedListingPrice;
- (NSString *)listingName;
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
    
    [self loadListing:self.listing.listingID];
    [self AYLoadingSetup];
}


- (void)setup
{
    self.shopNameLabel.text = [self shopName];
    self.listingNameLabel.text = [self listingName];
    self.listingPriceLabel.text = [self formattedListingPrice];
    
    NSURL *url = self.listing.mainImage.fullURL;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak typeof(self) weakSelf = self;
    [self.listingImageView setImageWithURLRequest:request
                              placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakSelf.listingImageView.image = image;
                                       [weakSelf.listingImageView setNeedsLayout];
                                   } failure:nil];
}


#pragma mark - Helpers
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
        
        strongSelf.shop = [MTLJSONAdapter modelOfClass:AYShop.class fromJSONDictionary:[self shopDataFromResults:responseObject] error:&err];
        
        [self setup];
        [self AYLoadingHide];
    };
    
    AYAPIFailure failure = ^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Listing load fail: %@", error);
        [self AYLoadingHide];
    };
    
    AYAPIRequestConfiguration *config = AYAPIRequestConfiguration.new;
    config.includes = @[@"MainImage", @"Images", @"Shop", @"User"];
    config.success = success;
    config.failure = failure;
    NSURLSessionDataTask *op = [AYAPI.supervisor listing:listingID configuration:config];
    
    if (op)
    {
        [self AYLoadingShow];
    }
}


- (NSDictionary *)shopDataFromResults:(NSDictionary *)results
{
    // TODO: Wow. I wrote this and I'm impressed with how fragile it is.
    NSArray *shops = results[@"results"];
    return (shops.count ? shops[0][@"Shop"] : nil);
}


@end
