//
//  MyViewSetViewController.m
//  chuansongmen
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyViewSetViewController.h"
#import "UIUtils.h"

#import "HeaderView.h"

#import "SetTableViewCell.h"

#import "SettingCell.h"
#import "LoginViewController.h"
@interface MyViewSetViewController ()<UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate>


{

    
    
    NSArray *_tableDataArray;//假数据
    
    NSArray *_headerArray;
    NSArray *_array2;
    NSArray *_array3;
    int i;
    
    UIButton *_quiteLogin;//退出登录按钮
    
    
    UISwitch *_switch;//switch开关
    

}
@end

@implementation MyViewSetViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titleLable.text = @"设置";
      [self loadData];//假数据
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScrennWith, KScrennHeight - 64) style:UITableViewStyleGrouped];
    [_tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"settingCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
  

    
    
}

-(void)loadData{
    i=0;
    _tableDataArray=@[@"字体大小", @"声音提醒", @"震动提醒"];
    
    _array2 = @[@"通知", @"黑名单", @"我的收藏", @"密码修改", @"只允许我关注的人给我发私信"];
    _array3 = @[@"软件评价", @"意见建议", @"功能介绍", @"版本信息", @"申请认证"];
    
    _headerArray = @[@"账号", @"通用", @"隐私安全", @"开启只有我关注的人可以向我发送私信, 关闭则允许任何人向我发私信", @"服务"];
}



#pragma mark ======= 退出账号 =============
-(void)quiteLoginButtonPress{
    UIAlertView *AletView = [[UIAlertView alloc] initWithTitle:nil message:@"是否退出此账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [AletView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if(section == 2){
        return 5;
        
    }else if(section == 3){
        return 1;
        
    }else{
        return 5;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    
    if (indexPath.section == 0) {
        cell.titleLabel.text = @"美国公敌";
    }else if (indexPath.section == 1){
        cell.titleLabel.text = _tableDataArray[indexPath.row];
    }else if (indexPath.section == 2){
        cell.titleLabel.text = _array2[indexPath.row];
    }else if (indexPath.section == 3){
        cell.titleLabel.text = @"显示拍摄地点";
    }else if (indexPath.section == 4){
        cell.titleLabel.text = _array3[indexPath.row];
    }
    if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            cell.rightSwitch.hidden = NO;
            cell.rightImage.hidden = YES;
            cell.rightSwitch.tag = 1000 +indexPath.row; //是否允许发私信
            [cell.rightSwitch addTarget:self action:@selector(mySwitchAction:) forControlEvents:UIControlEventValueChanged];
        }
    }
    if (indexPath.section == 2 && indexPath.row == 4) {
        cell.rightSwitch.hidden = NO;
        cell.rightImage.hidden = YES;
        cell.rightSwitch.tag = 1006; //是否允许发私信
        [cell.rightSwitch addTarget:self action:@selector(mySwitchAction:) forControlEvents:UIControlEventValueChanged];
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        cell.rightSwitch.hidden = NO;
        cell.rightImage.hidden = YES;
        cell.rightSwitch.tag = 1007; //显示拍摄地点
        [cell.rightSwitch addTarget:self action:@selector(mySwitchAction:) forControlEvents:UIControlEventValueChanged];
    }
    
    
    return cell;
}





#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return  50;
    }else{
    return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 60;
    }else{
    return 1;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, KScrennWith - 20, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        label.text = _headerArray[section];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
    [headerView addSubview:label];
        if (section == 3) {
            label.frame = CGRectMake(10, 5, KScrennWith - 20, 40);
            headerView.frame = CGRectMake(0, 0, KScrennWith, 50);
            
        }
        return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 4) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, 55)];
        footView.backgroundColor = [UIColor clearColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10,10, KScrennWith - 20, 40);
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = RGB(54, 165, 234);
        [self changeLayerOfSomeControl:button];
        [button addTarget:self action:@selector(quiteLoginButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:button];
        return footView;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
}



#pragma mark ===== SWITCH 开关设置 ====================
-(void)mySwitchAction:(UISwitch *)sender{
    

    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            
            break;
            
        default:
        {
                LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:@"NO" forKey:@"autoLogin"];
            
            self.view.window.rootViewController = loginVC;
        }
            break;
    }
    
}




@end
