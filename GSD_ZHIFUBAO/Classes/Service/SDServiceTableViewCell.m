//
//  SDServiceTableViewCell.m
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


#import "SDServiceTableViewCell.h"
#import "SDServiceTableViewCellModel.h"
#import "UIImageView+WebCache.h"

@implementation SDServiceTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    SDServiceTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SDServiceTableViewCell" owner:nil options:nil] lastObject];
    cell.iconView.layer.cornerRadius = 4;
    cell.iconView.clipsToBounds = YES;

    return cell;
}

- (void)setModel:(NSObject *)model
{
    [super setModel:model];
    
    SDServiceTableViewCellModel *cellModel = (SDServiceTableViewCellModel *)model;
    
    self.titleLabel.text = cellModel.title;
    self.detailLabel.text = cellModel.detailString;
    [self.iconView setImageWithURL:[NSURL URLWithString:cellModel.iconImageURLString] placeholderImage:nil];
}

@end
