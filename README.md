## PingUtil
[![CocoaPods](https://img.shields.io/cocoapods/v/XYPingUtil.svg)]()

PingUtil is a simple ping util for iOS/macOS.

## How To Get Started

- [Download PingUtil](https://github.com/k1er/PingUtil/archive/master.zip) and try out the included Mac and iPhone example apps

## Installation
PingUtil supports cocoapods for installing the library in a project.

```
pod 'XYPingUtil'
```

## Api
```
[PingUtil pingHost:@"google.com"
    timeoutInterval:0.05
            success:^(NSInteger delayMs) {
                     
            } failure:^{
                     
            }];
```
