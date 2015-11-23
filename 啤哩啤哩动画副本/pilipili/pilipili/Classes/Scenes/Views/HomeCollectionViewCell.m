//
//  HomeCollectionViewCell.m
//  pilipili
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

//重写了cell的frame
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //在cell里面创建了imgView
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 170, 100)];
        //设置圆角
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 6;
        //在cell里面创建了label
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 170, 30)];
        self.label.numberOfLines = 0;
        self.label.font = [UIFont systemFontOfSize:10];
       
        [self addSubview:_imgView];
        [self addSubview:_label];
    }
    return self;
}
//给 imgView 和 label 赋值
- (void)setHome:(HomeModel *)home{
    _label.text = home.title;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:home.cover]];
}


@end
