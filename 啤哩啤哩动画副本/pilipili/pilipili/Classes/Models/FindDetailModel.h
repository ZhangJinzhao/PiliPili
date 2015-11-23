//
//  FindDetailModel.h
//  pilipili
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindDetailModel : NSObject
//视频后七位
@property (nonatomic, assign) NSInteger aid ;
//up主
@property (nonatomic, retain) NSString * author;
//图片连接
@property (nonatomic, retain) NSString * pic;
//标题
@property (nonatomic, retain) NSString * title;
//播放次数
@property (nonatomic, assign) NSInteger play;
//弹幕
@property (nonatomic, assign) NSInteger video_review;

@end
