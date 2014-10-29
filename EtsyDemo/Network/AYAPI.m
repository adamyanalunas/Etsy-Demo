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
// TODO: Implement builder instead of loosely-typed dictionary
- (NSURLSessionDataTask *)search:(NSString *)term options:(NSDictionary *)options
{
    if (!options[@"success"]) return nil;
    
    NSNumber *limit = options[@"limit"] ?: @25;
    NSNumber *offset = options[@"offset"] ?: @0;
    NSString *includes = options[@"includes"] ?: @"MainImage";
    NSString *fields = options[@"fields"] ?: @"title,url";
    
    AYAPISuccess successBlock = options[@"success"];
    AYAPIFailure failureBlock = options[@"failure"];
    
    NSDictionary *params = @{
                             @"api_key"     : API_KEY,
                             @"limit"       : limit,
                             @"offset"      : offset,
                             @"includes"    : includes,
                             @"fields"      : fields
                             };
    
    NSURLSessionDataTask *op = [self GET:@"listings/active" parameters:params success:successBlock failure:failureBlock];
    
    return op;
}

@end
