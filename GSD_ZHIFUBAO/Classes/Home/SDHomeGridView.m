//
//  SDHomeGridView.m
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

#import "SDHomeGridView.h"
#import "SDHomeGridItemModel.h"
#import "SDHomeGridViewListItemView.h"
#import "UIView+SDExtension.h"
#import "SDCycleScrollView.h"
#import "SDGridItemCacheTool.h"


#define kHomeGridViewPerRowItemCount 4
#define kHomeGridViewTopSectionRowCount 3

//static CGFloat value = 0;

@implementation SDHomeGridView
{
    NSMutableArray *_itemsArray;
    NSMutableArray *_rowSeparatorsArray;
    NSMutableArray *_columnSeparatorsArray;
    BOOL _shouldAdjustedSeparators;
    CGPoint _lastPoint;
    UIButton *_placeholderButton;
//    BOOL _isMoving;
//    NSTimer *_timer;
    SDHomeGridViewListItemView *_currentPressedView;
    SDCycleScrollView *_cycleScrollADView;
    UIView *_cycleScrollADViewBackgroundView;
    UIButton *_moreItemButton;
    CGRect _currentPresssViewFrame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        _itemsArray = [NSMutableArray array];
        _rowSeparatorsArray = [NSMutableArray array];
        _columnSeparatorsArray = [NSMutableArray array];
        _shouldAdjustedSeparators = NO;
        _placeholderButton = [[UIButton alloc] init];
        
        UIView *cycleScrollADViewBackgroundView = [[UIView alloc] init];
        cycleScrollADViewBackgroundView.backgroundColor = [UIColor colorWithRed:(235 / 255.0) green:(235 / 255.0) blue:(235 / 255.0) alpha:1];
        [self addSubview:cycleScrollADViewBackgroundView];
        _cycleScrollADViewBackgroundView = cycleScrollADViewBackgroundView;
        
        SDCycleScrollView *cycleView = [[SDCycleScrollView alloc] init];
        cycleView.autoScrollTimeInterval = 2.0;
        [self addSubview:cycleView];
        _cycleScrollADView = cycleView;
        
    }
    return self;
}

#pragma mark - properties

/*
 *  暂时用scrollview实现，随后用collectionview优化性能
 */

- (void)setGridModelsArray:(NSArray *)gridModelsArray
{
    _gridModelsArray = gridModelsArray;
    
    [_itemsArray removeAllObjects];
    [_rowSeparatorsArray removeAllObjects];
    [_columnSeparatorsArray removeAllObjects];
    
    [gridModelsArray enumerateObjectsUsingBlock:^(SDHomeGridItemModel *model, NSUInteger idx, BOOL *stop) {
        SDHomeGridViewListItemView *item = [[SDHomeGridViewListItemView alloc] init];
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
            if ([self.gridViewDelegate respondsToSelector:@selector(homeGrideView:selectItemAtIndex:)]) {
                [self.gridViewDelegate homeGrideView:self selectItemAtIndex:[_itemsArray indexOfObject:view]];
            }
        };

        [self addSubview:item];
        [_itemsArray addObject:item];
    }];
    
    UIButton *more = [[UIButton alloc] init];
    [more setImage:[UIImage imageNamed:@"tf_home_more"] forState:UIControlStateNormal];
    [more addTarget:self action:@selector(moreItemButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:more];
    [_itemsArray addObject:more];
    _moreItemButton = more;
    
    long rowCount = [self rowCountWithItemsCount:gridModelsArray.count];
    
    UIColor *lineColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
    for (int i = 0; i < (rowCount + 1); i++) {
        UIView *rowSeparator = [[UIView alloc] init];
        rowSeparator.backgroundColor = lineColor;
        [self addSubview:rowSeparator];
        [_rowSeparatorsArray addObject:rowSeparator];
    }
    
    for (int i = 0; i < (kHomeGridViewPerRowItemCount + 1); i++) {
        UIView *columnSeparator = [[UIView alloc] init];
        columnSeparator.backgroundColor = lineColor;
        [self addSubview:columnSeparator];
        [_columnSeparatorsArray addObject:columnSeparator];
    }
    
    _shouldAdjustedSeparators = YES;
    
    [self bringSubviewToFront:_cycleScrollADViewBackgroundView];
    [self bringSubviewToFront:_cycleScrollADView];
}

#pragma mark - actions

- (void)moreItemButtonClicked
{
    if ([self.gridViewDelegate respondsToSelector:@selector(homeGrideViewmoreItemButtonClicked:)]) {
        [self.gridViewDelegate homeGrideViewmoreItemButtonClicked:self];
    }
}

- (void)setScrollADImageURLStringsArray:(NSArray *)scrollADImageURLStringsArray
{
    _scrollADImageURLStringsArray = scrollADImageURLStringsArray;
    
    _cycleScrollADView.imageURLStringsGroup = scrollADImageURLStringsArray;
}

- (NSInteger)rowCountWithItemsCount:(NSInteger)count
{
    long rowCount = (count + kHomeGridViewPerRowItemCount - 1) / kHomeGridViewPerRowItemCount;
    rowCount = (rowCount < 4) ? 4 : ++rowCount;
    return rowCount;
}

