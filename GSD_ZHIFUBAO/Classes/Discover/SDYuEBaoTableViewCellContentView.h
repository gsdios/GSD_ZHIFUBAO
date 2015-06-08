//
//  SDYuEBaoTableViewCellContentView.h
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-5.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDYuEBaoTableViewCellContentView : UIView

@property (nonatomic, assign) float yesterdayIncome;
@property (nonatomic, assign) float totalMoneyAmount;

@property (weak, nonatomic) IBOutlet UILabel *yesterdayIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyAmountLabel;

@end
