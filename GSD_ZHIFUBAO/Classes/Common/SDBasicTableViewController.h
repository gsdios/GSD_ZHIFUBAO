//
//  SDBasicTableViewController.h
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

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SDBasicTableViewControllerRefeshModeNone                    = 0,
    SDBasicTableViewControllerRefeshModeHeaderRefresh           = 1 << 0,
    SDBasicTableViewControllerRefeshModeFooterRefresh           = 1 << 1
} SDBasicTableViewControllerRefeshMode;

@interface SDBasicTableViewController : UITableViewController

@property (nonatomic, assign) NSInteger sectionsNumber;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) Class cellClass;
@property (nonatomic, copy) Class cellModelClass;
@property (nonatomic, assign) SDBasicTableViewControllerRefeshMode refreshMode;


// 如果需要刷新，子类须重写此方法
- (void)pullDownRefreshOperation;
@end


