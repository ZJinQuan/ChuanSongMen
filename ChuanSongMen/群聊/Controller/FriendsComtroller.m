//
//  FriendsComtroller.m
//  ChuanSongMen
//
//  Created by QUAN on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FriendsComtroller.h"
#import "FriendsCell.h"
#import "FriendsNMode.h"
#import "ChatViewController.h"

@interface FriendsComtroller ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *userMode;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FriendsComtroller

-(NSMutableArray *)userMode{
    
    if (!_userMode) {
        
        self.userMode = [NSMutableArray array];
        
    }
    return _userMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"好友";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerNib:[UINib nibWithNibName:@"FriendsCell" bundle:nil] forCellReuseIdentifier:@"friendCell"];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self loadFriend];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSLog(@"friendsModel%@",self.userMode);
}

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
                    FriendsNMode *userMode = [FriendsNMode initWithDictionary:dict];
                    
                    [self.userMode addObject:userMode];
                }
                [self.tableView reloadData];
            }
        }else{
            NSLog(@"%@", error);
        }
        
        
    }];
    
}

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
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UsergetMyAction *model = self.userMode[indexPath.row];
    
    NSLog(@"%@",model.name);
    
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:model.userId conversationType:eConversationTypeChat];
    
    chatController.title = model.niCheng;
    
    
    [chatController setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController  pushViewController:chatController animated:YES];
    
}




@end
