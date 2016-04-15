//
//  SimpleCircleLiquidEngine.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "SimpleCircleLiquidEngine.h"

@interface SimpleCircleLiquidEngine()
@property (nonatomic, assign) CGFloat radiusThresh;
@property (nonatomic) CALayer *layer;

@property (nonatomic, assign) CGFloat viscosity;
@property (nonatomic) UIColor *color;
@property (nonatomic, assign) CGFloat angleOpen;

@property (nonatomic, assign) CGFloat ConnectThresh;
@property (nonatomic, assign) CGFloat angleThresh;
@end
@implementation SimpleCircleLiquidEngine
- (instancetype)initWithRadiusThresh:(CGFloat)radiusThresh angleThresh:(CGFloat)angleThresh {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _layer = [CAShapeLayer new];
    _viscosity =  0.65;
    _color = [UIColor redColor];
    _angleOpen = 1.0;
    _ConnectThresh = 0.3;
    _angleThresh = 0.5;
    
    _radiusThresh = radiusThresh;
    _angleThresh = angleThresh;
    return self;
}
- (NSArray *)push:(LiquittableCircle *)circle other:(LiquittableCircle *)other {
    NSArray *paths = [self generateConnectedPath:circle other:other];
    if (paths.count) {
        NSMutableArray *layers = [NSMutableArray array];
        for (UIBezierPath *path in paths) {
            CALayer *layer = [self constructLayer:path];
            if (layer) {
                [layers addObject:layer];
            }
        }
        
        [layers each:self.layer methodName:@selector(addSublayer:)];
        return @[circle,other];
    }
    return @[];
}
- (void)draw:(UIView *)parent {
    [parent.layer addSublayer:self.layer];
}
- (void)clear {
    [self.layer removeFromSuperlayer];
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    self.layer = [CAShapeLayer new];
}
- (CALayer *)constructLayer:(UIBezierPath *)path {
    CGRect pathBounds = CGPathGetBoundingBox(path.CGPath);
    
    CAShapeLayer *shape = [CAShapeLayer new];
    shape.fillColor = self.color.CGColor;
    shape.path = path.CGPath;
    shape.frame = CGRectMake(0, 0, pathBounds.size.width, pathBounds.size.height);
    
    return shape;
}
- (NSArray *)circleConnectedPoint:(LiquittableCircle *)circle other:(LiquittableCircle *)other angle:(CGFloat)angle {
    CGPoint vec = [self minusCurrentPoint:other.center targetPoint:circle.center];
    CGFloat radian = atan2(vec.y, vec.x);
    CGPoint p1 = [circle circlePoint:(radian + angle)];
    CGPoint p2 = [circle circlePoint:(radian - angle)];
    
    NSValue *p1Value = [NSValue valueWithCGPoint:p1];
    NSValue *p2Value = [NSValue valueWithCGPoint:p2];
    
    return @[p1Value,p2Value];
}
- (NSArray *)circleConnectedPoint:(LiquittableCircle *)circle other:(LiquittableCircle *)other {
    CGFloat ratio = [self circleRatio:circle other:other];
    ratio = (ratio + self.ConnectThresh) / (1.0 + self.ConnectThresh);
    CGFloat angle = (CGFloat)M_PI_2 * self.angleOpen * ratio;
    
    return [self circleConnectedPoint:circle other:other angle:angle];
}

- (NSArray *)generateConnectedPath:(LiquittableCircle *)circle other:(LiquittableCircle *)other {
    if ([self isConnected:circle other:other]) {
        CGFloat ratio = [self circleRatio:circle other:other];
        
        if (ratio >= self.angleThresh && ratio <= 1.0) {
            
            UIBezierPath *path = [self normalPath:circle other:other];
            if (path) {
                return @[path];
            }
            return nil;
        }
        else if (ratio >= 0.0 && ratio < self.angleThresh) {
           
            return [self splitPath:circle other:other ratio:ratio];
        }
        else {
            return nil;
        }
    }
  
    return nil;
   
}

