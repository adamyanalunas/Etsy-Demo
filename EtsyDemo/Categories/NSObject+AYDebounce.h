//
//  NSObject+AYDebounce.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/28/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSObject (AYDebounce)

- (void)debounce:(SEL)action delay:(NSTimeInterval)delay;

@end
