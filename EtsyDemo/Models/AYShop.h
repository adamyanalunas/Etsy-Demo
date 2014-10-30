//
//  AYShop.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/30/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>


@interface AYShop : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger shopID;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSUInteger userID;
@property (nonatomic, copy) NSString *zip;


@end
