//
//  CGMath.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "CGMath.h"

@implementation CGMath
+ (CGFloat)radToDeg:(CGFloat)rad {
    return rad * 180 / (CGFloat)M_PI;
}
+ (CGFloat)degToRad:(CGFloat)deg {
    return deg * (CGFloat)M_PI / 180;
}

+ (NSValue *)circlePoint:(CGPoint)center radius:(CGFloat)radius rad:(CGFloat)rad {
    CGFloat x = center.x + radius * cos(rad);
    CGFloat y = center.y + radius * sin(rad);
    NSValue *value = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    return value;
}

+ (NSArray *)linSpaceFrom:(CGFloat)from to:(CGFloat)to n:(NSInteger)n {
    NSMutableArray *values = [NSMutableArray array];
    
    for (NSInteger i = 0; i < n ; i++) {
        [values addObject:[NSNumber numberWithFloat:(to - from) * (CGFloat)i / (CGFloat)(n - 1) + from]];
    }
    //返回cgfloat值的number类型数组
    return values;
}
@end
