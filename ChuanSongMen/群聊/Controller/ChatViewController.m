//
//  ChatViewController.m
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChatViewController.h"
#import "SearchFriendVC.h"
#import "EaseMessageViewController.h"
#import "NewsView.h"
#import "FriendsView.h"
 #import "EaseUI.h"
#import "UsergetMyAction.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *addFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIView *friendView;

@property (nonatomic, strong) NSMutableArray *userMode;

@property (nonatomic, strong) NewsView *newsView;
@property (nonatomic, strong) FriendsView *friendsView;

@end

@implementation ChatViewController
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    NewsView *newsView = [[NewsView alloc] initWithFrame:self.friendView.bounds];
    newsView.backgroundColor = [UIColor yellowColor];
    [self.friendView addSubview:newsView];
    self.newsView = newsView;
    
    
    FriendsView *friendsView = [[FriendsView alloc] initWithFrame:self.friendView.bounds];
    friendsView.backgroundColor = [UIColor purpleColor];
    friendsView.hidden = YES;
    
    [self.friendView addSubview:friendsView];
    self.friendsView = friendsView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self changeLayerOfSomeControl:_messageButton];
    [self changeLayerOfSomeControl:_friendButton];
    
    [self messageBucconClicked:self.messageButton];
    
    [self loadFriend];
}

#pragma mark ==  网络请求 ===== ==========
-(void) loadFriend{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"/usergetMyAction?userId=2"] params:params result:^(id responseObj, NSError *error) {
        
        if (responseObj != nil) {
            NSLog(@"%@",responseObj);
            
            if ([responseObj[@"result"] isEqualToString:@"0"] ) {
                for (NSDictionary *dict in responseObj[@"Firends"]) {
                    UsergetMyAction *userMode = [UsergetMyAction initWithDictionary:dict];
                    
                    [self.userMode addObject:userMode];
                }
            }
        }else{
            NSLog(@"%@", error);
        }
        
        
    }];
    
}

#pragma mark ==  消息按钮点击事件 ===== ==========
- (IBAction)messageBucconClicked:(UIButton *)sender {
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:RGB(0, 117, 180) forState:UIControlStateNormal];
    _friendButton.backgroundColor = RGB(0, 117, 180);
       [_friendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.newsView.hidden = NO;
    self.friendsView.hidden = YES;
    
}
#pragma mark  ============= 好友按钮点击事件 ============
- (IBAction)friendButtonClicked:(UIButton *)sender {
    
    sender.backgroundColor = [UIColor whiteColor];
       [sender setTitleColor:RGB(0, 117, 180) forState:UIControlStateNormal];
    _messageButton.backgroundColor = RGB(0, 117, 180);
   [_messageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.newsView.hidden = YES;
    self.friendsView.hidden = NO;
    
}

#pragma mark  ============= 添加好友按钮点击事件 ======
- (IBAction)addFriendClicked:(UIButton *)sender {
}

#pragma mark  ============= 搜索按钮点击事件 =============
- (IBAction)searchButtonClicked:(UIButton *)sender {
    SearchFriendVC *searchFriendVC = [[SearchFriendVC alloc] initWithNibName:@"SearchFriendVC" bundle:nil];
    [self.navigationController pushViewController:searchFriendVC animated:YES];
}

@end
