//
//  SDHomeViewController.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-3.
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


#import "SDHomeViewController.h"
#import "UIView+SDExtension.h"
#import "SDHomeGridView.h"
#import "SDHomeGridItemModel.h"
#import "SDScanViewController.h"
#import "SDAddItemViewController.h"

#define kHomeHeaderViewHeight 110

@interface SDHomeViewController () <SDHomeGridViewDeleate>

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) SDHomeGridView *mainView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SDHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupHeader];
    [self setupMainView];
}

- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    header.bounds = CGRectMake(0, 0, self.view.sd_width, kHomeHeaderViewHeight);
    header.backgroundColor = [UIColor colorWithRed:(38 / 255.0) green:(42 / 255.0) blue:(59 / 255.0) alpha:1];
    [self.view addSubview:header];
    _headerView = header;
    
    UIButton *scan = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, header.sd_width * 0.5, header.sd_height)];
    [scan setImage:[UIImage imageNamed:@"home_scan"] forState:UIControlStateNormal];
    [scan addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:scan];
    
    UIButton *pay = [[UIButton alloc] initWithFrame:CGRectMake(scan.sd_width, 0, header.sd_width * 0.5, header.sd_height)];
    [pay setImage:[UIImage imageNamed:@"home_pay"] forState:UIControlStateNormal];
    [header addSubview:pay];
    
    
}

- (void)scanButtonClicked
{

    SDBasicViewContoller *desVc = [[SDScanViewController alloc] init];
    [self.navigationController pushViewController:desVc animated:YES];
}

- (void)setupMainView
{
    SDHomeGridView *mainView = [[SDHomeGridView alloc] init];
    mainView.gridViewDelegate = self;
    mainView.showsVerticalScrollIndicator = NO;
    
    NSArray *titleArray = @[@"淘宝",
                            @"生活缴费",
                            @"教育缴费",
                            @"红包",
                            @"物流",
                            @"信用卡",
                            @"转账",
                            @"爱心捐款",
                            @"彩票",
                            @"当面付",
                            @"余额宝",
                            @"AA付款",
                            @"国际汇款",
                            @"淘点点",
                            @"淘宝电影",
                            @"亲密付",
                            @"股市行情",
                            @"汇率换算",
                            ];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 18; i++) {
        SDHomeGridItemModel *model = [[SDHomeGridItemModel alloc] init];
        model.destinationClass = [SDBasicViewContoller class];
        model.imageResString = [NSString stringWithFormat:@"i%02d", i];
        model.title = titleArray[i];
        [temp addObject:model];
    }
    
    _dataArray = [temp copy];
    mainView.gridModelsArray = [temp copy];
    mainView.scrollADImageURLStringsArray = @[@"http://ww3.sinaimg.cn/bmiddle/9d857daagw1er7lgd1bg1j20ci08cdg3.jpg",
                                              @"http://ww4.sinaimg.cn/bmiddle/763cc1a7jw1esr747i13xj20dw09g0tj.jpg",
                                              @"http://ww4.sinaimg.cn/bmiddle/67307b53jw1esr4z8pimxj20c809675d.jpg"];
    [self.view addSubview:mainView];
    _mainView = mainView;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat tabbarHeight = [[self.tabBarController tabBar] sd_height];
    
    CGFloat headerY = 0;
    headerY = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) ? 64 : 0;
    _headerView.frame = CGRectMake(0, headerY, self.view.sd_width, kHomeHeaderViewHeight);
    
    _mainView.frame = CGRectMake(0, _headerView.sd_y + kHomeHeaderViewHeight, self.view.sd_width, self.view.sd_height - kHomeHeaderViewHeight - tabbarHeight);
}


#pragma mark - SDHomeGridViewDeleate 

- (void)homeGrideView:(SDHomeGridView *)gridView selectItemAtIndex:(NSInteger)index
{
    SDHomeGridItemModel *model = _dataArray[index];
    UIViewController *vc = [[model.destinationClass alloc] init];
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)homeGrideViewmoreItemButtonClicked:(SDHomeGridView *)gridView
{
    SDAddItemViewController *addVc = [[SDAddItemViewController alloc] init];
    addVc.title = @"添加更多";
    [self.navigationController pushViewController:addVc animated:YES];
}


@end
