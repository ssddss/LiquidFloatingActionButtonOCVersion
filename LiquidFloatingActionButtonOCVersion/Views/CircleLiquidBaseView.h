//
//  CircleLiquidBaseView.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/18.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "ActionBarBaseView.h"

@interface CircleLiquidBaseView : ActionBarBaseView
@property (nonatomic) UIColor *color;
@property (nonatomic, assign) LiquidFloatingActionButtonAnimateStyle animateStyle;
- (void)open:(NSArray *)cells;
- (void)close:(NSArray *)cells;
@end
