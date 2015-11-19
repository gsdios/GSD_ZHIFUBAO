//
//  SDYuEBaoTableViewCell.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-5.
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


#import "SDYuEBaoTableViewCell.h"
#import "SDYuEBaoTableViewCellContentView.h"
#import "SDYuEBaoTableViewCellModel.h"

const CGFloat kSDYuEBaoTableViewCellHeight = 550.0;

@implementation SDYuEBaoTableViewCell
{
    SDYuEBaoTableViewCellContentView *_cellContentView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        SDYuEBaoTableViewCellContentView *contentView = [[SDYuEBaoTableViewCellContentView alloc] init];
        [self.contentView addSubview:contentView];
        _cellContentView = contentView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


// 重写父类方法
- (void)setModel:(NSObject *)model
{
    [super setModel:model];
    
    SDYuEBaoTableViewCellModel *cellModel = (SDYuEBaoTableViewCellModel *)model;
    
    _cellContentView.totalMoneyAmount = cellModel.totalMoneyAmount;
    _cellContentView.yesterdayIncome = cellModel.yesterdayIncome;
}

@end
