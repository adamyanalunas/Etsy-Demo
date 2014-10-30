//
//  AYListingVIewController.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/29/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYListing.h"
#import "AYShop.h"
#import <UIKit/UIKit.h>


@interface AYListingViewController : UIViewController

@property (nonatomic, strong) AYListing *listing;
@property (nonatomic, strong) AYShop *shop;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopLocationLabel;

+ (instancetype)viewControllerWithListing:(AYListing *)listing;

- (void)loadListing:(NSUInteger)listingID;
- (void)setup;

@end
