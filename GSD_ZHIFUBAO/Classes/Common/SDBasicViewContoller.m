//
//  SDBasicViewContoller.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-3.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDBasicViewContoller.h"

@implementation SDBasicViewContoller

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:5]} forState:UIControlStateNormal];
}

@end
