//
//  AYListingCollection.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYListing.h"
#import "AYListingCollection.h"
#import "AYShop.h"
#import <Mantle/Mantle.h>


@implementation AYListingCollection


#pragma mark - Lifecycle
+ (instancetype)listingCollectionFromResults:(NSDictionary *)results
{
    AYListingCollection *collection = [super new];
    if (!collection) return nil;
    
    collection.listings = [collection.class listingsFromResults:results];
    
    return collection;
}


#pragma mark - Parsing
+ (NSArray *)listingsFromResults:(NSDictionary *)results
{
    NSMutableArray *listings = [NSMutableArray array];
    for (NSDictionary *data in results)
    {
        AYListing *listing = [self.class listingFromResults:data];
        if (!listings)
        {
            // TODO: Log error local or remote
            break;
        }
        
        [listings addObject:listing];
    }
    
    return listings.copy;
}


+ (AYListing *)listingFromResults:(NSDictionary *)data
{
    NSError *error;
    AYListing *listing = [MTLJSONAdapter modelOfClass:AYListing.class fromJSONDictionary:data error:&error];
    
    listing.shop = [MTLJSONAdapter modelOfClass:AYShop.class fromJSONDictionary:data[@"Shop"] error:&error];
    
    return (!error ? listing : nil);
}


#pragma mark - Properties
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, listings: %li>",
            NSStringFromClass(self.class),
            self,
            (long)_listings.count
            ];
}


@end
