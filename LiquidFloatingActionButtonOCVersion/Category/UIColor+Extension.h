//
//  UIColor+Extension.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
- (CGFloat)yrd_red;

- (CGFloat)yrd_green;

- (CGFloat)yrd_blue;

- (CGFloat)yrd_alpha;

- (UIColor *)yrd_alphaByAlpha:(CGFloat)alpha;

- (UIColor *)yrd_whiteScale:(CGFloat)scale;
@end
