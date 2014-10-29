//
//  UIViewController+AYLoading.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/28/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYLoadingOverlayViewController.h"
#import <UIKit/UIKit.h>


@interface UIViewController (AYLoading)

@property (nonatomic, strong) AYLoadingOverlayViewController *AYLoadingVC;

- (void)AYLoadingHide;
- (void)AYLoadingSetup;
- (void)AYLoadingShow;

@end
