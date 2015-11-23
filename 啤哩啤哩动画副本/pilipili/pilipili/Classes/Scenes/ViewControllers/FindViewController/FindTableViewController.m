//
//  FindTableViewController.m
//  pilipili
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "FindTableViewController.h"
#import "FindTableViewCell.h"
#import "RankView.h"
#import "RankTableViewController.h"

@interface FindTableViewController ()<UISearchResultsUpdating,UISearchBarDelegate>


//盛放50个热词的数组
@property (nonatomic, retain)NSMutableArray *allArray;

//盛放3个排行图片的URL的数组
@property (nonatomic, retain)NSMutableArray *pic3Array;

//盛放2个排行图片的URL的数组
@property (nonatomic, retain)NSMutableArray *pic2Array;

//rankView
@property (nonatomic, retain)RankView *rankView;

//存放所有搜索结果
@property (nonatomic, retain)NSMutableArray *searchResult;
//搜索框
@property (nonatomic, retain)UISearchController *searchController;


@end

static NSString *cellIdentifier = @"cell";

@implementation FindTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"FindTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.rankView = [[RankView alloc]initWithFrame:CGRectMake(0, 38, 375, 250)];
    
    //调用手势
    [self setTap];
    [self search];
    //加载数据
    [self loadData];
    //创建
    self.searchResult = [NSMutableArray array];
    //搜索
    [self search];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 288)];
    [view addSubview:self.searchController.searchBar];
    [view addSubview:self.rankView];
    //放到header
    self.tableView.tableHeaderView = view;
}

#pragma mark 搜索
- (void)search{
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.searchBar.placeholder = @"搜索视频、番剧、up主或AV号";

}


#pragma mark UISearchResultsUpdating协议方法
//updateSearchResultsForSearchController 的方法 当我们对搜索框有任何操作的时候这个方法就会被调用
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //取消掉白线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_searchResult removeAllObjects];
    
    //系统的,不用管
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[cd]%@",self.searchController.searchBar.text];
    //把所有名字给它,让他搜索
    NSMutableArray *array = [self.allArray filteredArrayUsingPredicate:predicate].mutableCopy;
    //把搜索到的结果赋值给结果
    self.searchResult = array;
    //刷新页面
    [self.tableView reloadData];
}


//这个方法进入这个页面就会走
- (void)viewWillAppear:(BOOL)animated{
    //隐藏 tab bar 状态栏
    self.tabBarController.tabBar.hidden = NO;
}


// 使用第三方加载数据加载数据(NFNetworking 自动防止假死,不需要考虑主线程和单线程)
- (void)loadData{

    //创建一个管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //管理者得到URL 进行解析(50个热点)
    [manager GET:FIND_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dictionary = responseObject;
        NSArray *array = dictionary[@"list"];
        for(NSDictionary *dic in array){
          //字典里面所有的"list"组成数组
            NSString *str = dic[@"keyword"];
            //NSLog(@"%@",str);
            [self.allArray addObject:str];
        }
        //NSLog(@"------%@",self.allArray);
        //主线程中刷新页面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    //管理者得到URL 进行解析(图片)
    [manager GET:FINDIMAGE_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dictionary = responseObject;
        NSDictionary *dictionary2 = dictionary[@"result"];
       // NSLog(@"-----%@",dictionary2);
        for (NSString *key in dictionary2) {
            id idd = dictionary2[key];
            if ([idd isKindOfClass:[NSDictionary class]]) {
               // NSLog(@"-----%@",idd[@"cover"]);
                [self.pic3Array addObject:idd[@"cover"]];
            }else{
                for (NSDictionary *dic in idd) {
                    //NSLog(@"====%@",dic[@"cover"]);
                    [self.pic2Array addObject:dic[@"cover"]];
                }
                
            }

        }
        //主线程中刷新页面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self fuzhi];
          });
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
}

//赋值
- (void)fuzhi{
    [self.rankView.rankImageView1 sd_setImageWithURL:self.pic3Array[1]];
    [self.rankView.rankImageView2 sd_setImageWithURL:self.pic3Array[0]];
    self.rankView.rankImageView3.image = [UIImage imageNamed:@"不变.jpg"];
    [self.rankView.exampleImageView1 sd_setImageWithURL: self.pic2Array[0]];
    [self.rankView.exampleImageView2 sd_setImageWithURL:self.pic2Array[1]];
}
//添加手势(点击)
- (void)setTap{
    //设置tap
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    //需要轻拍次数
    //tap.numberOfTapsRequired = 2;
    //需要的手指数
    //tap.numberOfTouchesRequired = 1;
    //添加到视图上面
    [self.rankView.rankImageView1 addGestureRecognizer:tap1];
    [self.rankView.rankImageView2 addGestureRecognizer:tap2];
    [self.rankView.rankImageView3 addGestureRecognizer:tap3];
    [self.rankView.exampleImageView1 addGestureRecognizer:tap4];
    [self.rankView.exampleImageView2 addGestureRecognizer:tap5];
    
}
//手势事件
- (void)click:(UITapGestureRecognizer *)sender{
    
    RankTableViewController *rankVC = [RankTableViewController new];
    
    [self.navigationController pushViewController:rankVC animated:YES];
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
    if (_searchController.active == YES) {
        return self.searchResult.count;
    }
    return self.allArray.count;
}

//设置cell显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //找到复用池中的cell
    FindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    //选中cell 时,没有阴影
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //R:247 B:145  G:135
    UIColor *customColor = [UIColor colorWithRed:240.0/255.0 green:147.0/255.0 blue:200.0/255.0 alpha:1];
    cell.rankLabel.textColor = customColor;
    
    //如果搜索框有动作
    if (_searchController.active == YES) {
        NSString *string =  self.searchResult[indexPath.row];
        for (NSString * str in self.allArray)
        if ([string isEqualToString:str]){
            cell.titleLabel.text = str;
            cell.rankLabel.text = [NSString stringWithFormat:@"%ld.",indexPath.row + 1];
        }
    }else{
        cell.titleLabel.text = self.allArray[indexPath.row];
        cell.rankLabel.text = [NSString stringWithFormat:@"%ld.",indexPath.row + 1];
    }
    
    return cell;
}


//懒加载allArray
#pragma mark -lazyLoad
- (NSMutableArray *)allArray{
    if (!_allArray) {
        _allArray = [[NSMutableArray alloc]init];
    }
    return _allArray;
}

- (NSMutableArray *)pic2Array{
    if (!_pic2Array) {
        _pic2Array = [[NSMutableArray alloc]init];
    }
    return _pic2Array;
}

- (NSMutableArray *)pic3Array{
    if (!_pic3Array) {
        _pic3Array = [[NSMutableArray alloc]init];
    }
    return _pic3Array;
}

- (NSMutableArray *)searchResult{
    if (!_searchResult){
        _searchResult = [[NSMutableArray alloc]init];
    }
    return _searchResult;
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
