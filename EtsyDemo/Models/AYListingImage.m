//
//  AYListingImage.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYListingImage.h"


@implementation AYListingImage


#pragma mark - <MTLJSONSerializing>
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"smallURL"        : @"url_75x75",
             @"mediumURL"       : @"url_170x135",
             @"largeURL"        : @"url_570xN",
             @"fullURL"         : @"url_fullxfull",
             @"listingImageID"  : @"listing_image_id",
             @"listingID"       : @"listing_id"
             };
}


+ (NSValueTransformer *)smallURLJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *path) {
        return [NSURL URLWithString:path];
    } reverseBlock:^id(NSURL *url) {
        return url.absoluteString;
    }];
}


+ (NSValueTransformer *)mediumURLJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *path) {
        return [NSURL URLWithString:path];
    } reverseBlock:^id(NSURL *url) {
        return url.absoluteString;
    }];
}


+ (NSValueTransformer *)largeURLJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *path) {
        return [NSURL URLWithString:path];
    } reverseBlock:^id(NSURL *url) {
        return url.absoluteString;
    }];
}


+ (NSValueTransformer *)fullURLJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *path) {
        return [NSURL URLWithString:path];
    } reverseBlock:^id(NSURL *url) {
        return url.absoluteString;
    }];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, ID: %li, listingID: %li>",
            NSStringFromClass(self.class),
            self,
            (long)_listingID,
            (long)_listingImageID
            ];
}


@end
