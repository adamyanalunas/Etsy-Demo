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


@interface AYCollectionViewController () <UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, readonly) BOOL isSearching;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *searchResults;

- (void)hideSearchFieldAnimated:(BOOL)animated;
- (NSString *)searchCellIdentifier;
- (void)searchCurrentTerm;

@end
