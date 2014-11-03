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

@property (nonatomic, copy) NSArray *includes;
@property (nonatomic, copy) AYAPIFailure failure;
@property (nonatomic, copy) NSArray *fields;
@property (nonatomic, copy) NSArray *keywords;
@property (nonatomic, copy) NSNumber *limit;
@property (nonatomic, copy) NSNumber *offset;
@property (nonatomic, copy) AYAPISuccess success;

@end


@interface AYAPI : AFHTTPSessionManager

+ (instancetype)supervisor;

- (NSURLSessionDataTask *)listing:(NSUInteger)listingID configuration:(AYAPIRequestConfiguration *)configuration;
- (NSURLSessionDataTask *)search:(NSString *)term configuration:(AYAPIRequestConfiguration *)configuration;

@end
