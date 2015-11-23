//
//  User.m
//  啤哩啤哩动画
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "User.h"

@implementation User

//容错处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@--%@--%@--%@--%@",_name,_psw,_email,_tel,_isLogin];
}

-(instancetype)initWithName:(NSString *)name
                        psw:(NSString *)psw
                      email:(NSString *)email
                        tel:(NSString *)tel
                    isLogin:(NSString *)isLogin{
    if (self = [super init]) {
        self.name = name;
        self.psw = psw;
        self.email = email;
        self.tel = tel;
        self.isLogin = isLogin;
    }
    return self;
}

@end
