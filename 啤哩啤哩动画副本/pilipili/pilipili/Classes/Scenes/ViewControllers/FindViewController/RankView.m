//
//  RankView.m
//  pilipili
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "RankView.h"

@implementation RankView


- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        self.rankImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(8, 12, 113, 80)];
        self.rankImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(131, 12, 113, 80)];
        self.rankImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(254, 12, 113, 80)];
        self.txtLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 105, 100, 20)];
        self.exampleImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(8, 138, 175, 100)];
        self.exampleImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(193, 138,175 , 100)];
        
        //打开图片的手势交互
        self.rankImageView1.userInteractionEnabled = YES;
        self.rankImageView2.userInteractionEnabled = YES;
        self.rankImageView3.userInteractionEnabled = YES;
        self.exampleImageView1.userInteractionEnabled = YES;
        self.exampleImageView2.userInteractionEnabled = YES;

        
        [self addSubview:_rankImageView1];
        [self addSubview:_rankImageView2];
        [self addSubview:_rankImageView3];
        [self addSubview:_txtLabel];
        [self addSubview:_exampleImageView1];
        [self addSubview:_exampleImageView2];
        
        self.rankImageView1.backgroundColor = [UIColor yellowColor];
        self.rankImageView2.backgroundColor = [UIColor yellowColor];
        self.rankImageView3.backgroundColor = [UIColor yellowColor];
        
        self.txtLabel.text = @"大家都在搜";
        self.exampleImageView1.backgroundColor = [UIColor cyanColor];
        self.exampleImageView2.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

@end
