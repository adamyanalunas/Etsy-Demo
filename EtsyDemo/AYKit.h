//
//  AYKit.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_KEY @"3u06htnxxm4gfc7hf8eb7h8x"

#define DELEGATE_SAFELY(obj, selector, ...) \
if ([obj respondsToSelector:selector]) { __VA_ARGS__ }

@interface AYKit : NSObject

@end
