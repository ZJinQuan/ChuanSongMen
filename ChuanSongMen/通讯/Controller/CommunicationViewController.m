//
//  CommunicationViewController.m
//  ChuanSongMen
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CommunicationViewController.h"
//菜单栏按钮响应视图
#import "FriendView.h"
#import "NoticeView.h"
#import "HomePageCell.h"
#import "ArticleInfoVC.h"
#import "AddFriendVC.h"//添加好友按钮
#import "FindFriendVC.h"//查找用户按钮
#import "MJRefresh.h"
@interface CommunicationViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)UIView *messageView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic,assign) int pageNumber;

@property (nonatomic, strong) HomePageModel *mainModel;
@property (nonatomic, strong) HomePageCell *homeCell;

@end

@implementation CommunicationViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //下拉加载更多
    _pageNumber = 1;
//    [_tableView addFooterWithTarget:self action:@selector(reFreshData)];
    
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(reFreshData)];
    //下拉刷新列表
//    [_tableView addHeaderWithTarget:self action:@selector(loadDataFromOriginPage)];

    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadDataFromOriginPage)];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.dataSourceArray = [NSMutableArray array];
    [self loadDataFromOriginPage];
 
}

- (void)loadDataFromOriginPage{
    _pageNumber = 1;
    [self requestDataFromSerer:_pageNumber];
    [_tableView headerEndRefreshing];
//    [_tableView.header endEdi¡ting:YES];
    
}

- (void)reFreshData{
    _pageNumber ++;
    [self requestDataFromSerer:_pageNumber];
    [_tableView footerEndRefreshing];
//    [_tableView.footer endEditing:YES];
    
}


- (void)requestDataFromSerer:(int)pageIndex{
//    [self showHUD:@"正在加载数据..."];
    
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
//    [params setObject:[NSNumber numberWithInt:self.userId] forKey:@"document.user.id"];
    [params setObject:[NSNumber numberWithInt:10] forKey:@"pageModel.pageSize"];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageModel.pageIndex"];
    
    [[HTTPRequestManager sharedManager] POST:@"http://120.24.46.199/Door/userqueryPayDocuments" params:params result:^(id responseObj, NSError *error) {
        [self hideHUD];
        
        NSLog(@"%@",responseObj[@"message"]);
        
        if (pageIndex == 1) {
            [self.dataSourceArray removeAllObjects];
        }
        if ([responseObj[@"result"] intValue] == 0 ) {
            for (NSDictionary *dic in responseObj[@"msg"]) {
                HomePageModel *homePageModel = [HomePageModel initWithDictionary:dic];
                [self.dataSourceArray addObject:homePageModel];
            }
            [_tableView reloadData];
        }else{
            [self hideHUD];
        }
        
    }];
}


#pragma mark ==========表视图代理 ======================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSourceArray.count != 0) {
        return self.dataSourceArray.count;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.dataSourceArray[indexPath.row];
    cell.navigationController = self.navigationController;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureExtension *tap = [[UITapGestureExtension alloc] initWithTarget:self action:@selector(commentAction:)];
    tap.row = indexPath.row;
    [cell.commentView addGestureRecognizer:tap];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return KScrennWith / 4 * 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomePageModel *model = _dataSourceArray[indexPath.row];
    ArticleInfoVC *articleVC =[[ArticleInfoVC alloc] initWithNibName:@"ArticleInfoVC" bundle:nil];
    articleVC.documentid = model.beforDocumentId;
    articleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:articleVC animated:YES];
    
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imageViw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, KScrennWith / 4 * 3)];
    imageViw.image = [UIImage imageNamed:@"0002"];
    return imageViw;
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HomePageCell cellHeight:self.dataSourceArray[indexPath.row]];
}









-(void)commentAction:(UITapGestureExtension *)gesture{
    self.homeCell =  (HomePageCell *)gesture.view.superview.superview.superview;
    _mainModel = _homeCell.model;
    [self adBottomCommentView];
}




#pragma mark  ============= 添加评论的网络请求 ============
- (void)sendCommentToServer:(UIButton *)sender{
    if (self.commentTextView.text.length < 1 || [self.commentTextView.text isEqualToString:@"我也说一句"]) {
        [self showMessage:@"评论不能为空"];
    }else{
        
        NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
        
        NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:userid forKey:@"discuss.user.id"];
        [params setObject:_mainModel.ids forKey:@"discuss.document.id"];
        [params setObject:self.commentTextView.text forKey:@"discuss.info"];
        
        [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"useraddDiscussListByDocumentId"] params:params result:^(id responseObj, NSError *error) {
            if ([responseObj[@"result"] intValue] == 0) {
                [self showMessage:responseObj[@"message"]];
                _homeCell.commentImage.image = [UIImage imageNamed:@"home_btn_tlak1"];
                _homeCell.comLabel.textColor = selectColor;
                self.commentTextView.text = @"我也说一句";
                self.commentTextView.textColor = [UIColor darkGrayColor];
                self.commentTextView.font = [UIFont systemFontOfSize:14];
                [self.myMaskView removeFromSuperview];
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
    if (t.view != self.bottomCommentView) {
        [self.myMaskView removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
