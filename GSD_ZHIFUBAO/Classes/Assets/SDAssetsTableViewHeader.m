//
//  SDAssetsTableViewHeader.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
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

#import "SDAssetsTableViewHeader.h"

@implementation SDAssetsTableViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    SDAssetsTableViewHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"SDAssetsTableViewHeader" owner:self options:nil] lastObject];
    if (frame.size.width != 0) {
        header.frame = frame;
    }
    return header;
}

- (IBAction)rightTopButtonClicked {
}

- (IBAction)leftButtonClicked {
}

- (IBAction)rightButtonClicked {
}
@end
