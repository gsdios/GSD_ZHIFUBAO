//
//  SDFrameTabBarController.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-3.
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

#import "SDFrameTabBarController.h"
#import "SDBasicNavigationController.h"
#import "SDBasicViewContoller.h"
#import "SDHomeViewController.h"
#import "SDAssetsTableViewController.h"
#import "SDServiceTableViewController.h"
#import "SDDiscoverTableViewController.h"

@implementation SDFrameTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildControllers];
}

- (void)setupChildControllers
{
    [self setupChildNavigationControllerWithClass:[SDBasicNavigationController class] tabBarImageName:@"TabBar_HomeBar" rootViewControllerClass:[SDHomeViewController class] rootViewControllerTitle:@"支付宝"];
    
    [self setupChildNavigationControllerWithClass:[SDBasicNavigationController class] tabBarImageName:@"TabBar_PublicService" rootViewControllerClass:[SDServiceTableViewController class] rootViewControllerTitle:@"服务窗"];
    
    [self setupChildNavigationControllerWithClass:[SDBasicNavigationController class] tabBarImageName:@"TabBar_Discovery" rootViewControllerClass:[SDDiscoverTableViewController class] rootViewControllerTitle:@"发现"];
    
    [self setupChildNavigationControllerWithClass:[SDBasicNavigationController class] tabBarImageName:@"TabBar_Assets" rootViewControllerClass:[SDAssetsTableViewController class] rootViewControllerTitle:@"财富"];
    
}

- (void)setupChildNavigationControllerWithClass:(Class)class tabBarImageName:(NSString *)name rootViewControllerClass:(Class)rootViewControllerClass rootViewControllerTitle:(NSString *)title
{
    UIViewController *rootVC = [[rootViewControllerClass alloc] init];
    rootVC.title = title;
    UINavigationController *navVc = [[class  alloc] initWithRootViewController:rootVC];
    navVc.tabBarItem.image = [UIImage imageNamed:name];
    navVc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Sel", name]];
    [self addChildViewController:navVc];
}
@end
