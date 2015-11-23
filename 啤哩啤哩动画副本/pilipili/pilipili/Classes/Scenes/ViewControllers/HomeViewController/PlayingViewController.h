//
//  PlayingViewController.h
//  pilipili
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingViewController : UIViewController

@property (nonatomic, assign)NSInteger param;

+(PlayingViewController *)sharedPlayViewController;

@end
