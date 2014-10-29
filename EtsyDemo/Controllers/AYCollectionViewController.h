//
//  AYCollectionViewController.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "UIViewController+AYLoading.h"
#import <UIKit/UIKit.h>


@class AYListing, AYResultCollectionViewCell;


@interface AYCollectionViewController : UICollectionViewController

- (void)commonInit;
- (AYResultCollectionViewCell *)configureCell:(AYResultCollectionViewCell *)cell listing:(AYListing *)listing;
- (void)getRecent;
- (void)search:(NSString *)term offset:(NSInteger)offset;

@end
