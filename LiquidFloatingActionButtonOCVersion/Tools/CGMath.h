//
//  CGMath.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CGMath : NSObject
+ (CGFloat)radToDeg:(CGFloat)rad;

+ (CGFloat)degToRad:(CGFloat)deg;

+ (CGPoint)circlePoint:(CGPoint)center radius:(CGFloat)radius rad:(CGFloat)rad;

+ (NSArray *)linSpaceFrom:(CGFloat)from to:(CGFloat)to n:(NSInteger)n;
@end
