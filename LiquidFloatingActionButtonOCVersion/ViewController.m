//
//  ViewController.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<LiquidFloatingActionButtonDelegate,LiquidFloatingActionButtonDataSource>
@property (nonatomic) NSMutableArray *cells;
//@property (nonatomic) LiquidFloatingActionButton *floatingActionButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect floatingFrame = CGRectMake(16, self.view.frame.size.height - 56 - 300, 56, 56);
    LiquidFloatingActionButton *floatingActionButton = [self floatingActionButtonFectory:floatingFrame animateStyle:Down];
    [self.view addSubview:floatingActionButton];
    
    CGRect floatingFrameBottom = CGRectMake(self.view.frame.size.width - 56 - 16, self.view.frame.size.height - 56 - 16, 56, 56);
    LiquidFloatingActionButton *floatingActionButtonUp = [self floatingActionButtonFectory:floatingFrameBottom animateStyle:Up];
    [self.view addSubview:floatingActionButtonUp];
    
    CGRect floatingFrameLeft = CGRectMake(16, 60, 56, 56);
    LiquidFloatingActionButton *floatingActionButtonLeft = [self floatingActionButtonFectory:floatingFrameLeft animateStyle:Right];
    [self.view addSubview:floatingActionButtonLeft];
    
    CGRect floatingFrameRight = CGRectMake(self.view.frame.size.width - 56 - 16, 150, 56, 56);
    LiquidFloatingActionButton *floatingActionButtonRight = [self floatingActionButtonFectory:floatingFrameRight animateStyle:Left];
    [self.view addSubview:floatingActionButtonRight];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (LiquidFloatingCell *)cellFectory:(NSString *)iconName {
    return [[LiquidFloatingCell alloc]initIcon:[UIImage imageNamed:iconName]];
}
- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
//        [_cells addObject:[self cellFectory:@"course_Roam"]];
//        [_cells addObject:[self cellFectory:@"course_Custom"]];
        [_cells addObject:[self cellFectory:@"ic_system"]];
        [_cells addObject:[self cellFectory:@"ic_place"]];
        [_cells addObject:[self cellFectory:@"ic_cloud"]];

    }
    return _cells;
}
- (LiquidFloatingActionButton *)floatingActionButtonFectory:(CGRect)rect animateStyle:(LiquidFloatingActionButtonAnimateStyle)style {
    
    LiquidFloatingActionButton *floatingActionButton = [[LiquidFloatingActionButton alloc]initWithFrame:rect];
    floatingActionButton.enableShadow = NO;
    floatingActionButton.animateStyle = style;
    floatingActionButton.dataSource = self;
    floatingActionButton.delegate = self;
    return floatingActionButton;
}
#pragma protocol
- (NSInteger)numberOfCells:(LiquidFloatingActionButton *)liquidFloatingActionButton {
    return self.cells.count;
    
}
- (LiquidFloatingCell *)cellForIndex:(NSInteger)index {
    return self.cells[index];
}
- (void)liquidFloatingActionButton:(LiquidFloatingActionButton *)liquidFloatingActionButton didSelectItemAtIndex:(NSInteger)index {
    
}
@end
