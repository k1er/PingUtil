//
//  Host.h
//  PingUtil macOS
//
//  Created by Rudy Yang on 2017/10/30.
//  Copyright © 2017年 Rudy Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Host : NSObject

@property (strong, nonatomic) NSString *ip;
@property (assign, nonatomic) NSInteger 
ping;

+ (NSArray<Host *> *)testHostList;

@end
