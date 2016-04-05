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

#import "TabBarController.h"
#import "HomeViewController.h"
#import "CommunicationViewController.h"
#import "ChatViewController.h"
#import "MyViewController.h"

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
    self.navigationController.navigationBarHidden = YES;
    
    
}


#pragma mark ============= 自动登录 ======================
//- (void)autoLogin{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *user = [userDefault objectForKey:@"user"];
//    NSString *password = [userDefault objectForKey:@"password"];
//    NSString *autoLogin = [userDefault objectForKey:@"autoLogin"];
//    if (user != nil && user.length >= 1 && password != nil && password.length >= 1) {
//        if ([autoLogin isEqualToString:@"YES"]) {
//            [self loginWithUser:user andPassword:password];
//        }
//    }
//    self.userNameTF.text = user;
//    self.passwordTF.text = password;
//}


- (void)loginWithUser:(NSString *)userName andPassword:(NSString *)password {

    [self showHUD:nil];
    NSMutableDictionary *pararm = [NSMutableDictionary dictionary];
    [pararm setObject:userName forKey:@"name"];
    [pararm setObject:password forKey:@"password"];
    [pararm setObject:@"" forKey:@"token"];
    [pararm setObject:@"iOS" forKey:@"phoneType"];
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"useruserlogin"] params:pararm result:^(id responseObj, NSError *error) {
        [self hideHUD];
        if ([responseObj[@"result"] intValue] == 0) {
            self.userInfoModel = [UserInfoModel initWithDictionary:responseObj];
            self.userId = [responseObj[@"userId"] intValue];
            
            [[NSUserDefaults standardUserDefaults] setInteger:self.userId forKey:@"key_ShortVersion"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            AppDelegate *app =[UIApplication sharedApplication].delegate;
            app.userId = responseObj[@"userId"];
            NSLog(@"%@ , >>>>%ld" , self.userInfoModel, (long)self.userId);
            // 保存登录信息
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:self.userNameTF.text forKey:@"user"];
            [userDefault setObject:self.passwordTF.text forKey:@"password"];
            [userDefault setObject:@"YES" forKey:@"autoLogin"];
            self.userNameTF.text = userName;
            self.passwordTF.text = password;
            
            
            
            
//            //a.初始化一个tabBar控制器
//            UITabBarController *tabBar =[[UITabBarController alloc] init];
//            tabBar.tabBar.barTintColor = tabBarColor(239.0,239.0,239.0);
//            self.view.window.rootViewController = tabBar;
//            
//            
//            //b.创建子控制器
//            //主页
//            HomeViewController *homeVC=[[HomeViewController alloc] init];
//            homeVC.tabBarItem = [self crateTabBar:@"主页" image:@"tab_homepage.png" imageSelect:@"tab_homepage_pre.png"];
//            
//            
//            
//            //发布汇
//            CommunicationViewController *communicationVC=[[CommunicationViewController alloc] init];
//            communicationVC.view.backgroundColor=navBarColor(0.0,115.0,179.0);
//            communicationVC.tabBarItem=[self crateTabBar:@"发布汇" image:@"tab_chat.png" imageSelect:@"tab_chat_pre.png "];
//            //通讯
//            ChatViewController *chatVC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
//            chatVC.view.backgroundColor=tabBarColor(244.0, 244.0, 244.0);
//            chatVC.tabBarItem=[self crateTabBar:@"通讯" image:@"tab_communication.png" imageSelect:@"tab_communication_pre.png"];
//            //我
//            MyViewController *myVC=[[MyViewController alloc] init];
//            myVC.view.backgroundColor=[UIColor redColor];
//            myVC.tabBarItem=[self crateTabBar:@"我" image:@"tab_i.png" imageSelect:@"tab_i_pre.png"];
//            
//            
//            UINavigationController *homeNav=[[UINavigationController alloc] initWithRootViewController:homeVC];
//            
//            homeNav.navigationBar.barTintColor=[UIColor whiteColor];
//            
//            homeNav.title=@"首页";
//            homeNav.navigationBar.tintColor = [UIColor blueColor];
//            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44,[UIScreen mainScreen].bounds.size.width, 1)];
//            line.backgroundColor = [UIColor blackColor];
//            [homeNav.navigationBar addSubview:line];
//            
//            UINavigationController *communicationNav=[[UINavigationController alloc] initWithRootViewController:chatVC
//                                                      ];
//            communicationNav.navigationBar.barTintColor=navBarColor(0.0,116.0,180.0);
//            communicationNav.navigationBarHidden=YES;
//            communicationNav.title=@"发布汇";
//            
//            UINavigationController *chatNav=[[UINavigationController alloc] initWithRootViewController:communicationVC];
//            chatNav.navigationBar.barTintColor=navBarColor(0.0,116.0,180.0);
//            chatNav.title=@"通讯";
//            
//            
//            UINavigationController *myNav=[[UINavigationController alloc] initWithRootViewController:myVC];
//            myNav.navigationBar.barTintColor=navBarColor(0.0,116.0,180.0);
//            myNav.navigationBarHidden=YES;
//            myNav.title=@"我";
//            
//            //添加tab
//            tabBar.viewControllers = @[homeNav,chatNav,communicationNav,myNav];
//            tabBar.selectedIndex = 0;
//
//
            
            TabBarController *tabVC = [[TabBarController alloc] init];
            
            self.view.window.rootViewController = tabVC;
            //2.设置Window为主窗口并显示出来
            [self.view.window makeKeyAndVisible];
            
            
            
            
            
        }else{
            [self showMessage:responseObj[@"message"]];
        }
    }];
}

- (IBAction)loginAction:(UIButton *)sender {
    if (self.userNameTF.text.length < 1) {
        [self showMessage:@"请输入用户名"];
    }else if (self.passwordTF.text.length < 1){
        [self showMessage:@"请输入密码"];
    }else{
        
    [self loginWithUser:self.userNameTF.text andPassword:self.passwordTF.text];
    
    }
    
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
    
//    [self autoLogin];
    
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


-(UITabBarItem *)crateTabBar:(NSString *)title
                       image:(NSString *)imageNormalName
                 imageSelect:(NSString *)imageSelectName{
    
    
    UIImage *normalImage=[[UIImage imageNamed:imageNormalName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectImage=[[UIImage imageNamed:imageSelectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabBarItem=[[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectImage];
    
    

    
    return tabBarItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
