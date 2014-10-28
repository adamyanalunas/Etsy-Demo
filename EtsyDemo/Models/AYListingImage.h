//
//  AYListingImage.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import <Mantle/Mantle.h>


@interface AYListingImage : MTLModel <MTLJSONSerializing>


@property (nonatomic, assign) NSInteger listingID;
@property (nonatomic, assign) NSInteger listingImageID;
@property (nonatomic, strong) NSURL *smallURL;
@property (nonatomic, strong) NSURL *mediumURL;
@property (nonatomic, strong) NSURL *largeURL;
@property (nonatomic, strong) NSURL *fullURL;


@end
