//
//  LoginViewController.m
//  啤哩啤哩动画
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //R:247 B:145  G:135
    UIColor *customColor = [UIColor colorWithRed:247.0/255.0 green:135.0/255.0 blue:145.0/255.0 alpha:1];
    self.view.backgroundColor = customColor;
    
    NSArray *text = @[@"用户名",@"密码"];
    NSArray *placeHolder = @[@"请输入用户名",@"请输入密码"];
    //用LTView创建用户名和密码栏
    for (int i = 0; i < 2; i++){
        LoginView *log = [[LoginView alloc]initWithFrame:CGRectMake(65, 100+50*i, 245, 50) andText:text[i] andPlaceHolder:placeHolder[i]];
        log.textField.delegate = self;
        log.textField.tag = 500 + i;
        if(i == 1){
            log.textField.secureTextEntry = YES;
            log.textField.returnKeyType = UIReturnKeyGo;
        }else{
            log.textField.returnKeyType = UIReturnKeyNext;
        }
        log.backgroundColor = [UIColor clearColor];
        [self.view addSubview:log];
    }
    //设置按钮
    NSArray *title = @[@"登陆",@"注册"];
    for (int i = 0; i < 2; i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame =CGRectMake(100+90*i, 260, 60, 30);
        button.backgroundColor = [UIColor clearColor];
        
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTintColor:[UIColor blackColor]];
        
        button.tag = 300 + i;
        if (i == 0) {
            //登陆
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            //跳转到注册页面
            [button addTarget:self action:@selector(pushToNextPage:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.view addSubview:button];
    }
   self.title = @"登陆";
    
}

//登陆按钮方法实现
- (void)click:(UIButton *)sender{
    UITextField *lt1 = (UITextField *)[self.view viewWithTag:500];
    UITextField *lt2 = (UITextField *)[self.view viewWithTag:501];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
