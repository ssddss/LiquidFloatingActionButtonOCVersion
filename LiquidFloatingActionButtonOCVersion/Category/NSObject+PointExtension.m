//
//  NSObject+PointExtension.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "NSObject+PointExtension.h"

@implementation NSObject (PointExtension)

- (CGPoint)plusCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint {
    return CGPointMake(currentPoint.x + targetPoint.x, currentPoint.y + targetPoint.y);
}
- (CGPoint)minusCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint {
    return CGPointMake(currentPoint.x - targetPoint.x, currentPoint.y - targetPoint.y);
}
- (CGPoint)minusXCurrentPoint:(CGPoint)currentPoint xDistance:(CGFloat)dx {
    return CGPointMake(currentPoint.x - dx, currentPoint.y);
}
- (CGPoint)minusYCurrentPoint:(CGPoint)currentPoint yDistance:(CGFloat)dy {
    return CGPointMake(currentPoint.x, currentPoint.y - dy);
}
- (CGPoint)mulCurrentPoint:(CGPoint)currentPoint times:(CGFloat)rhs {
    return CGPointMake(currentPoint.x * rhs, currentPoint.y * rhs);
}
- (CGPoint)divCurrentPoint:(CGPoint)currentPoint times:(CGFloat)rhs {
    return CGPointMake(currentPoint.x / rhs, currentPoint.y / rhs);
}
- (CGFloat)lengthCurrentPoint:(CGPoint)currentPoint {
    return sqrt(currentPoint.x * currentPoint.x + currentPoint.y * currentPoint.y);
}
- (CGPoint)normalizedCurrentPoint:(CGPoint)currentPoint {
    return [self divCurrentPoint:currentPoint times:[self lengthCurrentPoint:currentPoint]];
}
- (CGFloat)dotCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint {
    return currentPoint.x * targetPoint.x + currentPoint.y * targetPoint.y;
}
- (CGFloat)crossCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint {
    return currentPoint.x * targetPoint.y - currentPoint.y * targetPoint.x;
}
- (CGPoint)splitCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint ratio:(CGFloat)ratio {
    CGPoint point1 = [self mulCurrentPoint:currentPoint times:ratio];
    CGPoint point2 = [self mulCurrentPoint:targetPoint times:1.0 - ratio];
    CGPoint point3 = [self plusCurrentPoint:point1 targetPoint:point2];
    return point3;
}
- (CGPoint)midCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint {
    return [self splitCurrentPoint:currentPoint targetPoint:targetPoint ratio:0.5];
}
- (CGPoint)intersectionfrom:(CGPoint)from to:(CGPoint)to from2:(CGPoint)from2 to2:(CGPoint)to2 {
    CGPoint ac = CGPointMake(to.x - from.x, to.y - from.y);
    CGPoint bd = CGPointMake(to2.x - from2.x, to2.y - from2.y);
    CGPoint ab = CGPointMake(from2.x - from.x, from2.y - from.y);
    CGPoint bc = CGPointMake(to.x - from2.x, to.y - from2.y);
    
    CGFloat area = [self crossCurrentPoint:bd targetPoint:ab];
    CGFloat area2 = [self crossCurrentPoint:bd targetPoint:bc];
    
    if (fabs(area + area2) >= 0.1) {
        CGFloat ratio = area / (area + area2);
        return CGPointMake(from.x + ratio * ac.x, from.y + ratio * ac.y);
    }
    
    //Swift中是nil可选值，要注意判断
    return CGPointZero;
}

- (CGPoint)rightBottomOfRect:(CGRect)rect {
    return CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
}
- (CGPoint)centerOfRect:(CGRect)rect {
    CGPoint point1 = [self plusCurrentPoint:rect.origin targetPoint:[self rightBottomOfRect:rect]];
    
    return [self mulCurrentPoint:point1 times:0.5];
}
@end
