//
//  CALayer+Shadow.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "CALayer+Shadow.h"

@implementation CALayer (Shadow)
- (void)appendShadow {
    self.shadowColor = [UIColor blackColor].CGColor;
    self.shadowRadius = 2.0;
    self.shadowOpacity = 0.1;
    self.shadowOffset = CGSizeMake(4, 4);
    self.masksToBounds = NO;
}
- (void)eraseShadow {
    self.shadowRadius = 0.0;
    self.shadowColor = [UIColor clearColor].CGColor;
}
@end
