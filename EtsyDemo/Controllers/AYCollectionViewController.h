//
//  AYCollectionViewController.h
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYFilterSearchViewController.h"
#import "UIViewController+AYLoading.h"
#import <UIKit/UIKit.h>


@class AYListing, AYResultCollectionViewCell;


@interface AYCollectionViewController : UICollectionViewController

@property (nonatomic, assign) NSInteger batchSize;
@property (nonatomic, copy) NSString *currentSearchTerm;
@property (nonatomic, assign, getter=isLoading) BOOL loading;

- (void)commonInit;
- (AYResultCollectionViewCell *)configureCell:(AYResultCollectionViewCell *)cell listing:(AYListing *)listing;
- (void)getRecent;
- (void)presentError:(NSError *)error;
- (void)requestNextBatch;
- (void)resetSearch;
- (void)search:(NSString *)term offset:(NSInteger)offset;

@end


@interface AYCollectionViewController () <UISearchDisplayDelegate, UISearchBarDelegate, AYFilterSearchDelegate>

@property (nonatomic, strong) UIBarButtonItem *filterBarButton;
@property (nonatomic, strong) UIPopoverController *filterPopover;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *searchResults;

- (void)filterButton:(id)sender;
- (NSNumber *)minPriceLevel;
- (NSNumber *)maxPriceLevel;
- (void)searchCurrentTerm;

@end
