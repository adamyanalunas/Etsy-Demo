//
//  AYListing.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYListingImage.h"
#import "AYShop.h"
#import <Mantle/Mantle.h>


typedef NS_ENUM(NSInteger, AYListingStatus) {
    AYListingStatusUnavailable  = -1,
    AYListingStatusRemoved      = 0,
    AYListingStatusActive       = 1,
    AYListingStatusSoldOut      = 2,
    AYListingStatusExpired      = 3,
    AYListingStatusEdit         = 4,
    AYListingStatusDraft        = 5,
    AYListingStatusCreate       = 6,
    AYListingStatusPrivate      = 7
};


@class AYListingImage;


@interface AYListing : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger categoryID;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *listingDescription;
@property (nonatomic, assign) NSInteger listingID;
@property (nonatomic, strong) AYListingImage *mainImage;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, strong) AYShop *shop;
@property (nonatomic, assign) AYListingStatus status;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger userID;

- (NSString *)formattedPrice;

@end
