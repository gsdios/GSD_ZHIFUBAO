//
//  SDYuEBaoTableViewController.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-6.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

/**
 
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到gsdios@126.com 或者 到                       *
 * https://github.com/gsdios?tab=repositories 提交问题     *
 *                                                      *
 *******************************************************
 
 */

#import "SDYuEBaoTableViewController.h"
#import "SDYuEBaoTableViewCell.h"
#import "SDYuEBaoTableViewCellModel.h"

@interface SDYuEBaoTableViewController ()

@end

@implementation SDYuEBaoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellClass = [SDYuEBaoTableViewCell class];
    
    SDYuEBaoTableViewCellModel *model = [[SDYuEBaoTableViewCellModel alloc] init];
    model.totalMoneyAmount = 8060.68;
    model.yesterdayIncome = 1.12;
    self.dataArray = @[model];
    
    self.refreshMode = SDBasicTableViewControllerRefeshModeHeaderRefresh;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

// 加载数据方法

- (void)pullDownRefreshOperation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSDYuEBaoTableViewCellHeight;
}


extern const CGFloat kSDYuEBaoTableViewCellHeight;


@end
