//
//  FindTableViewCell.m
//  pilipili
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "FindTableViewCell.h"

@implementation FindTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setFind:(FindModel *)find{
//    _find = find;
//    //_rankLabel.text = [NSString stringWithFormat:@"%ld",find.rank];
//    _titleLabel.text = find.title;
//    
//    //R:211 B:41  G:138
//    UIColor *customColor = [UIColor colorWithRed:211.0 green:138.0 blue:41 alpha:1];
//    _titleLabel.textColor = customColor;
//    //NSLog(@"+++%@,%@",_titleLabel.text, find.title);
//    
//}

@end
