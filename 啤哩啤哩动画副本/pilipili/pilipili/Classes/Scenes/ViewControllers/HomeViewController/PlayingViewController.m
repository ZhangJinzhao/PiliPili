//
//  PlayingViewController.m
//  pilipili
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "PlayingViewController.h"

@interface PlayingViewController ()

@property (nonatomic, retain)UIWebView *webView;

@end

@implementation PlayingViewController

static PlayingViewController *playingVC = nil;

+ (PlayingViewController *)sharedPlayViewController{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        playingVC = [sb instantiateViewControllerWithIdentifier:@"playVC"];
    });
    return playingVC;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadPlayingView];
    [self.view addSubview:self.webView];
    //隐藏 tab bar 状态栏
    self.tabBarController.tabBar.hidden = YES;
    //隐藏 navigationBar
    //self.navigationController.navigationBarHidden = YES;
    
}

//视图加载完毕后,清除所有的view
- (void)viewDidAppear:(BOOL)animated{
    self.webView = nil;
    [self.webView removeFromSuperview];
}

- (void)loadPlayingView{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.bilibili.com/video/av%ld/",self.param]]];
    [self.webView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//懒加载webView
#pragma mark -lazyLoad
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    }
    return _webView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
