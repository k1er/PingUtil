//
//  PingHelper.m
//  PingUtil macOS
//
//  Created by Rudy on 2019/8/9.
//  Copyright © 2019 Rudy Yang. All rights reserved.
//

#import "PingHelper.h"
#import "SimplePing.h"
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>

@interface PingHelper ()<SimplePingDelegate>

@property (strong, nonatomic) SimplePing *pinger;

@property (assign, nonatomic) NSTimeInterval timeoutInterval;

@property (copy, nonatomic) void(^success)(NSUInteger delay);

@property (copy, nonatomic) void(^failure)(void);

@property (strong, nonatomic) NSDate *startDate;

@end

@implementation PingHelper

- (instancetype)initWithHost:(NSString *)host timeoutInterval:(NSTimeInterval)timeoutInterval {
    self = [super init];
    if (self) {
        self.pinger = [[SimplePing alloc] initWithHostName:host];
        [self checkIPv4OrIPv6];
        self.pinger.delegate = self;
        self.timeoutInterval = timeoutInterval;
    }
    return self;
}

- (void)pingSuccess:(void(^)(NSUInteger delay))success
            failure:(void(^)(void))failure {
    self.success = success;
    self.failure = failure;
    [self go];
}


- (void)go {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.timeoutInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endTime];
    });
    
    [self.pinger start];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    } while (self.pinger != nil);
}

#pragma mark - Finishing and timing out

// Called on success or failure to clean up
- (void)killPing {
    [self.pinger stop];
    self.pinger = nil;
}

- (void)successPing {
    NSLog(@"successPing");
    [self killPing];
    
    if (!self.startDate) {
        return;
    }
    
    NSDate *end = [NSDate date];
    double delay = [end timeIntervalSinceDate:self.startDate] * 1000.0;
    
    if (self.success) {
        self.success((NSUInteger)delay);
    }
}

- (void)failPing:(NSString*)reason {
    [self killPing];
    
    if (self.failure) {
        self.failure();
    }
}

// Called 1s after ping start, to check if it timed out
- (void)endTime {
    NSLog(@"endTime");
    if (self.pinger) { // If it hasn't already been killed, then it's timed out
        self.startDate = nil;
        if (self.failure) {
            self.failure();
        }
    }
}

#pragma mark - Pinger delegate

// When the pinger starts, send the ping immediately
- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address {
    [self.pinger sendPingWithData:nil];
    self.startDate = [NSDate date];
}

- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error {
    [self failPing:@"didFailWithError"];
}

- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet error:(NSError *)error {
    // Eg they're not connected to any network
    [self failPing:@"didFailToSendPacket"];
}

- (void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet {
    
}

- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber {
    [self successPing];
}

- (BOOL)isValidIpAddress:(NSString *)ip {
    const char *utf8 = [ip UTF8String];
    
    // Check valid IPv4.
    struct in_addr dst;
    int success = inet_pton(AF_INET, utf8, &(dst.s_addr));
    if (success != 1) {
        // Check valid IPv6.
        struct in6_addr dst6;
        success = inet_pton(AF_INET6, utf8, &dst6);
    }
    return (success == 1);
}

- (void)checkIPv4OrIPv6 {
    const char *utf8 = [self.pinger.hostName UTF8String];
    struct in_addr dst;
    int isIPv4 = inet_pton(AF_INET, utf8, &(dst.s_addr));
    
    struct in6_addr dst6;
    int isIPv6 = inet_pton(AF_INET6, utf8, &dst6);
    if (isIPv4 == 1) {
        self.pinger.addressStyle = SimplePingAddressStyleICMPv4;
    } else if (isIPv6 == 1) {
        self.pinger.addressStyle = SimplePingAddressStyleICMPv6;
    } else {
        self.pinger.addressStyle = SimplePingAddressStyleICMPv4;
    }
}

@end
