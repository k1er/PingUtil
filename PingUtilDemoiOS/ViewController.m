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
    for (Host *host in self.hostList) {
        [PingUtil pingHost:host.ip
           timeoutInterval:0.05
                   success:^(NSInteger delayMs) {
                       host.ping = delayMs;
                       [self.tableView reloadData];
                   } failure:^{
                       [self.tableView reloadData];
                   }];
//        break;
    }
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
