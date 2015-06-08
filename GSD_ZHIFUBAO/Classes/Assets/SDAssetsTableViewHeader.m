//
//  SDAssetsTableViewHeader.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

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
