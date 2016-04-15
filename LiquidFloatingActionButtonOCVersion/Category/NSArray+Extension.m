//
//  NSArray+Extension.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/15.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)
- (void)each:(NSObject *)target methodName:(SEL)methodName {
    for (NSObject *object in self) {
        [target performSelector:methodName withObject:object];
    }
}
@end
