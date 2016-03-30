//
//  PurseViewController.m
//  ChuanSongMen
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PurseViewController.h"


#import "PurseSubView.h"

#import "PurseTableViewCell.h"
#import "PurseBankCardVC.h"//银行卡
#import "WithdrawVC.h"//申请提现
#import "RechargeVC.h"

@interface PurseViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    PurseSubView *purseSubView;
    

    UITableView *_tableView;
    
    NSArray *_tableData;

}

@end

@implementation PurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     
     我的钱包
     
     */
   
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    
    purseSubView=[[PurseSubView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, 280)];
    [self.view addSubview:purseSubView];
    
    
    
    [self tableData];
    
    [self setNavBar];
    
    
    [self addTableView];

}


-(void)setNavBar{
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.tintColor=navBarColor(0.0, 115.0, 179.0);
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake((KScrennWith-80)/2, 20+5, 80, 30)];
    titleLabel.text=@"我的钱包";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=titleLabel;
    
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(10, 20+5, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem=leftBarButton;
    
}

-(void)tableData{
    
    _tableData=@[
                 @{@"image":@"mypurse_withdrew.png",@"title":@"申请提现"},
                 @{@"image":@"info_btn_s.png",@"title":@"账户充值"},
                 @{@"image":@"info_btn_s.png",@"title":@"银行卡"}
                 ];
}
-(void)addTableView{

    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(purseSubView.frame)-20, KScrennWith,140) style:UITableViewStylePlain];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled=NO;
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];

}


-(void)backPage{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
        return 3;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"cellIdentifier";
    PurseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[PurseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    [cell setContentView:_tableData[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 10;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row ==  0) {
        
        WithdrawVC *witPage=[[WithdrawVC alloc] initWithNibName:@"WithdrawVC" bundle:nil];
        [self.navigationController pushViewController:witPage animated:YES];
        
    }else if (indexPath.row == 1){
    
//        PayViewC *payVC=[[PayViewC alloc] initWithNibName:@"PayViewC" bundle:nil];
//        [self.navigationController pushViewController:payVC animated:YES];
        RechargeVC *rechargeVC = [[RechargeVC alloc] initWithNibName:@"RechargeVC" bundle:nil];
        [self.navigationController pushViewController:rechargeVC animated:YES];
    
    }else{
    
        PurseBankCardVC *PurseBankCardPage=[[PurseBankCardVC alloc] init];
        [self.navigationController pushViewController:PurseBankCardPage animated:YES];
    }
    
}


@end
