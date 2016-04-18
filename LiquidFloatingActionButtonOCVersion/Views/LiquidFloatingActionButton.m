//
//  LiquidFloatingActionButton.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/18.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "LiquidFloatingActionButton.h"
static CGFloat const internalRadiusRatio = 20.0 / 56.0;
@interface LiquidFloatingActionButton()
@property (nonatomic, assign) CGFloat cellRadiusRatio;

@property (nonatomic, assign) BOOL responsible;
@property (nonatomic, assign) BOOL isClosed;



@property (nonatomic, assign) CGFloat plusRotation;

@property (nonatomic) CAShapeLayer *plusLayer;
@property (nonatomic) CAShapeLayer *circleLayer;

@property (nonatomic, assign) BOOL touching;

@property (nonatomic) CircleLiquidBaseView *baseView;
@property (nonatomic) UIView *liquidView;
@end
@implementation LiquidFloatingActionButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    _cellRadiusRatio = 0.5;
    _animateStyle = Up;
    _enableShadow = YES;
    _responsible = YES;
    _color = [UIColor colorWithRed:82 / 255.0 green:112 / 255.0 blue:235 / 255.0 alpha:1.0];
    _plusLayer = [CAShapeLayer new];
    _circleLayer = [CAShapeLayer new];
    _touching = NO;
    _plusRotation = 0;
    _baseView = [[CircleLiquidBaseView alloc]init];
    self.baseView.enableShadow = _enableShadow;
    _liquidView = [UIView new];
    
    [self setup];
    
    return self;
}

- (void)insertCell:(LiquidFloatingCell *)cell {
    cell.color  = self.color;
    cell.radius = self.frame.size.width * self.cellRadiusRatio;
    cell.center = [self minusCurrentPoint:self.center targetPoint:self.frame.origin];
    cell.actionButton = self;
    [self insertSubview:cell aboveSubview:self.baseView];
}
- (NSArray *)cellArray {
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self.dataSource numberOfCells:self]; i++) {
        [result addObject:[self.dataSource cellForIndex:i]];
    }
    return result;
}
// open all cells

