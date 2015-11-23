//
//  FindTableViewCell.h
//  pilipili
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"

@interface FindTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *rankLabel;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

//末尾的状态图片(升降标志)
@property (nonatomic, retain) IBOutlet UIImageView * stateImage;

@property (nonatomic, retain) FindModel *find;

@end
