//
//  AYResultCollectionViewCell.m
//  EtsyDemo
//
//  Created by Adam Yanalunas on 10/27/14.
//  Copyright (c) 2014 Adam Yanalunas. All rights reserved.
//


#import "AYResultCollectionViewCell.h"


@interface AYResultCollectionViewCell ()

- (void)resizePriceToFit;

@end


@implementation AYResultCollectionViewCell


- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageView.image = nil;
    self.titleLabel.text = @"";
    self.shopLabel.text = @"";
    self.priceLabel.text = @"";
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self resizePriceToFit];
    
    [super layoutSubviews];
}


#pragma mark - Helpers
- (void)resizePriceToFit
{
    CGSize maxLabelSize = {CGFLOAT_MAX, CGRectGetHeight(_priceLabel.frame)};
    NSStringDrawingOptions options = (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading);
    NSDictionary *attributes = @{NSFontAttributeName:_priceLabel.font};
    CGRect expectedLabelSize = [_priceLabel.text boundingRectWithSize:maxLabelSize options:options attributes:attributes context:nil];
    
    _priceWidthConstraint.constant = CGRectGetWidth(expectedLabelSize);
}


- (CGSize)computedSize
{
    return (CGSize){140, _imageView.image.size.height + 48};
}


@end
