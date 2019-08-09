//
//  PingHelper.m
//  PingUtil macOS
//
//  Created by Rudy on 2019/8/9.
//  Copyright © 2019 Rudy Yang. All rights reserved.
//

#import "PingHelper.h"
#import "SimplePing.h"

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
    [self.pinger start];
//    [self performSelector:@selector(endTime) withObject:nil afterDelay:self.timeoutInterval];
}

#pragma mark - Finishing and timing out

// Called on success or failure to clean up
- (void)killPing {
    [self.pinger stop];
    self.pinger = nil;
}

- (void)successPing {
    [self killPing];
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
    if (self.pinger) { // If it hasn't already been killed, then it's timed out
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

- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet {
    [self successPing];
}

@end
