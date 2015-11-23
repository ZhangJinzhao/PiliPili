//
//  DataBase.h
//  啤哩啤哩动画
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface DataBase : NSObject

//创建单例
+ (DataBase *)sharedDataBase;

//打开数据库的方法
- (void)openDB;
//关闭数据库的方法
- (void)closeDB;

//增加
- (void)insertUser:(User *)user;

//更改登陆状态
- (void)changeIsLogin:(NSString *)isLogin withUserName:(NSString *)userName;

//查询某个用户
- (User *)selectUsers;






@end
