//
//  PingUtil.m
//  PingDemo
//
//  Created by Rudy Yang on 2017/10/13.
//  Copyright © 2017年 Rudy Yang. All rights reserved.
//

#import "PingUtil.h"
#import "PingManager.h"

@implementation PingUtil

+ (void)pingHosts:(NSArray<NSString *> *)hosts success:(void(^)(NSArray<NSNumber *>* msCounts))success failure:(void(^)(void))failure {
    NSMutableArray *msCounts = @[].mutableCopy;
    for (NSString *host in hosts) {
        PingManager *pingManager = [[PingManager alloc] init];
        [pingManager pingHost:host success:^(NSInteger msCount) {
            [msCounts addObject:@(msCount)];
        } failure:^{
            
        }];
    }
    success(msCounts);
}


@end
