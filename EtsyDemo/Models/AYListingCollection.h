//
//  AYListingCollection.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYListing.h"
#import <Foundation/Foundation.h>


@class AYListing;


@interface AYListingCollection : NSObject

@property (nonatomic, strong) NSArray *listings;

+ (instancetype)listingCollectionFromResults:(NSDictionary *)results;
+ (AYListing *)listingFromResults:(NSDictionary *)data;
+ (NSArray *)listingsFromResults:(NSDictionary *)results;

@end
