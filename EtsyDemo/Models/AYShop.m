//
//  AYShop.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/30/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYShop.h"


@implementation AYShop


#pragma mark MTLJSONSerializing methods
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"shopID"      : @"shop_id",
             @"userID"      : @"user_id",
             @"name"        : @"shop_name",
             @"title"       : @"title",
             @"latitude"    : @"lat",
             @"longitude"   : @"lon"
             };
}


#pragma mark - Properties
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, ID: %li, title: %@, owner: %li>",
            NSStringFromClass(self.class),
            self,
            (unsigned long)_shopID,
            _title,
            (long)_userID
            ];
}


@end
