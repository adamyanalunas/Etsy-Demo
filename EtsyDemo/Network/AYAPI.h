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


@interface AYAPI : AFHTTPSessionManager

+ (instancetype)supervisor;

- (NSURLSessionDataTask *)search:(NSString *)term success:(AYAPISuccess)successBlock failure:(AYAPIFailure)failureBlock;
- (NSURLSessionDataTask *)search:(NSString *)term options:(NSDictionary *)options;
//- (void)setAuthHeadersForUser:(LSQUser *)user;

@end
