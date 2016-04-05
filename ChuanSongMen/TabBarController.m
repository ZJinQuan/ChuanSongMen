//
//  TabBarController.m
//  ChuanSongMen
//
//  Created by QUAN on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "CommunicationViewController.h"
#import "ChatViewController.h"
#import "MyViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[[HomeViewController alloc] init] andImage:@"tab_homepage.png" addTitle:@"主页"];
    [self addChildViewController:[[CommunicationViewController alloc] init] andImage:@"tab_chat.png" addTitle:@"发布汇"];
    [self addChildViewController:[[ChatViewController alloc] init] andImage:@"tab_communication.png" addTitle:@"通讯"];
    [self addChildViewController:[[MyViewController alloc] init] andImage:@"tab_i.png" addTitle:@"我"];
    
}

//添加子控制器方法
-(void) addChildViewController:(UIViewController *)childController andImage:(NSString *) imageName addTitle :(NSString *) title {
    
    childController.title = title;
    
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    
    //添加导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    

    
    [self addChildViewController:nav];
}


@end
