//
//  SDHomeGridView.h
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-3.
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


#import <UIKit/UIKit.h>

@class SDHomeGridView;

@protocol SDHomeGridViewDeleate <NSObject>

@optional

- (void)homeGrideView:(SDHomeGridView *)gridView selectItemAtIndex:(NSInteger)index;
- (void)homeGrideViewmoreItemButtonClicked:(SDHomeGridView *)gridView;
- (void)homeGrideViewDidChangeItems:(SDHomeGridView *)gridView;

@end

@interface SDHomeGridView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id<SDHomeGridViewDeleate> gridViewDelegate;
@property (nonatomic, strong) NSArray *gridModelsArray;
@property (nonatomic, strong) NSArray *scrollADImageURLStringsArray;

@end
