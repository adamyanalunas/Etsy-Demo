//
//  AYFilterSearchViewController.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 11/5/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import <UIKit/UIKit.h>


@class AYFilterSearchViewController;


@protocol AYFilterSearchDelegate

@optional
- (void)filterSearch:(AYFilterSearchViewController *)filterViewController didChangePriceFilter:(UISegmentedControl *)priceFilter;

@end


@interface AYFilterSearchViewController : UIViewController <AYFilterSearchDelegate>

@property (nonatomic, assign) NSInteger currentPrice;
@property (weak, nonatomic) NSObject<AYFilterSearchDelegate>* delegate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceBracket;

- (IBAction)goAwayPlease:(id)sender;

@end
