//
//  SDServiceTableViewController.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
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


#import "SDServiceTableViewController.h"
#import "SDServiceTableViewCell.h"
#import "SDServiceTableViewCellModel.h"
#import "SDServiceTableViewHeader.h"
#import "UIView+SDExtension.h"

@interface SDServiceTableViewController ()

@end

@implementation SDServiceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshMode = SDBasicTableViewControllerRefeshModeHeaderRefresh;
    
    self.tableView.rowHeight = 70;
    
    SDServiceTableViewHeader *header = [[SDServiceTableViewHeader alloc] init];
    header.sd_height = 44;
    header.placeholderText = @"搜索服务窗";
    
    self.tableView.tableHeaderView = header;
    
    self.cellClass = [SDServiceTableViewCell class];
    
    [self setupModel];
}

- (void)setupModel
{
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        SDServiceTableViewCellModel *model = [SDServiceTableViewCellModel modelWithTitle:[NSString stringWithFormat:@"服务提醒 -- %d", i] detailString:[NSString stringWithFormat:@"服务提醒摘要 -- %d", i] iconImageURLString:@"http://f.vip.duba.net/data/avatar//201309/9/328/137871226483UB.jpg"];
        [temp addObject:model];
    }

    
    self.dataArray = [temp copy];
}


#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDServiceTableViewCellModel *model = self.dataArray[indexPath.row];
    UIViewController *vc = [[SDBasicTableViewController alloc] init];
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 三个方法并用，实现自定义分割线效果
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = insets;
    }

    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:insets];
    }
    

    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
}

#pragma mark - pull down refresh

- (void)pullDownRefreshOperation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}


@end
