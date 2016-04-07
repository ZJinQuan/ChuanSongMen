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
#import "MessageController.h"
#import "MyViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[[HomeViewController alloc] init] andImage:@"主页-灰色.png" addSeledImage:@"主页.png" addTitle:@"主页"];
    [self addChildViewController:[[CommunicationViewController alloc] init] andImage:@"发布汇-灰色.png" addSeledImage:@"发布汇.png" addTitle:@"发布汇"];
    [self addChildViewController:[[MessageController alloc] init] andImage:@"消息-灰色.png" addSeledImage:@"消息.png" addTitle:@"消息"];
    [self addChildViewController:[[MyViewController alloc] init] andImage:@"我-灰色.png" addSeledImage:@"我.png" addTitle:@"我"];
    
}

//添加子控制器方法
-(void) addChildViewController:(UIViewController *)childController andImage:(NSString *) imageName addSeledImage:(NSString *)selectImage addTitle :(NSString *) title {
    
    childController.title = title;
    
//    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    [childController.tabBarItem setImage:[UIImage imageNamed:imageName]];
    [childController.tabBarItem setSelectedImage:[UIImage imageNamed:selectImage]];
    //添加导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    

    
    [self addChildViewController:nav];
}


@end
