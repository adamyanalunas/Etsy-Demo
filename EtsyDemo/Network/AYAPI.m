//
//  AYAPI.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYAPI.h"


#define API_ROOT [NSURL URLWithString:@"https://api.etsy.com/v2/"]


@implementation AYAPI


#pragma mark - Lifecycle
+ (instancetype)supervisor
{
    static AYAPI *api;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [AYAPI.alloc initWithBaseURL:API_ROOT];
        api.requestSerializer = AFJSONRequestSerializer.serializer;
        api.responseSerializer = AFJSONResponseSerializer.serializer;
    });
    
    return api;
}


#pragma mark - Endpoints
- (NSURLSessionDataTask *)search:(NSString *)term success:(AYAPISuccess)successBlock failure:(AYAPIFailure)failureBlock;
{
    NSDictionary *params = @{@"api_key": API_KEY};
    NSURLSessionDataTask *op = [self GET:@"listings/active" parameters:params success:successBlock failure:failureBlock];
    
    return op;
}


- (NSURLSessionDataTask *)search:(NSString *)term options:(NSDictionary *)options
{
    if (!options[@"success"] || !options[@"failure"]) return nil;
    
    return [self search:term success:options[@"success"] failure:options[@"failure"]];
}

@end
