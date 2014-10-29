//
//  NSObject+AYDebounce.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/28/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "NSObject+AYDebounce.h"


@implementation NSObject (AYDebounce)


- (void)debounce:(SEL)action delay:(NSTimeInterval)delay
{
    __weak typeof(self) weakSelf = self;
    [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:action object:nil];
    [weakSelf performSelector:action withObject:nil afterDelay:delay];
}


@end