- (UIBezierPath *)normalPath:(LiquittableCircle *)circle other:(LiquittableCircle *)other {
    NSArray *pArr1 = [self circleConnectedPoint:circle other:other];
    NSArray *pArr2 = [self circleConnectedPoint:other other:circle];
    
    NSValue *p1Value = pArr1[0];
    NSValue *p2Value = pArr1[1];
    CGPoint p1 = p1Value.CGPointValue;
    CGPoint p2 = p2Value.CGPointValue;

    NSValue *p3Value = pArr2[0];
    NSValue *p4Value = pArr2[1];
    
    CGPoint p3 = p3Value.CGPointValue;
    CGPoint p4= p4Value.CGPointValue;
    
    CGPoint crossed = [self intersectionfrom:p1 to:p3 from2:p2 to2:p4];
    
    if (crossed.x == 0 && crossed.y == 0) {
        return nil;
    }
    
    __weak typeof(&*self) weakSelf = self;
    
    return [self withBezier:^(UIBezierPath *path) {
        __strong typeof(&*weakSelf) strongSelf = weakSelf;
        CGFloat r = [strongSelf circleRatio:circle other:other];
        [path moveToPoint:p1];
        CGPoint r1 = [strongSelf midCurrentPoint:p2 targetPoint:p3];
        CGPoint r2 = [strongSelf midCurrentPoint:p1 targetPoint:p4];
        
        CGFloat rate = (1 - r) / (1 - strongSelf.angleThresh) * strongSelf.viscosity;
        
        CGPoint point1 = [strongSelf midCurrentPoint:r1 targetPoint:crossed];
        CGPoint mul = [strongSelf splitCurrentPoint:point1 targetPoint:r2 ratio:rate];
        
        CGPoint point2 = [strongSelf midCurrentPoint:r2 targetPoint:crossed];
        CGPoint mul2 = [strongSelf splitCurrentPoint:point2 targetPoint:r1 ratio:rate];
        
        [path addQuadCurveToPoint:p4 controlPoint:mul];
        [path addLineToPoint:p3];
        [path addQuadCurveToPoint:p2 controlPoint:mul2];
        
    }];
    
}
- (NSArray *)splitPath:(LiquittableCircle *)circle other:(LiquittableCircle *)other ratio:(CGFloat)ratio {
    NSArray *pArr1 = [self circleConnectedPoint:circle other:other angle:[CGMath degToRad:60]];
    NSArray *pArr2 = [self circleConnectedPoint:other other:circle angle:[CGMath degToRad:60]];
    
    NSValue *p1Value = pArr1[0];
    NSValue *p2Value = pArr1[1];
    CGPoint p1 = p1Value.CGPointValue;
    CGPoint p2 = p2Value.CGPointValue;
    
    NSValue *p3Value = pArr2[0];
    NSValue *p4Value = pArr2[1];
    
    CGPoint p3 = p3Value.CGPointValue;
    CGPoint p4= p4Value.CGPointValue;
    
    CGPoint crossed = [self intersectionfrom:p1 to:p3 from2:p2 to2:p4];
    
    if (crossed.x == 0 && crossed.y == 0) {
        return @[];
    }
    
    NSArray *dArr1 = [self circleConnectedPoint:circle other:other angle:0];
    NSArray *dArr2 = [self circleConnectedPoint:other other:circle angle:0];
    NSValue *d1Value = dArr1[0];
    NSValue *_d1Value = dArr1[1];
    CGPoint d1 = d1Value.CGPointValue;
    CGPoint _d1 = _d1Value.CGPointValue;
    
    NSValue *d2Value = dArr2[0];
    NSValue *_d2Value = dArr2[1];
    
    CGPoint d2 = d2Value.CGPointValue;
    CGPoint _d2= _d2Value.CGPointValue;
    
    CGFloat r = (ratio - self.ConnectThresh) / (self.angleThresh - self.ConnectThresh);
    
    CGPoint a1 = [self splitCurrentPoint:d2 targetPoint:crossed ratio:(r * r)];
    UIBezierPath *part = [self withBezier:^(UIBezierPath *path) {
        [path moveToPoint:p1];
        [path addQuadCurveToPoint:p2 controlPoint:a1];
    }];
    
    CGPoint a2 = [self splitCurrentPoint:d1 targetPoint:crossed ratio:(r * r)];
    UIBezierPath *part2 = [self withBezier:^(UIBezierPath *path) {
        [path moveToPoint:p3];
        [path addQuadCurveToPoint:p4 controlPoint:a2];
    }];
    
    return @[part,part2];
}
- (CGFloat)circleRatio:(LiquittableCircle *)circle other:(LiquittableCircle *)other {
    CGPoint point1 = [self minusCurrentPoint:other.center targetPoint:circle.center];
    CGFloat distance = [self lengthCurrentPoint:point1];
    CGFloat ratio = 1.0 - (distance - self.radiusThresh) / (circle.radius + other.radius + self.radiusThresh);
    return MIN(MAX(ratio, 0.0), 1.0);

}
- (BOOL)isConnected:(LiquittableCircle *)circle other:(LiquittableCircle *)other {
    CGPoint point1 = [self minusCurrentPoint:circle.center targetPoint:other.center];
    
    CGFloat distance = [self lengthCurrentPoint:point1];
    return distance - circle.radius - other.radius < self.radiusThresh;
}
@end
