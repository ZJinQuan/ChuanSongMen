//
//  ChatViewController.m
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChatViewController.h"
#import "SearchFriendVC.h"
@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *addFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;

@end

@implementation ChatViewController
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeLayerOfSomeControl:_messageButton];
    [self changeLayerOfSomeControl:_friendButton];
    
    

}

#pragma mark ==  消息按钮点击事件 ===== ==========
- (IBAction)messageBucconClicked:(UIButton *)sender {
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:RGB(0, 117, 180) forState:UIControlStateNormal];
    _friendButton.backgroundColor = RGB(0, 117, 180);
       [_friendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
#pragma mark  ============= 好友按钮点击事件 ============
- (IBAction)friendButtonClicked:(UIButton *)sender {
    
    sender.backgroundColor = [UIColor whiteColor];
       [sender setTitleColor:RGB(0, 117, 180) forState:UIControlStateNormal];
    _messageButton.backgroundColor = RGB(0, 117, 180);
   [_messageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark  ============= 添加好友按钮点击事件 ======
- (IBAction)addFriendClicked:(UIButton *)sender {
}

#pragma mark  ============= 搜索按钮点击事件 =============
- (IBAction)searchButtonClicked:(UIButton *)sender {
    SearchFriendVC *searchFriendVC = [[SearchFriendVC alloc] initWithNibName:@"SearchFriendVC" bundle:nil];
    [self.navigationController pushViewController:searchFriendVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
