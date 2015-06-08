//
//  SDServiceTableViewCellModel.h
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDServiceTableViewCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailString;
@property (nonatomic, copy) NSString *iconImageURLString;

+ (instancetype)modelWithTitle:(NSString *)title detailString:(NSString *)detailString iconImageURLString:(NSString *)iconImageURLString;

@end
