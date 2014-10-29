//
//  UIViewController+AYLoading.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/28/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import <objc/runtime.h>
#import "UIViewController+AYLoading.h"


NSString *const AYLoadingVCPropertyKey = @"AYLoadingVCPropertyKey";


@implementation UIViewController (AYLoading)


@dynamic AYLoadingVC;


- (void)AYLoadingSetup
{
    if (self.AYLoadingVC) return;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Loading" bundle:nil];
    self.AYLoadingVC = [storyboard instantiateViewControllerWithIdentifier:@"LoadingStoryboard"];
}


- (void)AYLoadingShow
{
    [self AYLoadingSetup];
    [self addChildViewController:self.AYLoadingVC];
    [self.view addSubview:self.AYLoadingVC.view];
}


- (void)AYLoadingHide
{
    [self.AYLoadingVC removeFromParentViewController];
    [self.AYLoadingVC.view removeFromSuperview];
}


#pragma mark - Properties
- (AYLoadingOverlayViewController *)AYLoadingVC
{
    return objc_getAssociatedObject(self, (__bridge const void *)(AYLoadingVCPropertyKey));
}


- (void)setAYLoadingVC:(AYLoadingOverlayViewController *)AYLoadingVC
{
    objc_setAssociatedObject(self, (__bridge const void *)(AYLoadingVCPropertyKey), AYLoadingVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
