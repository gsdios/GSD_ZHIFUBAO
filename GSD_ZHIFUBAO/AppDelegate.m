//
//  AppDelegate.m
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

#import "AppDelegate.h"
#import "SDFrameTabBarController.h"
#import "SDGridItemCacheTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[SDFrameTabBarController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 初始化griditems
    id itemsCache = [SDGridItemCacheTool itemsArray];
    if (!itemsCache) {
        
        // 模拟数据
        NSArray *itemsArray =  @[@{@"淘宝" : @"i00"}, // title => imageString
                                 @{@"生活缴费" : @"i01"},
                                 @{@"教育缴费" : @"i02"},
                                 @{@"红包" : @"i03"},
                                 @{@"物流" : @"i04"},
                                 @{@"信用卡" : @"i05"},
                                 @{@"转账" : @"i06"},
                                 @{@"爱心捐款" : @"i07"},
                                 @{@"彩票" : @"i08"},
                                 @{@"当面付" : @"i09"},
                                 @{@"余额宝" : @"i10"},
                                 @{@"AA付款" : @"i11"},
                                 @{@"国际汇款" : @"i12"},
                                 @{@"淘点点" : @"i13"},
                                 @{@"淘宝电影" : @"i14"},
                                 @{@"亲密付" : @"i15"},
                                 @{@"股市行情" : @"i16"},
                                 @{@"汇率换算" : @"i17"}
                                 ];
        
        [SDGridItemCacheTool saveItemsArray:itemsArray];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
