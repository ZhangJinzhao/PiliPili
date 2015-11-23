//
//  HomeCollectionViewCell.h
//  pilipili
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeCollectionViewCell : UICollectionViewCell
@property(nonatomic,retain)UIImageView * imgView;
@property(nonatomic,retain)UILabel * label;
//妙妙妙
@property(nonatomic, retain)HomeModel *home;

@end
