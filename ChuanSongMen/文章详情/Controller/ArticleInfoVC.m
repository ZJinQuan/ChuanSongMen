//
//  ArticleInfoVC.m
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ArticleInfoVC.h"
#import "TopViewController.h"
#import "CommentCell.h"
#import "PublishVC.h"
#import "CommentModel.h"
#import "ArticleInfoModel.h"
@interface ArticleInfoVC ()<UITableViewDataSource, UITableViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *bottomTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendArticleButton;
@property (nonatomic, strong) TopViewController *top;
@property (nonatomic, strong) ArticleInfoModel *model;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;


@end

@implementation ArticleInfoVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    self.titleLable.text = @"正文";
    _bottomTextView.delegate = self;
    [self changeLayerOfSomeControl:_bottomTextView];
    [self changeLayerOfSomeControl:_sendArticleButton];
    
            _top = [[TopViewController alloc] initWithNibName:@"TopViewController" bundle:nil];
            _top.documentid = self.documentid;
          _top.view.frame = CGRectMake(0,100 ,self.view.frame.size.width, [TopViewController heightForTheHeaderView:_model] + 10);
    _top.naviga = self.navigationController;
    
    
    self.dataSourceArray = [NSMutableArray array];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
//
    [self userCommentRequest];
    [self requestArticleDetailInfoFromServer];
}


#pragma mark ========= 获取文章详情 ===================
- (void)requestArticleDetailInfoFromServer{
    
    NSInteger uid =   [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid ] stringValue];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userid"];
    [params  setObject:self.documentid forKey:@"documentid"];
    [self showHUD:nil];
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"userqueryDocumentsDetails"] params:params result:^(id responseObj, NSError *error) {
        [self hideHUD];
        if ([responseObj[@"result"] intValue] == 0) {
            self.model = [ArticleInfoModel initWithDictionary:responseObj];
            _discussCount = [self.model.discussCount intValue];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark ====== 获取评论内容 ========
- (void)userCommentRequest{
    [self.dataSourceArray removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.documentid forKey:@"document.id"];
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"usergetDiscussListByDocumentId"] params:params result:^(id responseObj, NSError *error) {
        for (NSDictionary *dic in responseObj[@"list"]) {
            CommentModel *commentModel = [CommentModel initWithDictionary:dic];
            [self.dataSourceArray addObject:commentModel];
        }
        [self.tableView reloadData];

        
        
    }];
    
}


//导航栏右侧按钮
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
    [self.navigationController pushViewController:publishVc animated:YES];
    
}

#pragma mark ======  发送评论 方法实现 ==============
- (IBAction)sendCommentAction:(UIButton *)sender {
    if (_bottomTextView.text.length < 1 || [_bottomTextView.text isEqualToString:@"我也说一句"]) {
        [self showMessage:@"评论不能为空"];
    }else{
        [self showHUD:nil];
        
        NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
        
        NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:userid forKey:@"discuss.user.id"];
        [params setObject:self.documentid forKey:@"discuss.document.id"];
        [params setObject:_bottomTextView.text forKey:@"discuss.info"];
        
        [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"useraddDiscussListByDocumentId"] params:params result:^(id responseObj, NSError *error) {
            [self hideHUD];
            if ([responseObj[@"result"] intValue] == 0) {
                
                [self showMessage:responseObj[@"message"]];
                _discussCount += 1;
                _bottomTextView.text = @"我也说一句";
                _bottomTextView.textColor = [UIColor darkGrayColor];
                _bottomTextView.font = [UIFont systemFontOfSize:14];
                _top.commentNumberLabel.text =[NSString stringWithFormat:@"%d", _discussCount];
                [self userCommentRequest];
                
            }else{
                [self showMessage:responseObj[@"message"]];
            }
        }];
    }
}


#pragma mark  ====== UITableViewDelegate && UITabelViewDataSource ============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    cell.model = self.dataSourceArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [CommentCell  heightForCellByModel:self.dataSourceArray[indexPath.row]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _top.view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"头部 数据模型 model ==<<<<<<<<<<< %@", _model);
    NSLog(@" 头部高度为>>>>>>>>>%f", [TopViewController heightForTheHeaderView:_model] + 10);
    return   [TopViewController heightForTheHeaderView:_model] + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}



#pragma mark =======  文本视图 代理 ===============
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"我也说一句"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont systemFontOfSize:12];
    }
}
//3.在结束编辑的代理方法中进行如下操作
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length < 1) {
        textView.text = @"我也说一句";
        textView.textColor = [UIColor darkGrayColor];
        textView.font = [UIFont systemFontOfSize:14];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
