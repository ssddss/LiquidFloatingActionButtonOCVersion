//
//  NSArray+Extension.h
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)
- (void)each:(NSObject *)target methodName:(SEL)methodName;
@end
