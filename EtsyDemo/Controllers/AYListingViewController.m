//
//  AYListingViewController.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/29/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYAPI.h"
#import "AYListingViewController.h"
#import "AYShop.h"
#import "UIViewController+AYLoading.h"


@interface AYListingViewController ()

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
}


#pragma mark - Helpers
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
        
        // TODO: Wow. I wrote this and I'm impressed with how fragile it is.
        strongSelf.shop = [MTLJSONAdapter modelOfClass:AYShop.class fromJSONDictionary:responseObject[@"results"][0][@"Shop"] error:&err];
        
        [self setup];
        [self AYLoadingHide];
    };
    
    AYAPIFailure failure = ^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Listing load fail: %@", error);
        [self AYLoadingHide];
    };
    
    NSDictionary *options = @{
                              @"success": success,
                              @"failure": failure
                              };
    NSURLSessionDataTask *op = [AYAPI.supervisor listing:listingID options:options];
    if (op)
    {
        [self AYLoadingShow];
    }
}


@end
