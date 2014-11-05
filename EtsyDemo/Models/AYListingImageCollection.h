//
//  AYListingImageCollection.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 11/4/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYListingImage.h"
#import <Foundation/Foundation.h>


@interface AYListingImageCollection : NSObject

@property (nonatomic, strong) NSArray *images;

+ (instancetype)imageCollectionFromResults:(NSDictionary *)results;
+ (AYListingImage *)imageFromResult:(NSDictionary *)data;
+ (NSArray *)imagesFromResults:(NSArray *)results;

@end