- (void)buttonLongPressed:(UILongPressGestureRecognizer *)longPressed
{
    SDHomeGridViewListItemView *pressedView = (SDHomeGridViewListItemView *)longPressed.view;
    CGPoint point = [longPressed locationInView:self];
//    CGPoint superViewPoint = [longPressed locationInView:self.superview];
//    if (point.y >= self.sd_height - 20) {
//        [self setContentOffset:CGPointMake(0, self.contentSize.height - self.sd_height) animated:YES];
//    } else if (self.contentOffset.y == self.contentSize.height - self.sd_height) {
//        [self scrollsToTop];
//    }
    

    
    
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
 /*
    if (_isMoving) return;
    
    if ((point.y - _lastPoint.y) > 0 && point.y >= self.sd_height - 20 && self.contentOffset.y != self.contentSize.height - self.sd_height) {
        _isMoving = YES;
        NSLog(@">>>>>>>>>>> %@", NSStringFromCGPoint(point));
//        [UIView animateWithDuration:.4 animations:^{
//            self.contentOffset = CGPointMake(0, self.contentSize.height - self.sd_height);
//        }];
        value = self.contentSize.height - self.sd_height;
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(moveToValue) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    } else if ((point.y - _lastPoint.y) < 0 && point.y <= self.contentSize.height - self.sd_height + 20) {
        _isMoving = YES;
        NSLog(@">>>>>>>>>>>****** %@", NSStringFromCGPoint(point));
        [UIView animateWithDuration:.4 animations:^{
            self.contentOffset = CGPointMake(0, 0);
        }];
    }
    
*/
    
    CGRect temp = longPressed.view.frame;
    temp.origin.x += point.x - _lastPoint.x;
    temp.origin.y += point.y - _lastPoint.y;
    longPressed.view.frame = temp;
    
    _lastPoint = point;
    
    
    [_itemsArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        if (button == _moreItemButton) return;
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
        
        [self sendSubviewToBack:longPressed.view];
        
        // 保存数据
        [self saveItemsSettingCache];
        
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
    [self saveItemsSettingCache];
    [UIView animateWithDuration:0.4 animations:^{
        [self setupSubViewsFrame];
    }];
}

- (void)saveItemsSettingCache
{
    NSMutableArray *tempItemsContainer = [NSMutableArray new];
    [_itemsArray enumerateObjectsUsingBlock:^(SDHomeGridViewListItemView *button, NSUInteger idx, BOOL *stop) {
        if ([button isKindOfClass:[SDHomeGridViewListItemView class]]) {
            [tempItemsContainer addObject:@{button.itemModel.title : button.itemModel.imageResString}];
        }
    }];
    [SDGridItemCacheTool saveItemsArray:[tempItemsContainer copy]];
    if ([self.gridViewDelegate respondsToSelector:@selector(homeGrideViewDidChangeItems:)]) {
        [self.gridViewDelegate homeGrideViewDidChangeItems:self];
    }
}

/*

- (void)moveToValue
{
    static CGFloat now = 0;
    if (now >= value) {
        _isMoving = NO;
        now = 0;
        [_timer invalidate];
        _timer = nil;
        return;
    }
    self.contentOffset = CGPointMake(0, self.contentOffset.y + 1);
    now++;
    
}
 
 */

- (void)setupSubViewsFrame
{
    CGFloat itemW = self.sd_width / kHomeGridViewPerRowItemCount;
    CGFloat itemH = itemW * 1.1;
    [_itemsArray enumerateObjectsUsingBlock:^(UIView *item, NSUInteger idx, BOOL *stop) {
        long rowIndex = idx / kHomeGridViewPerRowItemCount;
        long columnIndex = idx % kHomeGridViewPerRowItemCount;
        
        CGFloat x = itemW * columnIndex;
        CGFloat y = 0;
        if (idx < kHomeGridViewPerRowItemCount * kHomeGridViewTopSectionRowCount) {
            y = itemH * rowIndex;
        } else {
            y = itemH * (rowIndex + 1);
        }
        item.frame = CGRectMake(x, y, itemW, itemH);
        if (idx == (_itemsArray.count - 1)) {
            self.contentSize = CGSizeMake(0, item.sd_height + item.sd_y);
        }
    }];
}

#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemW = self.sd_width / kHomeGridViewPerRowItemCount;
    CGFloat itemH = itemW * 1.1;
    
    [self setupSubViewsFrame];
    
    if (_shouldAdjustedSeparators) {
        
        [_rowSeparatorsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            CGFloat w = self.sd_width;
            CGFloat h = 0.4;
            CGFloat x = 0;
            CGFloat y = idx * itemH;
            view.frame = CGRectMake(x, y, w, h);
        }];
        
        [_columnSeparatorsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            CGFloat w = 0.4;
            CGFloat h = MAX(self.contentSize.height, self.sd_height);
            CGFloat x = idx * itemW;
            CGFloat y = 0;
            view.frame = CGRectMake(x, y, w, h);
        }];
        _shouldAdjustedSeparators = NO;
    }
    
    _cycleScrollADViewBackgroundView.frame = CGRectMake(0, itemH * kHomeGridViewTopSectionRowCount, self.sd_width, itemH);
    _cycleScrollADView.frame = CGRectMake(0, _cycleScrollADViewBackgroundView.sd_y + 10, self.sd_width, itemH - 10 * 2);
}

#pragma mark - scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _currentPressedView.hidenIcon = YES;
}


@end
