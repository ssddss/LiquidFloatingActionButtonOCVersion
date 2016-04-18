//
//  ActionBarBaseView.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/18.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "ActionBarBaseView.h"
#import <CoreFoundation/CoreFoundation.h>
@interface ActionBarBaseView()
@end
@implementation ActionBarBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setup:(LiquidFloatingActionButton *)actionButton {
    
}
- (void)translateY:(CALayer *)layer duration:(CFTimeInterval)duration block:(AnimationBlock)block {
    CABasicAnimation *translate = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    block(translate);
    translate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translate.removedOnCompletion = NO;
    translate.fillMode = kCAFillModeForwards;
    translate.duration = duration;
    [layer addAnimation:translate forKey:@"transYAnim"];
    
}
@end
