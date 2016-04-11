//
//  HomeViewController.m
//  ChuanSongMen
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HomeViewController.h"

#import "SearchViewController.h"


#import "LoginViewController.h"
#import "HomeTableViewCell.h"//自定义表示图
#import "MJRefresh.h"

#import "UIUtils.h"

#import "ArticleInfoVC.h"//文章详情
#import "PublishVC.h"

#import "HomePageModel.h"
#import "MJRefresh.h"
#import "HomePageCell.h"
#import "UITapGestureExtension.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate, UITextViewDelegate>
{
    
    NSArray *ar;

    //表格视图
    UITableView *_tableView;
    
    //textView的高度
    CGFloat gettextHeith;
    
    NSUserDefaults *userDefaults;//登录判断
    
    
    UIScrollView *_imageScroll;//点击图片进行浏览的
    
    int _pageNumber;

}
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) AppDelegate *myApp;
@property (nonatomic, strong) HomePageModel *mainModel;
@property (nonatomic, strong) HomePageCell *homeCell;
@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
//    self.navigationController.navigationBar.barTintColor = RGB(245, 245, 245);
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     
//     
//  @{NSFontAttributeName:[UIFont systemFontOfSize:20],
//    
//    
//    NSForegroundColorAttributeName:[UIColor blackColor]}];
    
//    self.navigationItem.titleView.backgroundColor = [UIColor blackColor];
    
    //发布内容成功后的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataFormServer) name:@"发布成功" object:nil];
    
    //分享到主页成功后的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataFormServer) name:@"successToTuiZhuan" object:nil];
    
}
- (void)refreshDataFormServer{
    _tableView.contentOffset = CGPointMake(0, 0);
    [self loadDataFromOriginPage];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLable.text = @"主页";
    self.dataSourceArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadDataFromOriginPage];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    [self initBaseNavigationLeftBar];
    [self initBaseNavigationRightBar];
    
    [self addTableView];//增加表视图
    
#pragma mark ===== 刷新列表 ==============
    //上拉刷新
//    [_tableView addHeaderWithTarget:self action:@selector(loadDataFromOriginPage)];
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadDataFromOriginPage)];
    
 //下拉加载更多
    _pageNumber = 1;
//    [_tableView addFooterWithTarget:self action:@selector(reFreshData)];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(reFreshData)];
    

}


- (void)loadDataFromOriginPage{
    _pageNumber = 1;
    [self requestDataFromSerer:_pageNumber];
    [_tableView headerEndRefreshing];
//    [_tableView.header endEditing:NO];
    
}

- (void)reFreshData{
    _pageNumber ++;
    [self requestDataFromSerer:_pageNumber];
    [_tableView footerEndRefreshing];
//    [_tableView.footer endEditing:NO];
    
}

- (void)requestDataFromSerer:(int)pageIndex{
//    [self showHUD:@"正在加载数据..."];
    
    NSInteger uid =   [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid ] stringValue];
    
    NSLog(@"%@",userid);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    self.myApp = [UIApplication sharedApplication].delegate;
//    [params setObject:_myApp.userId forKey:@"document.user.id"];
    [params setObject:userid forKey:@"document.user.id"];
    [params setObject:[NSNumber numberWithInt:10] forKey:@"pageModel.pageSize"];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageModel.pageIndex"];
    NSLog(@"params == %@", params);
    [[HTTPRequestManager sharedManager] POST:@"http://120.24.46.199/Door/usergetDocuments" params:params result:^(id responseObj, NSError *error) {
        [self hideHUD];
        if (pageIndex == 1) {
            [self.dataSourceArray removeAllObjects];
        }
        if ([responseObj[@"result"] isEqualToString:@"0"] ) {
            for (NSDictionary *dic in responseObj[@"list"]) {
                HomePageModel *homePageModel = [HomePageModel initWithDictionary:dic];
                [self.dataSourceArray addObject:homePageModel];
            }
            [_tableView reloadData];
        }else{
            [self hideHUD];
        }
        
    }];
}


#pragma mark  ============= 重新导航栏按钮 ==========
- (void)initBaseNavigationLeftBar{
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(0, 0, 50, 30);
    [leftButton setTitle:@"搜查" forState:UIControlStateNormal];
    [leftButton setTitleColor:RGB(66, 196, 228) forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftBarButton;
    
    //导航栏左侧按钮
//    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame=CGRectMake(0, 0, 50, 30);
//    [leftButton setTitle:@"搜查" forState:UIControlStateNormal];
//    [leftButton setTitleColor:RGB(66, 196, 228) forState:UIControlStateNormal];
////    [leftButton setImage:[UIImage imageNamed:@"nav_search1.png"] forState:UIControlStateNormal];
//    [leftButton addTarget:self action:@selector(leftPage) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem=leftBarButton;
}
//导航栏右侧按钮
- (void)initBaseNavigationRightBar{
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(0, 0, 50, 30);
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setTitleColor:RGB(66, 196, 228) forState:UIControlStateNormal];
//    [rightButton setImage:[UIImage imageNamed:@"nav_release.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightPage) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    
}

//增加表视图
-(void)addTableView{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-108) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}


