//
//  LiquittableCircle.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "LiquittableCircle.h"
@interface LiquittableCircle()
@property (nonatomic) NSMutableArray *points;/**< NSValue类型的数据，里面是CGPoint*/
@property (nonatomic) CAShapeLayer *circleLayer;

@property (nonatomic) UIColor *color;
@end
@implementation LiquittableCircle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    
    self.color = [UIColor redColor];
    self.radius = 0;
    [self setup];
    [self.layer addSublayer:self.circleLayer];
    self.opaque = NO;
    
    return self;
}
- (instancetype)initCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color {
    
    CGRect frame = CGRectMake(center.x - radius, center.y - radius, 2 * radius, 2 * radius);
    
    self = [super initWithFrame:frame];
    
    self.radius = radius;
    self.color = color;
    [self setup];
    [self.layer addSublayer:self.circleLayer];
    self.opaque = NO;
    
    return self;

}
- (void)setup {
    self.frame = CGRectMake(self.center.x - self.radius, self.center.y - self.radius, 2 * self.radius, 2* self.radius);
    [self drawCircle];
}
- (void)drawCircle {
    CGRect rect = CGRectZero;
    rect.origin = CGPointZero;
    rect.size = CGSizeMake(2 * self.radius, 2 * self.radius);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    [self draw:bezierPath];
}
- (CAShapeLayer *)draw:(UIBezierPath *)path {
    self.circleLayer.lineWidth = 3.0;
    self.circleLayer.fillColor = self.color.CGColor;
    self.circleLayer.path = path.CGPath;
    return self.circleLayer;
}
- (void)drawRect:(CGRect)rect {
    [self drawCircle];
}
- (CGPoint)circlePoint:(CGFloat)rad {
    return [CGMath circlePoint:self.center radius:self.radius rad:rad];
}
- (void)setColor:(UIColor *)color {
    _color = color;
    [self setup];
}
- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    
    self.frame = CGRectMake(self.center.x - radius, self.center.y - radius, 2 * radius, 2 * radius);
    [self setup];
}
- (NSMutableArray *)points {
    if (!_points) {
        _points = [NSMutableArray array];
    }
    return _points;
}
- (void)setCenter:(CGPoint)center {
    [super setCenter:center];
    
    self.frame = CGRectMake(center.x - self.radius, center.y - self.radius, 2 * self.radius, 2 * self.radius);
    [self setup];
}
- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer new];
    }
    return _circleLayer;
}
@end
