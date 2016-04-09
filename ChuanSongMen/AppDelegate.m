//
//  AppDelegate.m
//  ChuanSongMen
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"

#import "HomeViewController.h"
#import "CommunicationViewController.h"
#import "MessageController.h"
#import "MyViewController.h"

#import "UIUtils.h"
#import "IQKeyboardManager.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import "TabBarController.h"

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"

#import "BaseViewController.h"

//环信头文件

@interface AppDelegate ()

@end

@implementation AppDelegate


-(UITabBarItem *)crateTabBar:(NSString *)title
                       image:(NSString *)imageNormalName
                 imageSelect:(NSString *)imageSelectName{

   
    UIImage *normalImage=[[UIImage imageNamed:imageNormalName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectImage=[[UIImage imageNamed:imageSelectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    UITabBarItem *tabBarItem=[[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectImage];
    
    
    
    
    
    [ShareSDK registerApp:@"b4ddfc3d5ba4"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                        ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;

             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
#pragma mark=================记得把这个微博验证给重新写上====================
//             case SSDKPlatformTypeSinaWeibo:
//                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                         redirectUri:@"http://www.sharesdk.cn"
//                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;

             default:
                 break;
         }
     }];
    
    

    return tabBarItem;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建Window
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
            //是第一次启动
            NSLog(@"是第一次启动");
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:@"searchID"];
            
            LoginViewController *loginVc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            
            self.window.rootViewController = loginVc;
            
        }else{
            NSLog(@"不是第一次启动");
//            
            TabBarController *tabVC = [[TabBarController alloc] init];
            
            self.window.rootViewController = tabVC;
        }
    
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *user = [userDefault objectForKey:@"user"];
//    NSString *password = [userDefault objectForKey:@"password"];
//    NSString *autoLogin = [userDefault objectForKey:@"autoLogin"];
//    
//    
//    if (<#condition#>) {
//        <#statements#>
//    }
    
//    
//    LoginViewController *loginVc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    
//    self.window.rootViewController = loginVc;
//
    //2.设置Window为主窗口并显示出来
    [self.window makeKeyAndVisible];
    
    
    //电池条颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    // 设置键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    //registerSDKWithAppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"chuansongmen#csm" apnsCertName:@"chuansongmen"];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:@"chuansongmen#csm"
                                       apnsCertName:@"chuansongmen"
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    NSInteger uid =   [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid ] stringValue];
    
    NSLog(@"%@------------------", userid);
    
    
    EMError *error = nil;
    NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:userid password:@"chuansongmen12345" error:&error];
    if (!error && loginInfo) {
        NSLog(@"登陆成功");
        
        //获取数据库中数据
        [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
    }
    
    [[UIApplication sharedApplication] keyWindow].tintColor = RGB(66, 196, 228);
    
    return YES;
}


- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end
