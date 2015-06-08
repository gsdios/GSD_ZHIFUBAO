//
//  SDAddItemGridView.h
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-7.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDAddItemGridView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *gridModelsArray;

@property (nonatomic, copy) void (^itemClickedOperationBlock)(SDAddItemGridView *gridView, NSInteger index);

@end
