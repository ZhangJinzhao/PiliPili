//
//  HomeCollectionViewController.m
//  pilipili
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "HomeCollectionViewCell.h"
#import "PlayingViewController.h"


static NSString *headerIndentifier = @"headerReuse";
static NSString *footerIndentifier = @"footerReuse";
@interface HomeCollectionViewController ()

@property(nonatomic, strong) NSMutableDictionary *dataDict;
@property(nonatomic, strong) NSMutableArray *sectionArray;

//小菊花
@property (nonatomic, retain) UIActivityIndicatorView *activityLoad;

@end

@implementation HomeCollectionViewController

//static NSString * const reuseIdentifier = @"cell";

//这个方法只走一次
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"首页"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] tag:1010];
    [self.collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    //注册增补视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIndentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIndentifier];
    //用一个空的数组或字典来初始化我的
    self.sectionArray = [NSMutableArray array];
    self.dataDict = [NSMutableDictionary dictionary];
    
    //注册下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateHeard)];
    
    //注册上拉加载
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downdateFooter)];
    //小菊花
    [self loadState];
    
    [self loadData];
    
}

//下拉刷新实现方法
- (void)updateHeard{
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
}

//上拉加载实现方法
- (void)downdateFooter{
    [self.collectionView reloadData];
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}

//这个方法进入这个页面就会走
- (void)viewWillAppear:(BOOL)animated{
    //隐藏 tab bar 状态栏
    self.tabBarController.tabBar.hidden = NO;
    //小菊花
    [self.activityLoad startAnimating];
}

// 使用第三方加载数据加载数据(NFNetworking 自动防止假死,不需要考虑主线程和单线程)
- (void)loadData{
    
    //创建一个管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //管理者得到 URL 进行解析
    [manager GET:HOME_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dictionary = responseObject;
        NSArray *array = dictionary[@"result"];
        for (NSDictionary *dic in array){
            //字典里面所有的"body"组成数组
            NSArray *array2 = dic[@"body"];
            //用一个数组,盛放"head"里面的"title"
            [_sectionArray addObject:dic[@"head"][@"title"]];
            NSMutableArray *tempArray = [NSMutableArray array];
            //遍历"array2"
            for (NSDictionary *dict in array2) {
                HomeModel *home = [HomeModel new];
                [home setValuesForKeysWithDictionary:dict];
                [tempArray addObject:home];
            }
            [self.dataDict setObject:tempArray forKey:dic[@"head"][@"title"]];
        }
        //刷新
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

//每组 有多少个
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //#warning Incomplete implementation, return the number of sections
    return _sectionArray.count;
}

//有 多少组
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = self.dataDict[_sectionArray[section]];
    return array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //小菊花
    if ([self.activityLoad isAnimating]) {
        [self.activityLoad stopAnimating];
        [self.activityLoad removeFromSuperview];
        NSLog(@"%d",[self.activityLoad isAnimating]);
    }
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *array = self.dataDict[_sectionArray[indexPath.section]];
    
    HomeModel *home = array[indexPath.row];
    cell.home = home;
    
    return cell;
}

// 设置size大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(170, 100);
}
// 设置内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 20, 10);
}
// 最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 55;
}
// 最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
// 增补视图的区头
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.collectionView.bounds.size.width, 40);
}
//// 增补视图的区尾
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(10, 10);
//}




#pragma mark <UICollectionViewDelegate>

// 返回增补视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        // 从重用池里面取出来
        UICollectionReusableView * headerReuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIndentifier forIndexPath:indexPath];
        //定义数组,取到header里面所有的子类
        NSArray *array = [headerReuseView subviews];
        //获取array子类个数
        NSInteger n = array.count;
        //for循环依次移除子类(因为没有removeAllObject)
        for (int i = 0; i < n; i++) {
            [(UILabel *)array[i] removeFromSuperview];
        }
        
        //在增补视图上面添加label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 170, 20)];
        label.text = _sectionArray[indexPath.section];
        label.font = [UIFont systemFontOfSize:20];
        [headerReuseView addSubview:label];
        
        // 返回增补视图
        return headerReuseView;
        //footer可以不做改变,但是一定要有这个,否则报错
    }else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView * footerReuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIndentifier forIndexPath:indexPath];
        return footerReuseView;
    }
    
    return nil;
}




// Uncomment this method to specify if the specified item should be highlighted during tracking
//点击事件
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击成功");
    NSArray *array = self.dataDict[_sectionArray[indexPath.section]];
    
    PlayingViewController *playingVC = [PlayingViewController sharedPlayViewController];
    
    HomeModel *home = array[indexPath.row];
    
    playingVC.param = home.param;
    
    [self.navigationController pushViewController:playingVC animated:YES];
    //模态视图
    //[self presentViewController:playingVC animated:YES completion:nil];
    
    return YES;
}

#pragma mark 加载中——小菊花
- (void)loadState{
    self.activityLoad = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _activityLoad.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge
    ;
    _activityLoad.center = CGPointMake(kWidth/2, kHeight/2);
    _activityLoad.backgroundColor = [UIColor blackColor];
    _activityLoad.alpha = 0.8;
    _activityLoad.layer.masksToBounds = YES;
    _activityLoad.layer.cornerRadius = 6;
    [self.view addSubview:_activityLoad];
}

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
