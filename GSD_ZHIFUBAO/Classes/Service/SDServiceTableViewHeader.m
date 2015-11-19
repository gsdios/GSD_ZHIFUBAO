//
//  SDServiceTableViewHeader.m
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


#import "SDServiceTableViewHeader.h"
#import "UIView+SDExtension.h"

@implementation SDServiceTableViewHeader
{
    UITextField *_textField;
    UIImageView *_textFieldSearchIcon;
    UILabel *_textFieldPlaceholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.layer.cornerRadius = 5;
        textField.clipsToBounds = YES;
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:15];
        [textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.delegate = self;
        [self addSubview:textField];
        _textField = textField;
        
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_logo"]];
        searchIcon.contentMode = UIViewContentModeScaleAspectFill;
        [_textField addSubview:searchIcon];
        _textFieldSearchIcon = searchIcon;
        
        
        
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.font = _textField.font;
        placeholderLabel.textColor = [UIColor lightGrayColor];
        [_textField addSubview:placeholderLabel];
        _textFieldPlaceholderLabel = placeholderLabel;
    }
    return self;
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    
    _textFieldPlaceholderLabel.text = placeholderText;
}

- (void)layoutSubviews
{
    CGFloat margin = 8;
    _textField.frame = CGRectMake(margin, margin, self.sd_width - margin * 2, self.sd_height - margin * 2);
    

    
    [self layoutTextFieldSubviews];
    
    if (!_textField.leftView) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _textFieldSearchIcon.sd_height * 1.4, _textFieldSearchIcon.sd_height)];
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    
}

- (void)layoutTextFieldSubviews
{
    CGRect rect = [self.placeholderText boundingRectWithSize:CGSizeMake(_textField.sd_width * 0.7, _textField.sd_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _textFieldPlaceholderLabel.font} context:nil];
    _textFieldPlaceholderLabel.bounds = CGRectMake(0, 0, rect.size.width, _textField.sd_height);
    _textFieldPlaceholderLabel.center = CGPointMake(_textField.sd_width * 0.5, _textField.sd_height * 0.5);
    _textFieldSearchIcon.bounds = CGRectMake(0, 0, _textField.sd_height * 0.6, _textField.sd_height * 0.6);
    _textFieldSearchIcon.center = CGPointMake(_textFieldPlaceholderLabel.sd_x - _textFieldSearchIcon.sd_width * 0.5,  _textFieldPlaceholderLabel.center.y);
}

- (void)textFieldValueChanged:(UITextField *)field
{
    _textFieldPlaceholderLabel.hidden = (field.text.length != 0);
}

#pragma mark - textField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_textField becomeFirstResponder];
    CGFloat deltaX = _textFieldSearchIcon.sd_x - 5;
    
    [UIView animateWithDuration:0.4 animations:^{
        _textFieldSearchIcon.transform = CGAffineTransformMakeTranslation(- deltaX, 0);
        _textFieldPlaceholderLabel.transform = CGAffineTransformMakeTranslation(- deltaX, 0);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.4 animations:^{
        _textFieldSearchIcon.transform = CGAffineTransformIdentity;
        _textFieldPlaceholderLabel.transform = CGAffineTransformIdentity;
    }];
    _textField.text = @"";
    _textFieldPlaceholderLabel.hidden = NO;
}

#pragma mark - public funcs


@end
