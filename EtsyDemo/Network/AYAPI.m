//
//  AYAPI.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYAPI.h"


#define API_ROOT [NSURL URLWithString:@"https://api.etsy.com/v2/"]


@interface AYAPIRequestConfiguration ()

@property (nonatomic, copy) NSString *apiKey;

@end


@implementation AYAPIRequestConfiguration

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    self.apiKey = API_KEY;
    
    self.limit = @25;
    self.offset = @0;
    self.includes = @[@"MainImage"];
    self.fields = @[@"listing_id", @"title", @"url", @"price"];
    
    return self;
}

@end


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
- (NSURLSessionDataTask *)trendingWithConfiguration:(AYAPIRequestConfiguration *)configuration
{
    NSString *includes = [configuration.includes componentsJoinedByString:@","] ?: @"MainImage";
    NSString *fields = [configuration.fields componentsJoinedByString:@","] ?: @"listing_id,title,url,price";
    
    NSDictionary *params = @{
                             @"api_key": configuration.apiKey,
                             @"limit"       : configuration.limit,
                             @"offset"      : configuration.offset,
                             @"includes"    : includes,
                             @"fields"      : fields
                             };
    NSURLSessionDataTask *op = [self GET:@"listings/trending" parameters:params success:configuration.success failure:configuration.failure];
    
    return op;
}


- (NSURLSessionDataTask *)search:(NSString *)term configuration:(AYAPIRequestConfiguration *)configuration
{
    NSString *keywords = [self sanitizedSearchKeywords:term];
    if (!keywords.length || !configuration.success) return nil;
    
    NSString *includes = [configuration.includes componentsJoinedByString:@","] ?: @"MainImage";
    NSString *fields = [configuration.fields componentsJoinedByString:@","] ?: @"listing_id,title,url,price";
    
    NSDictionary *params = @{
                             @"api_key"     : configuration.apiKey,
                             @"keywords"    : keywords,
                             @"limit"       : configuration.limit,
                             @"offset"      : configuration.offset,
                             @"includes"    : includes,
                             @"fields"      : fields
                             };
    
    NSURLSessionDataTask *op = [self GET:@"listings/active" parameters:params success:configuration.success failure:configuration.failure];
    
    return op;
}


- (NSURLSessionDataTask *)listing:(NSUInteger)listingID configuration:(AYAPIRequestConfiguration *)configuration
{
    if (!configuration.success) return nil;
    
    NSString *includes = [configuration.includes componentsJoinedByString:@","];
    NSDictionary *params = @{
                             @"api_key" : API_KEY,
                             @"includes": includes
                             };
    
    NSURLSessionDataTask *op = [self GET:[NSString stringWithFormat:@"listings/%lu", (unsigned long)listingID] parameters:params success:configuration.success failure:configuration.failure];
    
    return op;
}


@end
