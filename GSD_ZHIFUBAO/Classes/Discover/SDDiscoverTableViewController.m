//
//  SDDiscoverTableViewController.m
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


#import "SDDiscoverTableViewController.h"
// 重用 SDAssetsTableViewController 的 cell 和 model
#import "SDAssetsTableViewControllerCell.h"
#import "SDAssetsTableViewControllerCellModel.h"

#import "SDDiscoverTableViewHeader.h"
#import "UIView+SDExtension.h"

@interface SDDiscoverTableViewController ()

@property (nonatomic, strong) NSArray *headerDataArray;

@end

@implementation SDDiscoverTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.cellClass = [SDAssetsTableViewControllerCell class];
    
    [self setupHeader];
    
    [self setupModel];
    
    self.sectionsNumber = self.dataArray.count;
    
}

- (void)setupHeader
{
    SDDiscoverTableViewHeaderItemModel *model0 = [SDDiscoverTableViewHeaderItemModel modelWithTitle:@"红包" imageName:@"adw_icon_apcoupon_normal" destinationControllerClass:[SDBasicTableViewController class]];
    
    SDDiscoverTableViewHeaderItemModel *model1 = [SDDiscoverTableViewHeaderItemModel modelWithTitle:@"电子券" imageName:@"adw_icon_coupon_normal" destinationControllerClass:[SDBasicTableViewController class]];
    
    SDDiscoverTableViewHeaderItemModel *model2 = [SDDiscoverTableViewHeaderItemModel modelWithTitle:@"行程单" imageName:@"adw_icon_travel_normal" destinationControllerClass:[SDBasicTableViewController class]];
    
    SDDiscoverTableViewHeaderItemModel *model3 = [SDDiscoverTableViewHeaderItemModel modelWithTitle:@"会员卡" imageName:@"adw_icon_membercard_normal" destinationControllerClass:[SDBasicTableViewController class]];
    
    self.headerDataArray = @[model0, model1, model2, model3];
    
    
    SDDiscoverTableViewHeader *header = [[SDDiscoverTableViewHeader alloc] init];
    header.sd_height = 90;
    header.headerItemModelsArray = self.headerDataArray;
    __weak typeof(self) weakSelf = self;
    header.buttonClickedOperationBlock = ^(NSInteger index){
        SDDiscoverTableViewHeaderItemModel *model = weakSelf.headerDataArray[index];
        UIViewController *vc = [[model.destinationControllerClass alloc] init];
        vc.title = model.title;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView = header;
}

- (void)setupModel
{
    // section 0 的model
    SDAssetsTableViewControllerCellModel *model01 = [SDAssetsTableViewControllerCellModel modelWithTitle:@"淘宝电影" iconImageName:@"adw_icon_movie_normal" destinationControllerClass:[SDBasicTableViewController class]];
    
    SDAssetsTableViewControllerCellModel *model02 = [SDAssetsTableViewControllerCellModel modelWithTitle:@"快抢" iconImageName:@"adw_icon_flashsales_normal" destinationControllerClass:[SDBasicTableViewController class]];
    
    SDAssetsTableViewControllerCellModel *model03 = [SDAssetsTableViewControllerCellModel modelWithTitle:@"快的打车" iconImageName:@"adw_icon_taxi_normal" destinationControllerClass:[SDBasicTableViewController class]];
    
    // section 1 的model
    SDAssetsTableViewControllerCellModel *model11 = [SDAssetsTableViewControllerCellModel modelWithTitle:@"我的朋友" iconImageName:@"adw_icon_contact_normal" destinationControllerClass:[SDBasicTableViewController class]];
    

    
    self.dataArray = @[@[model01, model02, model03],
                       @[model11]
                       ];
}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDAssetsTableViewControllerCellModel *model = [self.dataArray[indexPath.section] objectAtIndex:indexPath.row];
    UIViewController *vc = [[model.destinationControllerClass alloc] init];
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == self.dataArray.count - 1) ? 10 : 0;
}


@end
