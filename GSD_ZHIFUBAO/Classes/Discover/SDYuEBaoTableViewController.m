//
//  SDYuEBaoTableViewController.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-6.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

/*
 
 *********************************************************************************
 *
 * 在您使用此自动布局库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * 新浪微博:GSD_iOS
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios
 *
 *********************************************************************************
 
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
