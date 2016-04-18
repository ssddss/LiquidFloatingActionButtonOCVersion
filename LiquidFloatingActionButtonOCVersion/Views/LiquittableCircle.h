//
//  LiquittableCircle.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiquittableCircle : UIView
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic) UIColor *color;

- (instancetype)init;
- (instancetype)initCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color;

- (CGPoint)circlePoint:(CGFloat)rad;

@end
