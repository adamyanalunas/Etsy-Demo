//
//  AYListing.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYListing.h"
#import "AYListingImage.h"


@implementation AYListing


#pragma mark - <MTLJSONSerializing>
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"categoryID"          : @"category_id",
             @"images"              : @"Images",
             @"listingDescription"  : @"description",
             @"listingID"           : @"listing_id",
             @"mainImage"           : @"MainImage",
             @"title"               : @"title",
             @"userID"              : @"user_id"
             };
}


+ (NSValueTransformer *)mainImageJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:AYListingImage.class];
}


#pragma mark - Properties
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, title: %@, owner: %li>",
            NSStringFromClass(self.class),
            self,
            _title,
            (long)_userID
            ];
}


@end
