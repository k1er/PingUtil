//
//  NSArray+Ext.m
//  PingUtil macOS
//
//  Created by Rudy Yang on 2017/10/30.
//  Copyright © 2017年 Rudy Yang. All rights reserved.
//

#import "NSArray+Ext.h"

@implementation NSArray (Ext)

- (NSArray *)map:(id(^)(id obj))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        [array addObject:block(obj)];
    }
    return array;
}

@end
