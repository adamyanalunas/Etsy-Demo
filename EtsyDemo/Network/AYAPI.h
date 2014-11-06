//
//  AYAPI.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import <AFNetworking/AFNetworking.h>


typedef void (^AYAPISuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void (^AYAPIFailure)(NSURLSessionDataTask *task, NSError *error);


@interface AYAPIRequestConfiguration : NSObject

@property (nonatomic, copy) NSSet *includes;
@property (nonatomic, copy) AYAPIFailure failure;
@property (nonatomic, copy) NSSet *fields;
@property (nonatomic, copy) NSSet *keywords;
@property (nonatomic, copy) NSNumber *limit;
@property (nonatomic, copy) NSNumber *offset;
@property (nonatomic, copy) AYAPISuccess success;

@end


@interface AYAPI : AFHTTPSessionManager

+ (instancetype)supervisor;

- (NSURLSessionDataTask *)trendingWithConfiguration:(AYAPIRequestConfiguration *)configuration;
- (NSURLSessionDataTask *)listing:(NSUInteger)listingID configuration:(AYAPIRequestConfiguration *)configuration;
- (NSURLSessionDataTask *)search:(NSString *)term configuration:(AYAPIRequestConfiguration *)configuration;

@end
