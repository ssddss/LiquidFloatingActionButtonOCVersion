//
//  SimpleCircleLiquidEngine.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SimpleCircleLiquidEngine : NSObject
@property (nonatomic) UIColor *color;
@property (nonatomic, assign) CGFloat viscosity;

- (instancetype)initWithRadiusThresh:(CGFloat)radiusThresh angleThresh:(CGFloat)angleThresh;
- (void)clear;
- (NSArray *)push:(LiquittableCircle *)circle other:(LiquittableCircle *)other;
- (void)draw:(UIView *)parent;
@end
