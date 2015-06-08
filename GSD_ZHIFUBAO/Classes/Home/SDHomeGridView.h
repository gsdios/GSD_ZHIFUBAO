//
//  SDHomeGridView.h
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-3.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDHomeGridView;

@protocol SDHomeGridViewDeleate <NSObject>

@optional

- (void)homeGrideView:(SDHomeGridView *)gridView selectItemAtIndex:(NSInteger)index;
- (void)homeGrideViewmoreItemButtonClicked:(SDHomeGridView *)gridView;

@end

@interface SDHomeGridView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id<SDHomeGridViewDeleate> gridViewDelegate;
@property (nonatomic, strong) NSArray *gridModelsArray;
@property (nonatomic, strong) NSArray *scrollADImageURLStringsArray;

@end
