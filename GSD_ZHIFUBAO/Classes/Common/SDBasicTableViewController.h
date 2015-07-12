//
//  SDBasicTableViewController.h
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
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


