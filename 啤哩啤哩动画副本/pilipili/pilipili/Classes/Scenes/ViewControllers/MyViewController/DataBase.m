//
//  DataBase.m
//  啤哩啤哩动画
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "DataBase.h"
#import "User.h"
#import <sqlite3.h>

@implementation DataBase

//static DataBase *dataBase = nil;
//
////创建单例
//+ (DataBase *)sharedDataBase{
//  //加锁
//    @synchronized(self) {
//        if(dataBase == nil){
//            dataBase = [[DataBase alloc]init];
//            //打开数据库
//            [dataBase openDB];
//        }
//    }
//    return dataBase;
//}
//
////创建数据库对象
//static sqlite3 *db = nil;
//
////打开数据库的方法
//- (void)openDB{
//  //如果数据库已经打开,则不需要执行后面的语句
//    if (db != nil){
//        return;
//    }
//    //创建存放数据库的路径
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *path = [documentPath stringByAppendingString:@"/UserData.sqlite"];
//    //打开数据库(如果该数据库存在,直接打开,否则,新创建一个)
//    int result = sqlite3_open([path UTF8String], &db);
//    
//    if(result == SQLITE_OK){
//        NSLog(@"数据库成功打开!");
//        //准备SQL语句
//        NSString *userSQL = @"CREATE TABLE User (name TEXT PRIMARY KEY NOT NULL, psw TEXT NOT NULL, email TEXT NOT NULL, tel TEXT NOT NULL, isLogin TEXT NOT NULL DEFAULT NO);";
//        NSString *sql = @"CREATE TABLE Collection (ID TEXT NOT NULL, userName TEXT NOT NULL REFERENCES User (name), kind TEXT NOT NULL)";
//        //执行sql语句
//        sqlite3_exec(db, [userSQL UTF8String],NULL,NULL,NULL);
//        sqlite3_exec(db, [sql UTF8String],NULL,NULL,NULL);
//    }else{
//        NSLog(@"%d",result);
//    }
//}
//
////关闭数据库的方法
//- (void)closeDB{
//    int result = sqlite3_close(db);
//    if (result == SQLITE_OK) {
//        NSLog(@"数据库成功关闭");
//        //关闭数据库时需要将db置为空,因为打开数据库时,需要使用db是否等于nil的判断
//        db = nil;
//    }else{
//        NSLog(@"数据库关闭失败:%d",result);
//    }
//}
////增加
//- (void)insertUser:(User *)user{
//  //1.打开数据库
//    [self openDB];
//  //2.创建跟随指针 (伴随指针)
//    sqlite3_stmt *stmt = nil;
//  //3.准备sql语句
//    NSString *sql = @"INSERT INTO User (name,psw,email,tel) VALUES (?,?,?,?)";
//  //4.验证sql是否正确
//    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
//    if(result == SQLITE_OK){
//        NSLog(@"插入成功");
//        //5.如果sql语句正确,我们就开始绑定数据,替换?
//        //参数:跟随指针, 问号的顺序, 需要绑定的数据
//        sqlite3_bind_text(stmt, 1, [user.name UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, 2, [user.psw UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, 3, [user.email UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, 4, [user.tel UTF8String], -1, NULL);
//        //6.单步执行
//        sqlite3_step(stmt);
//    }else{
//        NSLog(@"插入失败: %d",result);
//    }
//    // 7.释放跟随指针占用的内存
//    sqlite3_finalize(stmt);
//}
//
//// 更改登录状态
//-(void)changeIsLogin:(NSString *)isLogin withUserName:(NSString *)userName{
//    // 1.打开数据库
//    [self openDB];
//    // 2.创建伴随指针
//    sqlite3_stmt *stmt = nil;
//    // 3.准备sql语句
//    NSString *sql = @"UPDATE User SET isLogin = ? WHERE name = ?";
//    // 4.验证语句是否正确
//    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    if (result == SQLITE_OK) {
//        NSLog(@"修改成功");
//        // 5.绑定
//        sqlite3_bind_text(stmt, 1, [isLogin UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, 2, [userName UTF8String], -1, NULL);
//        // 6.单步执行
//        sqlite3_step(stmt);
//    }else{
//        NSLog(@"修改失败：%d", result);
//    }
//}
//
//// 查询某个用户
//-(User *)selectUsertWithName:(NSString *)name{
//    // 1.
//    [self openDB];
//    // 2.
//    sqlite3_stmt *stmt = nil;
//    // 3.
//    NSString *sql = @"SELECT * FROM User WHERE name = ?";
//    // 验证
//    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    if (result == SQLITE_OK) {
//        NSLog(@"查询成功");
//        // 绑定
//        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, NULL);
//        // 创建学生
//        User *user = [User new];
//        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
//            NSString *psw = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
//            NSString *email = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
//            NSString *tel = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
//            NSString *isLogin = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
//            user.name = name;
//            user.psw = psw;
//            user.email = email;
//            user.tel = tel;
//            user.isLogin = isLogin;
//        }
//        sqlite3_finalize(stmt);
//        return user;
//    }else{
//        NSLog(@"查询失败：%d", result);
//    }
//    sqlite3_finalize(stmt);
//    return nil;
//}
//
//// 查询所有用户
//-(NSArray *)selectUsers{
//    // 1.
//    [self openDB];
//    // 2.
//    sqlite3_stmt *stmt = nil;
//    // 3.准备
//    NSString *sql = @"SELECT * FROM User";
//    // 4.验证
//    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    if (result == SQLITE_OK) {
//        NSLog(@"查询成功");
//        // 创建可变数组,添加查询到的学生
//        NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
//        // 执行sql语句，取值
//        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            // 根据sql语句搜索到的符合条件的数据，取出来
//            // 0代表该属性的位置（从零开始）
//            NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
//            NSString *psw = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
//            NSString *email = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
//            NSString *tel = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
//            NSString *isLogin = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
//            // 新建学生对象
//            User *user = [[User alloc]initWithName:name psw:psw email:email tel:tel isLogin:isLogin];
//            // 添加到可变数组
//            [array addObject:user];
//        }
//        // 释放伴随指针
//        sqlite3_finalize(stmt);
//        // 返回数组
//        return array;
//    }else{
//        NSLog(@"查询失败：%d", result);
//    }
//    // 释放
//    sqlite3_finalize(stmt);
//    return nil;
//}






@end
