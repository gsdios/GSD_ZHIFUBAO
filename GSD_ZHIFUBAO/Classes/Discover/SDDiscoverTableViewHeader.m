//
//  SDDiscoverTableViewHeader.m
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


#import "SDDiscoverTableViewHeader.h"
#import "SDDiscoverTableViewHeaderItemButton.h"
#import "UIView+SDExtension.h"



@implementation SDDiscoverTableViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setHeaderItemModelsArray:(NSArray *)headerItemModelsArray
{
    _headerItemModelsArray = headerItemModelsArray;
    
    [headerItemModelsArray enumerateObjectsUsingBlock:^(SDDiscoverTableViewHeaderItemModel *model, NSUInteger idx, BOOL *stop) {
        SDDiscoverTableViewHeaderItemButton *button = [[SDDiscoverTableViewHeaderItemButton alloc] init];
        button.tag = idx;
        button.title = model.title;
        button.imageName = model.imageName;
        [button addTarget:self action:@selector(buttonClickd:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.subviews.count == 0) return;
    CGFloat w = self.sd_width / self.subviews.count;
    CGFloat h = self.sd_height;
    [self.subviews enumerateObjectsUsingBlock:^(UIView *button, NSUInteger idx, BOOL *stop) {
        button.frame = CGRectMake(idx * w, 0, w, h);
    }];
}

- (void)buttonClickd:(SDDiscoverTableViewHeaderItemButton *)button
{
    if (self.buttonClickedOperationBlock) {
        self.buttonClickedOperationBlock(button.tag);
    }
}

@end


@implementation SDDiscoverTableViewHeaderItemModel

+ (instancetype)modelWithTitle:(NSString *)title imageName:(NSString *)imageName destinationControllerClass:(Class)destinationControllerClass
{
    SDDiscoverTableViewHeaderItemModel *model = [[SDDiscoverTableViewHeaderItemModel alloc] init];
    model.title = title;
    model.imageName = imageName;
    model.destinationControllerClass = destinationControllerClass;
    return model;
}

@end