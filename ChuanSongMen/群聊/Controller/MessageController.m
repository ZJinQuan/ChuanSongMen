//
//  MessageController.m
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MessageController.h"
#import "SearchFriendVC.h"
#import "EaseMessageViewController.h"
#import "EaseUI.h"
#import "UsergetMyAction.h"
#import "FriendsCell.h"
#import "ChatViewController.h"
#import "FriendsComtroller.h"

@interface MessageController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *addFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIView *friendView;

@property (nonatomic, strong) NSMutableArray *userMode;

//@property (nonatomic, strong) UITableView *newsView;
@property (weak, nonatomic) IBOutlet UITableView *newsView;
@property (nonatomic, strong) UITableView *friendsView;

@end

@implementation MessageController
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UITableView *friendsView = [[UITableView alloc] initWithFrame:self.view.bounds];

    friendsView.y = 64;
    friendsView.dataSource = self;
    friendsView.delegate = self;
    friendsView.tag = 1111;
    
    [friendsView registerNib:[UINib nibWithNibName:@"FriendsCell" bundle:nil] forCellReuseIdentifier:@"friendCell"];
    
    friendsView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:friendsView];
    self.friendsView = friendsView;
}

-(NSMutableArray *)userMode{
    
    if (!_userMode) {
        
        self.userMode = [NSMutableArray array];
        
    }
    return _userMode;
}

- (void)initBaseNavigationLeftBar{
    //导航栏左侧按钮
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(0, 0, 50, 30);
    [leftButton setTitle:@"搜查" forState:UIControlStateNormal];
    [leftButton setTitleColor:RGB(66, 196, 228) forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftBarButton;
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(0, 0, 50, 30);
    [rightButton setTitle:@"好友" forState:UIControlStateNormal];
    [rightButton setTitleColor:RGB(66, 196, 228) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickFriendBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightBarButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLable.text = @"消息";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self changeLayerOfSomeControl:_messageButton];
    [self changeLayerOfSomeControl:_friendButton];
    
    [self messageBucconClicked:self.messageButton];
    
    [self loadFriend];
    
    [self initBaseNavigationLeftBar];
    
    NSLog(@"userModel%@",self.userMode);
}

#pragma mark ==  网络请求 ===== ==========
-(void) loadFriend{
    
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:userid forKey:@"userId"];
    
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"/usergetMyAction"] params:params result:^(id responseObj, NSError *error) {
        
        if (responseObj != nil) {
            
            
            
            NSDictionary* dict = responseObj[@"Firends"][0];
            NSLog(@"------------------------------%@",dict);
            if ([responseObj[@"result"] isEqualToString:@"0"] ) {
                for (NSDictionary *dict in responseObj[@"Firends"]) {
                    UsergetMyAction *userMode = [UsergetMyAction initWithDictionary:dict];
                    
                    [self.userMode addObject:userMode];
                }
                [self.friendsView reloadData];
                
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

-(void)clickFriendBtn{
    
    FriendsComtroller *friendsVC = [[FriendsComtroller alloc] init];
    
    [friendsVC setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:friendsVC animated:YES];
    
}

#pragma mark  ============= 添加好友按钮点击事件 ======
- (IBAction)addFriendClicked:(UIButton *)sender {
}

#pragma mark  ============= 搜索按钮点击事件 =============

-(void) searchButtonClicked{
    
    SearchFriendVC *searchFriendVC = [[SearchFriendVC alloc] initWithNibName:@"SearchFriendVC" bundle:nil];
    [self.navigationController pushViewController:searchFriendVC animated:YES];
}

#pragma mark UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userMode.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    
    cell.model = self.userMode[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_friendsView deselectRowAtIndexPath:indexPath animated:YES];
    
    UsergetMyAction *model = self.userMode[indexPath.row];
    
    NSLog(@"%@",model.name);
    
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:model.userId conversationType:eConversationTypeChat];

    chatController.title = model.niCheng;

    
    [chatController setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController  pushViewController:chatController animated:YES];
}

@end
