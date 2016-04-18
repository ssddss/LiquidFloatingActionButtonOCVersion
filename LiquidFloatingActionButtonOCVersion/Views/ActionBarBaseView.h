//
//  ActionBarBaseView.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/18.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AnimationBlock)(CABasicAnimation *basicAnimation);
@interface ActionBarBaseView : UIView
@property (nonatomic, assign) BOOL opening;
- (void)setup:(LiquidFloatingActionButton *)actionButton;
@end
