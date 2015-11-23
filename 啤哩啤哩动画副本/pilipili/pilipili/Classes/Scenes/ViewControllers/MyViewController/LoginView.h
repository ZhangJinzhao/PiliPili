//
//  LoginView.h
//  啤哩啤哩动画
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (nonatomic, retain) UILabel * textLabel;

@property (nonatomic, retain) UITextField * textField;

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text andPlaceHolder:(NSString *)placeHolder;

@end
