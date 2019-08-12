//
//  PingUtil.m
//  PingUtil
//
//  Created by Rudy Yang on 2017/10/18.
//  Copyright © 2017年 Rudy Yang. All rights reserved.
//

#import "PingUtil.h"
#import "PingHelper.h"

@interface PingUtil ()

@property (strong, nonatomic) NSMutableArray *pingTaskList;

@end

@implementation PingUtil

+ (instancetype)sharePingUtil {
    static PingUtil *pingUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!pingUtil) {
            pingUtil = [[PingUtil alloc] init];
            pingUtil.pingTaskList = @[].mutableCopy;
        }
    });
    return pingUtil;
}

+ (void)pingHost:(NSString *)host
 timeoutInterval:(NSTimeInterval)timeoutInterval
         success:(void(^)(NSInteger delayMs))success
         failure:(void(^)(void))failure {
    PingHelper *pingHelper = [[PingHelper alloc] initWithHost:host timeoutInterval:timeoutInterval > 0 ? timeoutInterval : 1];
    NSMutableArray *list = [PingUtil sharePingUtil].pingTaskList;
    [list addObject:pingHelper];

    __weak __typeof(pingHelper) weakPingHeler = pingHelper;
    [pingHelper pingSuccess:^(NSUInteger delay) {
        [list removeObject:weakPingHeler];
        success(delay);
    } failure:^{
        [list removeObject:weakPingHeler];
        failure();
    }];
}

@end
