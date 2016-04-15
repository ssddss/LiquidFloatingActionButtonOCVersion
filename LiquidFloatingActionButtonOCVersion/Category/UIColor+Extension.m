//
//  UIColor+Extension.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
- (CGFloat)red {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[0];
}
- (CGFloat)green {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[1];
}
- (CGFloat)blue {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[2];

}
- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}
- (UIColor *)alphaByAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:self.red green:self.green blue:self.blue alpha:alpha];
}
- (UIColor *)whiteScale:(CGFloat)scale {
    return [UIColor colorWithRed:self.red + (1.0 - self.red) * scale
                           green:self.green + (1.0 - self.green) * scale
                            blue:self.blue + (1.0 - self.blue) * scale
                           alpha:1.0];
}
@end
