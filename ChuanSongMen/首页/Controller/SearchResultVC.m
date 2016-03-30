//
//  SearchResultVC.m
//  ChuanSongMen
//
//  Created by FemtoappMacpro15 on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchResultVC.h"
#import "FriendLookupCell.h"
#import "HomePageCell.h"
#import "FriendModel.h"
#import "HomePageModel.h"
#import "PublishVC.h"
#import "ArticleInfoVC.h"
@interface SearchResultVC ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *friendArray;
@property (nonatomic, strong) NSMutableArray *articleArray;
@property (nonatomic, strong) UITextField *topField;
@property (nonatomic, strong) NSString *isAttention;
@end

@implementation SearchResultVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
    self.friendArray = [NSMutableArray array];
    self.articleArray = [NSMutableArray array];
    [self.articleArray removeAllObjects];
    [self.friendArray removeAllObjects];
    
    for (NSDictionary *dic in self.articleDataSourceArray) {
        HomePageModel *model = [HomePageModel initWithDictionary:dic];
        [self.articleArray addObject:model];

    }
    for (NSDictionary *dic in self.friendsDataSourceArray) {
        FriendModel *model = [FriendModel initWithDictionary:dic];
        [self.friendArray addObject:model];
        self.isAttention = model.atten;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideHUD];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
#pragma mark =======设置导航栏标题 ===================
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScrennWith - 120, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.text = self.searchInfo;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.layer.cornerRadius = 5;
    titleLabel.layer.masksToBounds = YES;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLable = titleLabel;
    self.navigationItem.titleView = titleLabel;
    
    
  
    [_tableView registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"FriendLookupCell" bundle:nil] forCellReuseIdentifier:@"friendCell"];
    [self.tableView reloadData];

}


#pragma mark -==-=-=-=-=-=-=-=-=-=-= UITableViewDataSource =================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.friendsDataSourceArray.count == 0) {
            return 0;
        }
        return self.friendsDataSourceArray.count;
    }else{
        if (self.articleDataSourceArray.count == 0) {
            return 0;
        }
        return self.articleDataSourceArray.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FriendLookupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.friendArray.count != 0) {
            cell.model = self.friendArray[indexPath.row];
        }
        [cell.attentionButton addTarget:self action:@selector(attentionFriendWhenClicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
        HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.userInteractionEnabled = YES;
        cell.navigationController = self.navigationController;
        if (self.articleArray.count != 0) {
            cell.model = self.articleArray[indexPath.row];
        }
//        UITapGestureExtension *tap = [[UITapGestureExtension alloc] initWithTarget:self action:@selector(commentAction:)];
//        tap.row = indexPath.row;
//        [cell.commentView addGestureRecognizer:tap];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }else{
        if (self.articleArray.count == 0) {
            return 0;
        }else{
        return [HomePageCell cellHeight:self.articleArray[indexPath.row]];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        topView.backgroundColor = [UIColor whiteColor];
        UILabel *friendLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 20)];
        friendLabel.text = @"相关用户";
        friendLabel.textColor = [UIColor grayColor];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, KScrennWith, 1)];
        lineLabel.backgroundColor = [UIColor darkGrayColor];
        lineLabel.alpha = 0.5;
        [topView addSubview:friendLabel];
        [topView addSubview:lineLabel];
        return topView;
    }else{
        UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        secondView.backgroundColor = [UIColor whiteColor];
        UILabel *articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 30)];
        articleLabel.text = @"相关推文";
        articleLabel.textColor = [UIColor grayColor];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, KScrennWith, 1)];
        lineLabel.backgroundColor = [UIColor grayColor];
        lineLabel.alpha = 0.5;
        [secondView addSubview:articleLabel];
        [secondView addSubview:lineLabel];
        return secondView;
    }
    
}

#pragma mark ============  UITableViewDelegate =======================================
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@" 点击了推文 -=-==---=-=-=--");
    if (indexPath.section == 0) {
        
    }else{
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
        HomePageModel *model = _articleArray[indexPath.row];
        ArticleInfoVC *articleVC =[[ArticleInfoVC alloc] initWithNibName:@"ArticleInfoVC" bundle:nil];
        articleVC.documentid = model.beforDocumentId;
        [self.navi pushViewController:articleVC animated:YES];
    }
}




- (void)commentAction:(UITapGestureExtension *)gesture{
    NSLog(@"添加评论");
}


#pragma mark ==-=-==-=-=-=- 点击关注按钮执行的方法 ====-=-=-----=-=-=-=-=-=-=-=
- (void)attentionFriendWhenClicked:(UIButtonExtension *)sender{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    FriendLookupCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
   
   
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:app.userId forKey:@"friend.user.id"];
        [params setObject:cell.model.ids forKey:@"friend.beuser.id"];
        [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"useraddUserFriend"] params:params result:^(id responseObj, NSError *error) {
            if ([responseObj[@"result"] intValue] == 0) {
                    [self showMessage:responseObj[@"message"]];
                    [sender setImage:[UIImage imageNamed:@"tab_communication_pre"] forState:UIControlStateNormal];
            }else{
                [self showMessage:responseObj[@"message"]];
                 [sender setImage:[UIImage imageNamed:@"tab_communication"] forState:UIControlStateNormal];
            }
        }];
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark ============ 重写  导航栏右侧按钮  及点击动作 =================
- (void)initBaseNavigationRightBar{
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(0, 0, 30, 30);
    [rightButton setImage:[UIImage imageNamed:@"nav_release.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightPage) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    
}

- (void)rightPage{
    PublishVC *publishVc = [[PublishVC alloc] initWithNibName:@"PublishVC" bundle:nil];
    publishVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publishVc animated:YES];
}


# pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
 {
     // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
         if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
         {
            return NO;
        }
    
       return  YES;
 }

@end
