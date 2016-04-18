//
//  LiquidFloatingActionButton.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/18.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LiquidFloatingActionButton,LiquidFloatingCell;

//数据源代理
@protocol LiquidFloatingActionButtonDataSource <NSObject>

- (NSInteger)numberOfCells:(LiquidFloatingActionButton *)liquidFloatingActionButton;
- (LiquidFloatingCell *)cellForIndex:(NSInteger)index;

@end
//点击代理
@protocol LiquidFloatingActionButtonDelegate <NSObject>

- (void)liquidFloatingActionButton:(LiquidFloatingActionButton *)liquidFloatingActionButton didSelectItemAtIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, LiquidFloatingActionButtonAnimateStyle) {
    Up,
    Right,
    Left,
    Down
};
@interface LiquidFloatingActionButton : UIView
@property (nonatomic, assign) LiquidFloatingActionButtonAnimateStyle animateStyle;
@property (nonatomic) UIColor *color;

@property (nonatomic) UIColor *startLiquidColor;/**< 开始水滴颜色*/
@property (nonatomic) UIColor *afterStartLiquidColor;/**< 之后过渡水滴的颜色*/
@property (nonatomic, assign) BOOL enableShadow;

@property (nonatomic, weak) id<LiquidFloatingActionButtonDelegate> delegate;
@property (nonatomic, weak) id<LiquidFloatingActionButtonDataSource> dataSource;

- (void)didTappedCell:(LiquidFloatingCell *)target;
@end
