//
//  SDAddItemGridView.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-7.
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

#import "SDAddItemGridView.h"
#import "SDHomeGridItemModel.h"
#import "SDHomeGridViewListItemView.h"
#import "UIView+SDExtension.h"


#define kHomeGridViewPerRowItemCount 4

@implementation SDAddItemGridView
{
    NSMutableArray *_itemsArray;
    NSMutableArray *_rowSeparatorsArray;
    NSMutableArray *_columnSeparatorsArray;
    BOOL _hasAdjustedSeparators;
    CGPoint _lastPoint;
    UIButton *_placeholderButton;
    SDHomeGridViewListItemView *_currentPressedView;
    CGRect _currentPresssViewFrame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        _itemsArray = [NSMutableArray array];
        _rowSeparatorsArray = [NSMutableArray array];
        _columnSeparatorsArray = [NSMutableArray array];
        _hasAdjustedSeparators = NO;
        _placeholderButton = [[UIButton alloc] init];
    }
    return self;
}

#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemW = self.sd_width / kHomeGridViewPerRowItemCount;
    CGFloat itemH = itemW * 1.1;
    
    
    
    if (YES) {
        [self setupSubViewsFrame];
        [_rowSeparatorsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            CGFloat w = self.sd_width;
            CGFloat h = 0.4;
            CGFloat x = 0;
            CGFloat y = idx * itemH;
            view.frame = CGRectMake(x, y, w, h);
            [self bringSubviewToFront:view];
        }];
        
        [_columnSeparatorsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            CGFloat w = 0.4;
            CGFloat h = self.contentSize.height;
            CGFloat x = idx * itemW;
            CGFloat y = 0;
            view.frame = CGRectMake(x, y, w, h);
            [self bringSubviewToFront:view];
        }];
        _hasAdjustedSeparators = YES;
    }
}

#pragma mark - properties

- (void)setGridModelsArray:(NSArray *)gridModelsArray
{
    _gridModelsArray = gridModelsArray;
    
    [gridModelsArray enumerateObjectsUsingBlock:^(SDHomeGridItemModel *model, NSUInteger idx, BOOL *stop) {
        SDHomeGridViewListItemView *item = [[SDHomeGridViewListItemView alloc] init];
        item.iconImage = [UIImage imageNamed:@"app_add"];
        item.itemModel = model;
        __weak typeof(self) weakSelf = self;
        item.itemLongPressedOperationBlock = ^(UILongPressGestureRecognizer *longPressed){
            [weakSelf buttonLongPressed:longPressed];
        };
        item.iconViewClickedOperationBlock = ^(SDHomeGridViewListItemView *view){
            [weakSelf deleteView:view];
        };
        item.buttonClickedOperationBlock = ^(SDHomeGridViewListItemView *view){
            if (!_currentPressedView.hidenIcon && _currentPressedView) {
                _currentPressedView.hidenIcon = YES;
                return;
            }
            if (self.itemClickedOperationBlock) {
                self.itemClickedOperationBlock(self, [_itemsArray indexOfObject:view]);
            }
        };
        
        [self addSubview:item];
        [_itemsArray addObject:item];
    }];
    
    long rowCount = [self rowCountWithItemsCount:gridModelsArray.count];
    
    
    for (int i = 0; i < (rowCount + 1); i++) {
        UIView *rowSeparator = [[UIView alloc] init];
        rowSeparator.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:rowSeparator];
        [_rowSeparatorsArray addObject:rowSeparator];
    }
    
    for (int i = 0; i < (kHomeGridViewPerRowItemCount + 1); i++) {
        UIView *columnSeparator = [[UIView alloc] init];
        columnSeparator.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:columnSeparator];
        [_columnSeparatorsArray addObject:columnSeparator];
    }
}

#pragma mark - actions

- (NSInteger)rowCountWithItemsCount:(NSInteger)count
{
    long rowCount = (count + kHomeGridViewPerRowItemCount - 1) / kHomeGridViewPerRowItemCount;
    return rowCount;
}


- (void)buttonLongPressed:(UILongPressGestureRecognizer *)longPressed
{
    SDHomeGridViewListItemView *pressedView = (SDHomeGridViewListItemView *)longPressed.view;
    CGPoint point = [longPressed locationInView:self];

    
    
    if (longPressed.state == UIGestureRecognizerStateBegan) {
        _currentPressedView.hidenIcon = YES;
        _currentPressedView = pressedView;
        _currentPresssViewFrame = pressedView.frame;
        longPressed.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
        pressedView.hidenIcon = NO;
        long index = [_itemsArray indexOfObject:longPressed.view];
        [_itemsArray  removeObject:longPressed.view];
        [_itemsArray  insertObject:_placeholderButton atIndex:index];
        _lastPoint = point;
        [self bringSubviewToFront:longPressed.view];
    }

    
    CGRect temp = longPressed.view.frame;
    temp.origin.x += point.x - _lastPoint.x;
    temp.origin.y += point.y - _lastPoint.y;
    longPressed.view.frame = temp;
    
    _lastPoint = point;
    
    
    [_itemsArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(button.frame, point) && button != longPressed.view) {
            [_itemsArray removeObject:_placeholderButton];
            [_itemsArray insertObject:_placeholderButton atIndex:idx];
            *stop = YES;
            
            
            [UIView animateWithDuration:0.5 animations:^{
                [self setupSubViewsFrame];
            }];
        }
        
    }];
    
    
    if (longPressed.state == UIGestureRecognizerStateEnded) {
        long index = [_itemsArray indexOfObject:_placeholderButton];
        [_itemsArray removeObject:_placeholderButton];
        [_itemsArray insertObject:longPressed.view atIndex:index];
        
        [UIView animateWithDuration:0.4 animations:^{
            longPressed.view.transform = CGAffineTransformIdentity;
            [self setupSubViewsFrame];
        } completion:^(BOOL finished) {
            if (!CGRectEqualToRect(_currentPresssViewFrame, _currentPressedView.frame)) {
                _currentPressedView.hidenIcon = YES;
            }
        }];
    }
    
}

- (void)deleteView:(SDHomeGridViewListItemView *)view
{
    [_itemsArray removeObject:view];
    [view removeFromSuperview];
    [UIView animateWithDuration:0.4 animations:^{
        [self setupSubViewsFrame];
    }];
}


- (void)setupSubViewsFrame
{
    CGFloat itemW = self.sd_width / kHomeGridViewPerRowItemCount;
    CGFloat itemH = itemW * 1.1;
    [_itemsArray enumerateObjectsUsingBlock:^(UIView *item, NSUInteger idx, BOOL *stop) {
        long rowIndex = idx / kHomeGridViewPerRowItemCount;
        long columnIndex = idx % kHomeGridViewPerRowItemCount;
        
        CGFloat x = itemW * columnIndex;
        CGFloat y = itemH * rowIndex;
        item.frame = CGRectMake(x, y, itemW, itemH);
        if (idx == (_itemsArray.count - 1)) {
            self.contentSize = CGSizeMake(0, item.sd_height + item.sd_y);
        }
    }];
}

#pragma mark - scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _currentPressedView.hidenIcon = YES;
}


@end