- (void)open {
    [self.plusLayer addAnimation:[self plusKeyframe:YES] forKey:@"plusRot"];
    self.plusRotation = (CGFloat)(M_PI * 0.25);// 45 degree
    
    NSArray *cells = [self cellArray];
    for (LiquidFloatingCell *cell in cells) {
        [self insertCell:cell];
    }
    [self.baseView open:cells];
    [self setNeedsDisplay];
}
// close all cells
- (void)close {
    [self.plusLayer addAnimation:[self plusKeyframe:NO] forKey:@"plusRot"];
    self.plusRotation = 0;
    [self.baseView close:[self cellArray]];
    
    [self setNeedsDisplay];

}
- (void)drawRect:(CGRect)rect {
    [self drawCircle];
    [self drawShadow];
    [self drawPlus:self.plusRotation];
}
- (void)drawCircle {
    self.circleLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.circleLayer.cornerRadius = self.frame.size.width * 0.5;
    self.circleLayer.masksToBounds = YES;
    if (self.touching && self.responsible) {
        self.circleLayer.backgroundColor = [self.color whiteScale:0.5].CGColor;
    }
    else {
        self.circleLayer.backgroundColor = self.color.CGColor;
    }
}
- (void)drawPlus:(CGFloat)rotation {
    self.plusLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    self.plusLayer.lineCap = kCALineCapRound;
    self.plusLayer.strokeColor = [UIColor whiteColor].CGColor;// TODO: customizable
    self.plusLayer.lineWidth = 3.0;
    
    self.plusLayer.path = [self pathPlus:rotation].CGPath;
}
- (void)drawShadow {
    if (self.enableShadow) {
        [self.circleLayer appendShadow];
    }
}
// draw button plus or close face
- (UIBezierPath *)pathPlus:(CGFloat)rotation {
    CGFloat radius = self.frame.size.width * internalRadiusRatio * 0.5;
    CGPoint center = [self minusCurrentPoint:self.center targetPoint:self.frame.origin];
    
    NSArray<NSValue *> *points = @[
                        [CGMath circlePoint:center radius:radius rad:rotation],
                        [CGMath circlePoint:center radius:radius rad:(CGFloat)M_PI_2 + rotation],
                        [CGMath circlePoint:center radius:radius rad:(CGFloat)M_PI_2 * 2 + rotation],
                        [CGMath circlePoint:center radius:radius rad:(CGFloat)M_PI_2 * 3 + rotation],
                    ];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint p1 = points[0].CGPointValue;
    CGPoint p2 = points[1].CGPointValue;
    CGPoint p3 = points[2].CGPointValue;
    CGPoint p4 = points[3].CGPointValue;
    [path moveToPoint:p1];
    [path addLineToPoint:p3];
    [path moveToPoint:p2];
    [path addLineToPoint:p4];
    
    return path;
}
- (CAKeyframeAnimation *)plusKeyframe:(BOOL)closed {
    NSArray *paths = closed ? @[
                                [self pathPlus:(CGFloat)(M_PI * 0)],
                                [self pathPlus:(CGFloat)(M_PI * 0.125)],
                                [self pathPlus:(CGFloat)(M_PI * 0.25)]
                                ]    :
                               @[
                                [self pathPlus:(CGFloat)(M_PI * 0.25)],
                                [self pathPlus:(CGFloat)(M_PI * 0.125)],
                                [self pathPlus:(CGFloat)(M_PI * 0)]
                                    ];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    NSMutableArray *cgPaths = [NSMutableArray array];
    for (UIBezierPath *path in paths) {
        
        [cgPaths addObject:(__bridge id)(path.CGPath)];
    }
    anim.values = cgPaths;
    anim.duration = 0.5;
    anim.removedOnCompletion = true;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    return anim;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.touching = YES;
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.touching = NO;
    [self setNeedsDisplay];
    [self didTapped];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.touching = NO;
    [self setNeedsDisplay];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (LiquidFloatingCell *cell in [self cellArray]) {
        CGPoint pointForTargetView = [cell convertPoint:point fromView:self];
        if (CGRectContainsPoint(cell.bounds, pointForTargetView)) {
            if (cell.userInteractionEnabled) {
                return [cell hitTest:pointForTargetView withEvent:event];
            }
        }
    }
    
    return [super hitTest:point withEvent:event];
}
- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
    
    [self.baseView setup:self];
    [self addSubview:self.baseView];

    self.liquidView.frame = self.baseView.frame;
    self.liquidView.userInteractionEnabled = NO;
    [self addSubview:self.liquidView];
    
    [self.liquidView.layer addSublayer:self.circleLayer];
    [self.circleLayer addSublayer:self.plusLayer];
}
- (void)didTapped {
    if (self.isClosed) {
        [self open];
    }
    else {
        [self close];
    }
}
- (void)didTappedCell:(LiquidFloatingCell *)target{
    NSArray *cells = [self cellArray];
    for (NSInteger i = 0; i < cells.count; i++) {
        LiquidFloatingCell *cell = cells[i];
        if (target == cell) {
            [self.delegate liquidFloatingActionButton:self didSelectItemAtIndex:i];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setColor:(UIColor *)color {
    _color = color;
    self.baseView.color = color;
}
- (BOOL)isClosed {
  return self.plusRotation == 0;
   
}
- (void)setEnableShadow:(BOOL)enableShadow {
    _enableShadow = enableShadow;
    self.baseView.enableShadow = enableShadow;
    [self setNeedsDisplay];
}
- (void)setAnimateStyle:(LiquidFloatingActionButtonAnimateStyle)animateStyle {
    _animateStyle = animateStyle;
    self.baseView.animateStyle = animateStyle;
}
@end
