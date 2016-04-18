//
//  CircleLiquidBaseView.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/18.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "CircleLiquidBaseView.h"
typedef void(^CellUpdateBlock)(LiquidFloatingCell *,NSInteger,CGFloat);
@interface CircleLiquidBaseView()
@property (nonatomic, assign) CGFloat openDuration;
@property (nonatomic, assign) CGFloat closeDuration;
@property (nonatomic, assign) CGFloat viscosity;

@property (nonatomic) LiquittableCircle *baseLiquid;
@property (nonatomic) SimpleCircleLiquidEngine *engine;
@property (nonatomic) SimpleCircleLiquidEngine *bigEngine;


@property (nonatomic) NSMutableArray *openingCells;
@property (nonatomic, assign) CGFloat keyDuration;
@property (nonatomic) CADisplayLink *displayLink;
@end
@implementation CircleLiquidBaseView
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _openDuration = 0.6;
    _closeDuration = 0.2;
    _viscosity = 0.65;
    _animateStyle = Up;
    _enableShadow = YES;
    _keyDuration = 0;
    _color = [UIColor colorWithRed:82 / 255.0 green:112 / 255.0 blue:235 / 255.0 alpha:1.0];
    return self;
}
- (void)setup:(LiquidFloatingActionButton *)actionButton {
    self.frame = actionButton.frame;
    self.center = [self minusCurrentPoint:actionButton.center targetPoint:actionButton.frame.origin];
    
    self.animateStyle = actionButton.animateStyle;
    CGFloat radius = MIN(self.frame.size.width, self.frame.size.height) * 0.5;
    self.engine = [[SimpleCircleLiquidEngine alloc]initWithRadiusThresh:radius * 0.73 angleThresh:0.45];
    self.engine.viscosity = self.viscosity;
    self.bigEngine = [[SimpleCircleLiquidEngine alloc]initWithRadiusThresh:radius angleThresh:0.55];
    self.bigEngine.viscosity = self.viscosity;
    self.engine.color = actionButton.color;
    self.bigEngine.color = actionButton.color;
    self.baseLiquid = [[LiquittableCircle alloc]initCenter:[self minusCurrentPoint:self.center targetPoint:self.frame.origin] radius:radius color:actionButton.color];
    
    self.baseLiquid.clipsToBounds = NO;
    self.baseLiquid.layer.masksToBounds = NO;
    
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
    [self addSubview:self.baseLiquid];

}
- (void)open:(NSArray *)cells {
    [self stop];
    
    CGFloat distance = self.frame.size.height * 1.25;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(didDisplayRefresh:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.opening = YES;
    
    for (LiquidFloatingCell *cell in cells) {
        [cell.layer removeAllAnimations];
        [cell.layer eraseShadow];
        [self.openingCells addObject:cell];
    }
}
- (void)close:(NSArray *)cells {
    [self stop];
    
    CGFloat distance = self.frame.size.height * 1.25;
     self.opening = NO;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(didDisplayRefresh:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
   
    
    for (LiquidFloatingCell *cell in cells) {
        [cell.layer removeAllAnimations];
        [cell.layer eraseShadow];
        [self.openingCells addObject:cell];
        cell.userInteractionEnabled = NO;

    }

}
- (void)didFinishUpdate {
    if (self.opening) {
        for (LiquidFloatingCell *cell in self.openingCells) {
            cell.userInteractionEnabled = YES;
        }
    }
    else {
        for (LiquidFloatingCell *cell in self.openingCells) {
            [cell removeFromSuperview];
        }
    }
}

- (void)update:(CGFloat)delay duration:(CGFloat)duration block:(CellUpdateBlock)block {
    if (!self.openingCells.count) {
        return;
    }
    
    CGFloat maxDuration = duration + (CGFloat)self.openingCells.count * delay;
    CGFloat t = self.keyDuration;
    CGFloat allRatio = [self easeInEaseOut:t / maxDuration];
    
    if (allRatio >= 1.0) {
        [self didFinishUpdate];
        [self stop];
        return;
    }
    
    [self.engine clear];
    [self.bigEngine clear];
    
    for (NSInteger i = 0; i < self.openingCells.count; i++) {
        LiquidFloatingCell *liquidCell = self.openingCells[i];
        CGFloat cellDelay = (CGFloat)delay * (CGFloat)i;
        CGFloat ratio = [self easeInEaseOut:(t - cellDelay) / duration];
        
        block(liquidCell, i , ratio);
    }
    
    LiquidFloatingCell *firstCell = self.openingCells[0];
    [self.bigEngine push:self.baseLiquid other:firstCell];
    
    for (NSInteger i = 1; i < self.openingCells.count; i++) {
        LiquidFloatingCell *prev = self.openingCells[i - 1];
        LiquidFloatingCell *cell = self.openingCells[i];
        [self.engine push:prev other:cell];
    }
    
    [self.engine draw:self.baseLiquid];
    [self.bigEngine draw:self.baseLiquid];
}
- (void)updateOpen {
    [self update:0.1 duration:self.openDuration block:^(LiquidFloatingCell *cell, NSInteger i, CGFloat ratio) {
        CGFloat posRatio = ratio > (CGFloat)i / (CGFloat)(self.openingCells.count) ? ratio : 0;
        CGFloat distance = (cell.frame.size.height * 0.5 + (CGFloat)(i + 1) * cell.frame.size.height * 1.5) * posRatio;
        cell.center = [self plusCurrentPoint:self.center targetPoint:[self differencePoint:distance]];
        [cell updateKey:ratio open:YES];
    }];
}
- (void)updateClose {
    [self update:0 duration:self.closeDuration block:^(LiquidFloatingCell *cell, NSInteger i, CGFloat ratio) {
        CGFloat distance = (cell.frame.size.height * 0.5 + (CGFloat)(i + 1) * cell.frame.size.height * 1.5) * (1 - ratio);
        cell.center = [self plusCurrentPoint:self.center targetPoint:[self differencePoint:distance]];
        [cell updateKey:ratio open:NO];
    }];
}
- (CGPoint)differencePoint:(CGFloat)distance {
    switch (self.animateStyle) {
        case Up: {
            return CGPointMake(0, -distance);
            break;
        }
        case Right: {
            return CGPointMake(distance, 0);
            break;
        }
        case Left: {
            return CGPointMake(-distance, 0);
            break;
        }
        case Down: {
            return CGPointMake(0, distance);
            break;
        }
    }
}
- (void)stop {
    for (LiquidFloatingCell *cell in self.openingCells) {
        if (self.enableShadow) {
            [cell.layer appendShadow];
        }
    }
    [self.openingCells removeAllObjects];
    self.keyDuration = 0;
    [self.displayLink invalidate];
}
- (CGFloat)easeInEaseOut:(CGFloat)t {
    if (t >= 1.0) {
        return 1.0;
    }
    if (t < 0) {
        return 0;
    }
    CGFloat t2 = t * 2;
    return -1 * t * (t - 2);
}
- (void)didDisplayRefresh:(CADisplayLink *)displayLink {
    if (self.opening) {
        self.keyDuration += (CGFloat)displayLink.duration;
        [self updateOpen];
    }
    else {
        self.keyDuration += (CGFloat)displayLink.duration;
        [self updateClose];
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
    self.engine.color = color;
    self.bigEngine.color = color;
}
- (NSMutableArray *)openingCells {
    if (!_openingCells) {
        _openingCells = [NSMutableArray array];
    }
    return _openingCells;
}
@end
