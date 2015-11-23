//
//  RankTableViewController.m
//  pilipili
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "RankTableViewController.h"
#import "RankTableViewCell.h"
#import "RankPlayingViewController.h"

@interface RankTableViewController ()

//视频网址后七位数组
@property (nonatomic, retain)NSMutableArray *array4aid;
//up主数组
@property (nonatomic, retain)NSMutableArray *array4author;
//播放次数
@property (nonatomic, retain)NSMutableArray *array4play;
//弹幕个数
@property (nonatomic, retain)NSMutableArray *array4video_review;
//图片连接
@property (nonatomic, retain)NSMutableArray *array4pic;
//标题
@property (nonatomic, retain)NSMutableArray *array4title;



@end

@implementation RankTableViewController

static RankTableViewController *rankVC = nil;

static NSString *cellIdentifier = @"cell";

//跟sb里里面创建的RankTableViewController连接
+ (RankTableViewController *)sharedRankTableViewController{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        rankVC = [sb instantiateViewControllerWithIdentifier:@"rankVC"];
        
    });
    return rankVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册自定义ell
    [self.tableView registerNib:[UINib nibWithNibName:@"RankTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    //隐藏 tab bar 状态栏
    self.tabBarController.tabBar.hidden = YES;
    [self loadData];
    
    
}


- (void)loadData{

    //创建一个管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   // 管理者得到URL 进行解析(50个热点)
    [manager GET:FINDDETAIL_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dictionary = responseObject;
        NSMutableDictionary *dictionary2 = [NSMutableDictionary dictionaryWithDictionary:dictionary[@"list"]];
        [dictionary2 removeObjectForKey:@"num"];
        for(NSString *key in dictionary2){
          //字典里面所有的"list"组成数组
            NSDictionary *dic = dictionary2[key];
            //视频七位数
            NSString *str1 = dic[@"aid"];
            [self.array4aid addObject:str1];
            //up主的数组
            NSString *str2 = dic[@"author"];
            [self.array4author addObject:str2];
            //播放次数
            NSString *str3 = [NSString stringWithFormat:@"%@",dic[@"play"]];
            [self.array4play addObject:str3];
            //弹幕个数
            NSString *str4 = [NSString stringWithFormat:@"%@",dic[@"video_review"]];
            [self.array4video_review addObject:str4];
            //图片链接
            NSString *str5 = dic[@"pic"];
            [self.array4pic addObject:str5];
            //标题
            NSString *str6 = dic[@"title"];
            [self.array4title addObject:str6];
//            NSLog(@"-%@",str1);
//            NSLog(@"--%@",str2);
//            NSLog(@"---%@",str3);
//            NSLog(@"----%@",str4);
//            NSLog(@"-----%@",str5);
//            NSLog(@"------%@",str6);
        }
        //主线程中刷新页面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    //管理者得到URL 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.array4title.count;
}

//cell中赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //找到复用池中的cell
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    //选中cell时,没有阴影
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //以下没有用model类,逗B的去一个一个的赋值
    cell.label4title.text = self.array4title[indexPath.row];
    cell.label4author.text = self.array4author[indexPath.row];
    [cell.imageView4pic sd_setImageWithURL:[NSURL URLWithString:self.array4pic[indexPath.row]]];
    
    //判断播放次数的数字或者"--"
    if(![self.array4play[indexPath.row] isEqualToString:@"--"]){
    float num1 = [self.array4play[indexPath.row] floatValue];
    if(num1 >= 10000){
        num1 = num1 / 10000;
        cell.label4play.text = [NSString stringWithFormat:@"%.1f万",num1];
    }
    }else{
        cell.label4play.text = self.array4play[indexPath.row];
    }
    
    //判断弹幕次数的数字
    float num2 = [self.array4video_review[indexPath.row] floatValue];
    if(num2 >= 10000){
        num2 = num2 / 10000;
        cell.label4video_review.text = [NSString stringWithFormat:@"%.1f万",num2];
    }else{
        cell.label4video_review.text = self.array4video_review[indexPath.row];
    }
 
    return cell;
}
//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   //进入
    RankPlayingViewController *rankPlayingVC = [[RankPlayingViewController alloc]init];
    //赋值七位数
    rankPlayingVC.aid = [self.array4aid[indexPath.row] integerValue];
    
    [self.navigationController pushViewController:rankPlayingVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 89;
}


#pragma mark --lazyLoad
- (NSMutableArray *)array4aid{
    if(!_array4aid){
        _array4aid = [[NSMutableArray alloc]init];
    }
    return _array4aid;
}

- (NSMutableArray *)array4author{
    if(!_array4author){
        _array4author = [[NSMutableArray alloc]init];
    }
    return _array4author;
}

- (NSMutableArray *)array4play{
    if(!_array4play){
        _array4play = [[NSMutableArray alloc]init];
    }
    return _array4play;
}

- (NSMutableArray *)array4video_review{
    if(!_array4video_review){
        _array4video_review = [[NSMutableArray alloc]init];
    }
    return _array4video_review;
}

- (NSMutableArray *)array4pic{
    if(!_array4pic){
        _array4pic = [[NSMutableArray alloc]init];
    }
    return _array4pic;
}

- (NSMutableArray *)array4title{
    if(!_array4title){
        _array4title = [[NSMutableArray alloc]init];
    }
    return _array4title;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
