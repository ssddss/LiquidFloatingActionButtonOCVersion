//
//  NSObject+PointExtension.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (PointExtension)
/**
 *  足し算,加法
 *
 *  @param currentPoint <#currentPoint description#>
 *  @param targetPoint  <#targetPoint description#>
 *
 *  @return <#return value description#>
 */
- (CGPoint)plusCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint;
/**
 *  引き算，减法
 *
 *  @param currentPoint <#currentPoint description#>
 *  @param targetPoint  <#targetPoint description#>
 *
 *  @return <#return value description#>
 */
- (CGPoint)minusCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint;
/**
 *  x方向减
 *
 *  @param currentPoint <#currentPoint description#>
 *  @param dx           <#dx description#>
 *
 *  @return <#return value description#>
 */
- (CGPoint)minusXCurrentPoint:(CGPoint)currentPoint xDistance:(CGFloat)dx;
- (CGPoint)minusYCurrentPoint:(CGPoint)currentPoint yDistance:(CGFloat)dy;
/**
 *  掛け算,乘法
 *
 *  @param currentPoint <#currentPoint description#>
 *
 *  @return <#return value description#>
 */
- (CGPoint)mulCurrentPoint:(CGPoint)currentPoint times:(CGFloat)rhs;
/**
 *  除法
 *
 *  @param currentPoint <#currentPoint description#>
 *  @param rhs          <#rhs description#>
 *
 *  @return <#return value description#>
 */
- (CGPoint)divCurrentPoint:(CGPoint)currentPoint times:(CGFloat)rhs;
/**
 *  长度
 *
 *  @param currentPoint
 *
 *  @return 
 */
- (CGFloat)lengthCurrentPoint:(CGPoint)currentPoint;
/**
 *  正規化
 *
 *  @param currentPoint <#currentPoint description#>
 *
 *  @return <#return value description#>
 */
- (CGPoint)normalizedCurrentPoint:(CGPoint)currentPoint;
/**
 *  内積
 *
 *  @param currentPoint <#currentPoint description#>
 *  @param targetPoint  <#targetPoint description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)dotCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint;
/**
 *  外积
 *
 *  @param currentPoint <#currentPoint description#>
 *  @param targetPoint  <#targetPoint description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)crossCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint;

- (CGPoint)splitCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint ratio:(CGFloat)ratio;

- (CGPoint)midCurrentPoint:(CGPoint)currentPoint targetPoint:(CGPoint)targetPoint;
- (CGPoint)intersectionfrom:(CGPoint)from to:(CGPoint)to from2:(CGPoint)from2 to2:(CGPoint)to2;

- (CGPoint)rightBottomOfRect:(CGRect)rect;

- (CGPoint)centerOfRect:(CGRect)rect;
@end
