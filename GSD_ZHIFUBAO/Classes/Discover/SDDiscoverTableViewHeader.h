//
//  SDDiscoverTableViewHeader.h
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-5.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDDiscoverTableViewHeader : UIView

@property (nonatomic, strong) NSArray *headerItemModelsArray;

@property (nonatomic, copy) void (^buttonClickedOperationBlock)(NSInteger index);

@end

// --------------------------SDDiscoverTableViewHeaderItemModel-----------

@interface SDDiscoverTableViewHeaderItemModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) Class destinationControllerClass;

+ (instancetype)modelWithTitle:(NSString *)title imageName:(NSString *)imageName destinationControllerClass:(Class)destinationControllerClass;

@end