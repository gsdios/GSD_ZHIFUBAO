//
//  SDServiceTableViewCellModel.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

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
