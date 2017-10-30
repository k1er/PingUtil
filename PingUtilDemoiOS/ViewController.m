//
//  ViewController.m
//  PingUtilDemoiOS
//
//  Created by Rudy Yang on 2017/10/30.
//  Copyright © 2017年 Rudy Yang. All rights reserved.
//

#import "ViewController.h"
#import "PingUtil.h"
#import "Host.h"
#import "NSArray+Ext.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<Host *> *hostList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.hostList = [Host testHostList];
    [self refreshPing];
}

- (IBAction)clickPingButton:(UIButton *)sender {
    [self refreshPing];
}

- (void)refreshPing {
    NSArray *ipList = [self.hostList map:^NSString *(Host *host) {
        return host.ip;
    }];
    
    [PingUtil pingHosts:ipList success:^(NSArray<NSNumber *> *msCounts) {
        [self.hostList map:^id(Host *host) {
            host.ping = [msCounts[[self.hostList indexOfObject:host]] integerValue];
            return host;
        }];
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hostList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.hostList[indexPath.row] description];
    return cell;
}

@end
