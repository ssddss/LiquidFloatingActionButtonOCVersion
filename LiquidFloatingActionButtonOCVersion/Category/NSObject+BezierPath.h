//
//  NSObject+BezierPath.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^BezierPathBlock)(UIBezierPath *path);
@interface NSObject (BezierPath)

- (UIBezierPath *)withBezier:(BezierPathBlock)bezierBlock;
@end
