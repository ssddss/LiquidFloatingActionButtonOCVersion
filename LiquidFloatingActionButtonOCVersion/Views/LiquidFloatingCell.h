//
//  LiquidFloatingCell.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/18.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "LiquittableCircle.h"

@interface LiquidFloatingCell : LiquittableCircle
@property (nonatomic) LiquidFloatingActionButton *actionButton;

- (instancetype)initCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color icon:(UIImage *)icon;
- (instancetype)initCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color view:(UIView *)view;

- (instancetype)initIcon:(UIImage *)icon;
- (void)updateKey:(CGFloat)key open:(BOOL)open;
@end
