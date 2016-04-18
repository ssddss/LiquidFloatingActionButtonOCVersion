//
//  UIColor+Extension.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
- (CGFloat)yrd_red {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[0];
}
- (CGFloat)yrd_green {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[1];
}
- (CGFloat)yrd_blue {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[2];

}
- (CGFloat)yrd_alpha {
    return CGColorGetAlpha(self.CGColor);
}
- (UIColor *)yrd_alphaByAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:self.yrd_red green:self.yrd_green blue:self.yrd_blue alpha:alpha];
}
- (UIColor *)yrd_whiteScale:(CGFloat)scale {
    return [UIColor colorWithRed:self.yrd_red + (1.0 - self.yrd_red) * scale
                           green:self.yrd_green + (1.0 - self.yrd_green) * scale
                            blue:self.yrd_blue + (1.0 - self.yrd_blue) * scale
                           alpha:1.0];
}
@end
