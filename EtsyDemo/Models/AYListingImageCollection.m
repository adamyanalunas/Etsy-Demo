//
//  AYListingImageCollection.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 11/4/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//

#import "AYListingImageCollection.h"

@implementation AYListingImageCollection


#pragma mark - Lifecycle
+ (instancetype)imageCollectionFromResults:(NSDictionary *)results
{
    AYListingImageCollection *collection = [super new];
    if (!collection) return nil;
    
    collection.images = [collection.class imagesFromResults:results[@"results"]];
    
    return collection;
}


+ (NSArray *)imagesFromResults:(NSArray *)results
{
    NSMutableArray *images = [NSMutableArray array];
    for (NSDictionary *data in results[0][@"Images"])
    {
        AYListingImage *image = [self.class imageFromResult:data];
        if (!image)
        {
            // TODO: Log error local or remote
            break;
        }
        
        [images addObject:image];
    }
    
    return images.copy;
}


+ (AYListingImage *)imageFromResult:(NSDictionary *)data
{
    NSError *error;
    AYListingImage *image = [MTLJSONAdapter modelOfClass:AYListingImage.class fromJSONDictionary:data error:&error];
    
    return (!error ? image : nil);
}


#pragma mark - Properties
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, images: %li>",
            NSStringFromClass(self.class),
            self,
            (long)_images.count
            ];
}



@end
