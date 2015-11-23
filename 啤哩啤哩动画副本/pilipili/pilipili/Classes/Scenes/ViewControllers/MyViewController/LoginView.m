//
//  LoginView.m
//  啤哩啤哩动画
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text andPlaceHolder:(NSString *)placeHolder{
    self = [super initWithFrame:frame];
    if(self) {
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (frame.size.height-30)/2.0, (frame.size.width-5)/3.0, 30)];
        _textLabel.text = text;
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel]; //self 当前视图类
        
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(85, (frame.size.height-30)/2.0, (frame.size.width-5)/3.0*2, 30)];
        _textField.placeholder = placeHolder;
        _textField.layer.borderWidth = 1;
        //清除按钮的样式
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //切圆角
        _textField.layer.masksToBounds = YES;
        _textField.layer.cornerRadius = 5;
        _textField.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_textField];
    }
    return self;
}

@end
