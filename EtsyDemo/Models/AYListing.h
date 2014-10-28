//
//  AYListing.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


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


@interface AYListing : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger listingID;
@property (nonatomic, assign) AYListingStatus status;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, assign) NSInteger categoryID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *listingDescription;

@end
