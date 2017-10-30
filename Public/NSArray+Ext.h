//
//  NSArray+Ext.h
//  PingUtil macOS
//
//  Created by Rudy Yang on 2017/10/30.
//  Copyright © 2017年 Rudy Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Ext)
- (NSArray *)map:(id(^)(id obj))block;
@end