#pragma mark 页面跳转方法
//搜索方法
#pragma mark  =============//跳转到搜索页面 ======================
-(void)leftPage{

    //跳到搜索页面
    SearchViewController *searchVC=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

//发布方法
#pragma mark ==========  点击发布图标 ======================
-(void)rightPage{
    //跳到发布推文页面
 PublishVC *publishVc = [[PublishVC alloc] initWithNibName:@"PublishVC" bundle:nil];
    publishVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publishVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return [HomePageCell cellHeight:self.dataSourceArray[indexPath.row]];
}


#pragma mark  -=-=-=-=-=-=-=-=-=-=--跳转到文章详情 -=--=-=-=-=-=-=-=-=-=-=-
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomePageModel *model = _dataSourceArray[indexPath.row];
    ArticleInfoVC *articleVC =[[ArticleInfoVC alloc] initWithNibName:@"ArticleInfoVC" bundle:nil];
    articleVC.documentid = model.beforDocumentId;
    articleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:articleVC animated:YES];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSourceArray.count != 0) {
        return self.dataSourceArray.count;
    }else{
        
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.navigationController = self.navigationController;
    cell.model = self.dataSourceArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureExtension *tap = [[UITapGestureExtension alloc] initWithTarget:self action:@selector(commentAction:)];
    tap.row = indexPath.row;
    [cell.commentView addGestureRecognizer:tap];
    return cell;
}


-(void)commentAction:(UITapGestureExtension *)gesture{
    self.homeCell =  (HomePageCell *)gesture.view.superview.superview.superview;
    _mainModel = _homeCell.model;
    [self adBottomCommentView];
}





#pragma mark ==== 添加底部评论窗口 ==============
-(void)adBottomCommentView{
    
    _homeMyMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, KScrennHeight)];
    _homeMyMaskView.backgroundColor = [UIColor clearColor];

    _homeMyMaskView.userInteractionEnabled = YES;
    _homeBottomCommentView = [[UIView alloc] initWithFrame:CGRectMake(0, KScrennHeight - 64 - 49 -37,  KScrennWith, 36)];
    _homeBottomCommentView.backgroundColor = [UIColor darkGrayColor];
    [_homeMyMaskView addSubview:_homeBottomCommentView];
    
    
    _homeCommentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 3,KScrennWith - 70, 30)];
    _homeCommentTextView.layer.cornerRadius = 5;
    _homeCommentTextView.layer.masksToBounds = YES;
    _homeCommentTextView.layer.borderWidth = 1;
    _homeCommentTextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _homeCommentTextView.font =[UIFont systemFontOfSize:14];
    _homeCommentTextView.text = @"我也说一句";
    _homeCommentTextView.textColor = [UIColor darkGrayColor];
    _homeCommentTextView.delegate = self;
    [_homeBottomCommentView addSubview:_homeCommentTextView];
    
    
    _homeSendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_homeSendButton setTitle:@"发送" forState:UIControlStateNormal];
    _homeSendButton.frame = CGRectMake(KScrennWith - 55, 3, 45, 30);
    _homeSendButton.layer.cornerRadius = 5;
    _homeSendButton.layer.masksToBounds = YES;
    _homeSendButton.backgroundColor = [UIColor whiteColor];
    _homeSendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_homeSendButton addTarget:self action:@selector(sendCommentToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_homeSendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_homeBottomCommentView addSubview:_homeSendButton];
    
     [self.view addSubview:_homeMyMaskView];
}
#pragma mark  ============= 添加评论的网络请求 ============
- (void)sendCommentToServer:(UIButton *)sender{
    if (_homeCommentTextView.text.length < 1 || [_homeCommentTextView.text isEqualToString:@"我也说一句"]) {
        [self showMessage:@"评论不能为空"];
    }else{

        NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
        
        NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:userid forKey:@"discuss.user.id"];
        [params setObject:_mainModel.ids forKey:@"discuss.document.id"];
        [params setObject:_homeCommentTextView.text forKey:@"discuss.info"];
        
        [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"useraddDiscussListByDocumentId"] params:params result:^(id responseObj, NSError *error) {
            NSLog(@"%@", responseObj[@"message"]);
            if ([responseObj[@"result"] intValue] == 0) {
                [self showMessage:responseObj[@"message"]];
                [_homeMyMaskView removeFromSuperview];
                _homeCell.commentImage.image = [UIImage imageNamed:@"home_btn_tlak1"];
                _homeCell.comLabel.textColor = selectColor;
                _homeCommentTextView.text = @"我也说一句";
                _homeCommentTextView.textColor = [UIColor darkGrayColor];
                _homeCommentTextView.font = [UIFont systemFontOfSize:14];
                
                
                [self commentNumberAdd];
                
            }else{
                [self showMessage:responseObj[@"message"]];
            }
        }];
    }
}


#pragma mark ========= 发表评论后 评论数增加 ======
-(void)commentNumberAdd{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_mainModel.ids forKey:@"id"];
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"userupdateDocumentCount"] params:params result:^(id responseObj, NSError *error) {
        if ([responseObj[@"result"] intValue] == 0) {
            _homeCell.commentLabel.text = [NSString stringWithFormat:@"%d", [_homeCell.model.discussCount intValue] + 1];
            _homeCell.commentLabel.textColor = selectColor;
        }else{
            [self showMessage:responseObj[@"message"]];
        }
    }];
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
    if (textView.text.length<1) {
        textView.text = @"我也说一句";
        textView.textColor = [UIColor darkGrayColor];
        textView.font = [UIFont systemFontOfSize:14];
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * t = [touches anyObject];
    if (t.view != _homeBottomCommentView) {
        [_homeMyMaskView removeFromSuperview];
    }
}

@end
