//
//  NJItemTableViewController.m
//  BehaviourDemo
//
//  Created by joehsieh on 2015/10/27.
//  Copyright © 2015年 JH. All rights reserved.
//

#import "NJItemTableViewController.h"
#import "UITableViewController+ScrollToFullScreenEffect.h"

static NSString *const kCellIdentifier = @"kCellIdentifier";

@interface NJItemTableViewController ()
@end

@implementation NJItemTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Items";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NJItemTableViewController *vc = [[NJItemTableViewController alloc] init];
    vc.tableView.dataSource = vc;
    [vc applyScrollToFullScreenEffect];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
