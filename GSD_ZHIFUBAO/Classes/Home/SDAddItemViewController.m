//
//  SDAddItemViewController.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-7.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

/**
 
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到gsdios@126.com 或者 到                       *
 * https://github.com/gsdios?tab=repositories 提交问题     *
 *                                                      *
 *******************************************************
 
 */

#import "SDAddItemViewController.h"
#import "SDAddItemGridView.h"
#import "SDHomeGridItemModel.h"

@interface SDAddItemViewController ()

@property (nonatomic, weak) SDAddItemGridView *mainView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SDAddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainView];
    
}

- (void)setupMainView
{
    SDAddItemGridView *mainView = [[SDAddItemGridView alloc] initWithFrame:self.view.bounds];
    mainView.showsVerticalScrollIndicator = NO;
    
    NSArray *titleArray = @[@"淘宝",
                            @"生活缴费",
                            @"教育缴费",
                            @"红包",
                            @"物流",
                            @"信用卡",
                            @"转账",
                            @"爱心捐款",
                            @"彩票",
                            @"当面付",
                            @"余额宝",
                            @"AA付款",
                            @"国际汇款",
                            @"淘点点",
                            @"淘宝电影",
                            @"亲密付",
                            @"股市行情",
                            @"汇率换算",
                            ];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 18; i++) {
        SDHomeGridItemModel *model = [[SDHomeGridItemModel alloc] init];
        model.destinationClass = [SDBasicViewContoller class];
        model.imageResString = [NSString stringWithFormat:@"i%02d", i];
        model.title = titleArray[i];
        [temp addObject:model];
    }
    
    _dataArray = [temp copy];
    mainView.gridModelsArray = [temp copy];

    [self.view addSubview:mainView];
    _mainView = mainView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
