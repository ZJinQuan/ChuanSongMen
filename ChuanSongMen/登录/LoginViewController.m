//
//  LoginViewController.m
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SetUserNameVC.h"
@interface LoginViewController ()<returnUserInfoDelegate>

@property (nonatomic, strong) SetUserNameVC *setUserNameVc;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}


- (IBAction)loginAction:(UIButton *)sender {
    
}



- (IBAction)registerAction:(UIButton *)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//    [self.navigationController pushViewController:registerVC animated:YES]; 

    [self showViewController:registerVC sender:self];
    
}


- (IBAction)helpAction:(UIButton *)sender {
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(25, 135, 193);
    [self changeLayerOfSomeControl:self.loginButton];
    [self changeLayerOfSomeControl:self.topView];
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(rememberUserInfo:) name:@"registerScuucess" object:nil];
    
    
    self.setUserNameVc = [[SetUserNameVC alloc] initWithNibName:@"SetUserNameVC" bundle:nil];
    self.setUserNameVc.RegisterDelegate = self;

}

-(void)rememberUserInfo:(NSNotification *)notification{
    NSArray *ar  = [NSArray array];
    ar = notification.object;
    self.userNameTF.text = ar[0];
    self.passwordTF.text = ar[1];
}



- (void)returnTheUsernameAndPassword:(NSArray *)array
{
    
    self.userNameTF.text = array[0];
    self.passwordTF.text = array[1];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
