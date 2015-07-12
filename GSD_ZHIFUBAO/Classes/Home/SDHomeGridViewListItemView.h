//
//  SDHomeGridViewListItemView.h
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

#import <UIKit/UIKit.h>

@class SDHomeGridItemModel;

@interface SDHomeGridViewListItemView : UIView

@property (nonatomic, strong) SDHomeGridItemModel *itemModel;
@property (nonatomic, assign) BOOL hidenIcon;

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, copy) void (^itemLongPressedOperationBlock)(UILongPressGestureRecognizer *longPressed);
@property (nonatomic, copy) void (^buttonClickedOperationBlock)(SDHomeGridViewListItemView *item);
@property (nonatomic, copy) void (^iconViewClickedOperationBlock)(SDHomeGridViewListItemView *view);

@end
