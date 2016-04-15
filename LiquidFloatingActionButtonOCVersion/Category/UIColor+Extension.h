//
//  UIColor+Extension.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
- (CGFloat)red;

- (CGFloat)green;

- (CGFloat)blue;

- (CGFloat)alpha;

- (UIColor *)alphaByAlpha:(CGFloat)alpha;

- (UIColor *)whiteScale:(CGFloat)scale;
@end
