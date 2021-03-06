//
//  NSObject+BezierPath.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "NSObject+BezierPath.h"

@implementation NSObject (BezierPath)

- (UIBezierPath *)withBezier:(BezierPathBlock)bezierBlock {
    UIBezierPath *bezierPath = [UIBezierPath new];
    bezierBlock(bezierPath);
    [bezierPath closePath];
    
    return bezierPath;
}
@end
