//
//  AYListing.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//

#import "AYListing.h"

@implementation AYListing


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"categoryID"          : @"category_id",
             @"listingDescription"  : @"description",
             @"listingID"           : @"listing_id",
             @"title"               : @"title",
             @"userID"              : @"user_id"
             };
}


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
