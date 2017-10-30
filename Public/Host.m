//
//  Host.m
//  PingUtil macOS
//
//  Created by Rudy Yang on 2017/10/30.
//  Copyright © 2017年 Rudy Yang. All rights reserved.
//

#import "Host.h"

@implementation Host

- (NSString *)description {
    NSString *ping = self.ping > 0 ? @(self.ping).stringValue : @"超时";
    if (ping == 0) {
        ping = @"--";
    }
    return [NSString stringWithFormat:@"%@: %@", self.ip, ping];
}

+ (NSArray<Host *> *)testHostList {
    Host *host1 = [[Host alloc] init];
    host1.ip = @"www.google.com";
    
    Host *host2 = [[Host alloc] init];
    host2.ip = @"baidu.com";
    
    Host *host3 = [[Host alloc] init];
    host3.ip = @"fl-us-ping.vultr.com";
    return @[host1, host2, host3];
}

@end
