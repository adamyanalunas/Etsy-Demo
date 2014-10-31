//
//  AYSpringyCollectionViewFlowLayout.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/30/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface AYSpringyCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat latestDelta;
@property (nonatomic, strong) NSMutableSet *visibleIndexPathsSet;

- (void)resetLayout;

@end
