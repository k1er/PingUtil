//
//  PingHelper.h
//  PingUtil macOS
//
//  Created by Rudy on 2019/8/9.
//  Copyright © 2019 Rudy Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PingHelper : NSObject


/**
 init PingHelper

 @param host ip or domain
 @param timeoutInterval time out second
 @return instance of PingHelper
 */
- (instancetype)initWithHost:(NSString *)host timeoutInterval:(NSTimeInterval)timeoutInterval;

- (void)pingSuccess:(void(^)(NSUInteger delay))success
            failure:(void(^)(void))failure;

@end

NS_ASSUME_NONNULL_END
