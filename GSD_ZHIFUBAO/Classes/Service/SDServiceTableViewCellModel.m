//
//  SDServiceTableViewCellModel.m
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


#import "SDServiceTableViewCellModel.h"

@implementation SDServiceTableViewCellModel

+ (instancetype)modelWithTitle:(NSString *)title detailString:(NSString *)detailString iconImageURLString:(NSString *)iconImageURLString
{
    SDServiceTableViewCellModel *model = [[SDServiceTableViewCellModel alloc] init];
    model.title = title;
    model.detailString = detailString;
    model.iconImageURLString = iconImageURLString;
    return model;
}

@end
