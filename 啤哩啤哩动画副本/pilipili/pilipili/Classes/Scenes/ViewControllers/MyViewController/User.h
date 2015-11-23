//
//  User.h
//  啤哩啤哩动画
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * psw;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * isLogin;

- (instancetype)initWithName:(NSString *)name
                         psw:(NSString *)psw
                       email:(NSString *)email
                         tel:(NSString *)tel
                     isLogin:(NSString *)isLogin;


@end
