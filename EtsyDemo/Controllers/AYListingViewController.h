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
@property (weak, nonatomic) IBOutlet UIImageView *listingImageView;
@property (weak, nonatomic) IBOutlet UILabel *listingNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingPriceLabel;
@property (nonatomic, strong) AYShop *shop;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

+ (instancetype)viewControllerWithListing:(AYListing *)listing;

- (void)loadListing:(NSUInteger)listingID;
- (void)setup;

@end
