//
//  AYFilterSearchViewController.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 11/5/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYFilterSearchViewController.h"

@implementation AYFilterSearchViewController


#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addObserver:self forKeyPath:@"currentPrice" options:0 context:nil];
}


- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"currentPrice"];
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:AYFilterSearchViewController.class])
    {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(currentPrice))])
        {
            DELEGATE_SAFELY(self.delegate, @selector(filterSearch:didChangePriceFilter:), [self.delegate filterSearch:self didChangePriceFilter:self.priceBracket];)
        }
    }
}


#pragma mark - Actions
- (IBAction)goAwayPlease:(id)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


- (IBAction)changePrice:(id)sender
{
    self.currentPrice = ((UISegmentedControl *)sender).selectedSegmentIndex;
}
@end
