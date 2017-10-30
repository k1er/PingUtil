## PingUtil
[![CocoaPods](https://img.shields.io/cocoapods/v/XYPingUtil.svg)]()

PingUtil is a simple ping util.

## How To Get Started

- [Download PingUtil](https://github.com/k1er/PingUtil/archive/master.zip) and try out the included Mac and iPhone example apps

## Installation
PingUtil supports cocoapods for installing the library in a project.

```
pod 'XYPingUtil'
```

## Api
```
NSArray *ipList = @[@"google.com", @"baidu.com", @"119.28.87.227"];
    
[PingUtil pingHosts:ipList success:^(NSArray<NSNumber *> *msCounts) {
       
} failure:^{
        
}];
```
