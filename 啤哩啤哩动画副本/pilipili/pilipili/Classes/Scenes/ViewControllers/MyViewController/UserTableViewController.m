//
//  UserTableViewController.m
//  啤哩啤哩动画
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 蓝欧科技. All rights reserved.
//

#import "UserTableViewController.h"
#import "LoginViewController.h"
#import "UserTableViewCell.h"


@interface UserTableViewController ()

@end

static NSString *identifier = @"cell";
@implementation UserTableViewController

//登陆或者注销按钮的事件实现
- (void)login:(UIBarButtonItem *)sender{
    if([sender.title isEqualToString:@"登陆"]){
      //为登陆,调到登陆页面
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }else if([sender.title isEqualToString:@"注销"]){
      //为注销, 将当前用户的登陆状态更改为NO
        [self.navigationItem.rightBarButtonItem setTitle:@"登陆"];
        [self.tableView reloadData];
    }
}

- (void)setButton{
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:(UIBarButtonItemStyleDone) target:self action:@selector(login:)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    [self setButton];
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
    return 15;
}

// 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //选中cell 时,没有阴影
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *array = @[@"我的昵称",@"消息",@"离线任务",@"历史记录",@"我的收藏",@"关注的人",@"消费记录",@"游戏中心",@"设置"];
    
    if(indexPath.row < 9) {
        cell.lab4Usertxt.text = array[indexPath.row];
        [cell.image4UserPic setImage:[UIImage imageNamed:array[indexPath.row]]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.lab4Usertxt.text = @"";
        [cell.image4UserPic setImage:[UIImage imageNamed:@""]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
