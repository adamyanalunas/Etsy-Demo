//
//  AYAPI.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYAPI.h"


#define API_ROOT [NSURL URLWithString:@"https://api.etsy.com/v2/"]


@interface AYAPI ()

- (NSString *)sanitizedSearchKeywords:(NSString *)term;

@end


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


#pragma mark - Heplers
- (NSString *)sanitizedSearchKeywords:(NSString *)term
{
    // TODO: Regex sweep to clean up undesirables
    NSArray *keywords = [term componentsSeparatedByString:@" "];
    return (keywords.count ? [keywords componentsJoinedByString:@","] : nil);
}


#pragma mark - Endpoints
// TODO: Implement builder instead of loosely-typed dictionary
- (NSURLSessionDataTask *)search:(NSString *)term options:(NSDictionary *)options
{
    NSString *keywords = [self sanitizedSearchKeywords:term];
    if (!keywords.length || !options[@"success"]) return nil;
    
    NSNumber *limit = options[@"limit"] ?: @25;
    NSNumber *offset = options[@"offset"] ?: @0;
    NSString *includes = options[@"includes"] ?: @"MainImage";
    NSString *fields = options[@"fields"] ?: @"listing_id,title,url,price";
    
    AYAPISuccess successBlock = options[@"success"];
    AYAPIFailure failureBlock = options[@"failure"];
    
    NSDictionary *params = @{
                             @"api_key"     : API_KEY,
                             @"keywords"    : keywords,
                             @"limit"       : limit,
                             @"offset"      : offset,
                             @"includes"    : includes,
                             @"fields"      : fields
                             };
    
    NSURLSessionDataTask *op = [self GET:@"listings/active" parameters:params success:successBlock failure:failureBlock];
    
    return op;
}


- (NSURLSessionDataTask *)listing:(NSUInteger)listingID options:(NSDictionary *)options
{
    if (!options[@"success"]) return nil;
    
    AYAPISuccess successBlock = options[@"success"];
    AYAPIFailure failureBlock = options[@"failure"];
    
    NSString *includes = options[@"includes"] ?: @"MainImage,Images,Shop,User";
    NSDictionary *params = @{
                             @"api_key" : API_KEY,
                             @"includes": includes
                             };
    
    NSURLSessionDataTask *op = [self GET:[NSString stringWithFormat:@"listings/%i", listingID] parameters:params success:successBlock failure:failureBlock];
    
    return op;
}


@end
