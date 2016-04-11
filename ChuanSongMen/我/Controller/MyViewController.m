//
//  MyViewController.m
//  ChuanSongMen
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyViewController.h"
#import "ADView.h"//广告视图
#import "MyMessageView.h"//个人视图
#import "MyViewSetViewController.h"//设置按钮跳转页面
#import "PurseViewController.h"
#import "PersonalDataVC.h"//个人资料
#import "HomeTableViewCell.h"
#import "ArticleInfoVC.h"//文章详情
#import "MyCollectionCell.h"
#import "UIView+Extension.h"


#import "MediumCell.h"
#import "MediumModel.h"
#import "UIImageView+WebCache.h"
#import "UserInformationModel.h"
#define photoHeight [[UIScreen mainScreen] bounds].size.width / 3 * 2

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,MyMessageViewDelegate,UIActionSheetDelegate, UIScrollViewDelegate, UITextViewDelegate>

{
    NSArray *ar;
    UITableView *_tableView;
    
    //顶部广告视图
    UIImageView *_ADImageView;
    //增加头部视图
    MyMessageView *_headerView;
    UIScrollView *_imageScroll;//点击图片进行浏览的
    //textView的高度
    CGFloat gettextHeith;
    
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_layout;
}
@end

@implementation MyViewController
//隐藏导航栏
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTheScorllViewContentOffset:) name:@"选中分组控制" object:nil];
    
    
}

- (void)removeTheScorllViewContentOffset:(NSNotification *)notification{
    if (notification != nil) {
        CGFloat hor = KScrennWith * [(NSString *)notification.object floatValue];
        _smallScrollView.contentOffset = CGPointMake(hor, 0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstSourceArray = [NSMutableArray array];
    self.secondSourceArray = [NSMutableArray array];
    self.thirdSourceArray = [NSMutableArray array];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
  
    _bigScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _bigScrollView.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview: _bigScrollView];
    
    ADView *adPage=[[ADView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, KScrennHeight /2 - 30 )];
    adPage.bgView.layer.cornerRadius=5;
    adPage.bgView.alpha=0.8;
    [_bigScrollView addSubview:adPage];
    
    _headerView = [[MyMessageView alloc] initWithFrame:CGRectMake(0, KScrennHeight /2 - 30, KScrennWith, 140)];
    _headerView.delegate = self;
    _headerView.segmentedControl.selectedSegmentIndex = 0;
    [_bigScrollView addSubview:_headerView];
   
    
    
    _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, adPage.height + _headerView.height, KScrennWith, KScrennHeight)];
    _smallScrollView.delegate = self;
    
    _bigScrollView.contentSize = CGSizeMake(0, KScrennHeight + adPage.height  + _headerView.height - 64);
    _smallScrollView.contentSize = CGSizeMake(KScrennWith * 3, 0);
     _smallScrollView.pagingEnabled = YES;
    
    _bigScrollView.tag = 3000;
#pragma mark ===== 大的滑动视图的代理 暂时待定 ===========================
    _bigScrollView.delegate = self;
    
    [_bigScrollView addSubview:_smallScrollView];
    
    
    [self addTableView];
    
    [self firstTableViewRequestFormServer];
    [self secondTableViewRequestFormServer];
    [self thirdTableViewRequestFormServer];
    [self requestPersonalInfoFromServer];
}

#pragma mark ======= 添加三个表视图 ====================
- (void)addTableView{
    // 创建表视图
    _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScrennWith, KScrennHeight - 64 - 49) style:UITableViewStylePlain];
    _firstTableView.tag = 2001;
    
    _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(KScrennWith, 0, KScrennWith, KScrennHeight - 64 - 49) style:UITableViewStylePlain];
    _secondTableView.tag = 2002;
    
    _thirdTableView = [[UITableView alloc] initWithFrame:CGRectMake(KScrennWith * 2, 0, KScrennWith, KScrennHeight - 64 - 49) style:UITableViewStylePlain];
    _thirdTableView.tag = 2003;
    
   
    [_smallScrollView addSubview:_firstTableView];
    [_smallScrollView addSubview:_secondTableView];
    [_smallScrollView addSubview:_thirdTableView];
    
    [_firstTableView registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_secondTableView registerNib:[UINib nibWithNibName:@"MediumCell" bundle:nil] forCellReuseIdentifier:@"mediumCell"];
        _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_thirdTableView registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _thirdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
// 设置代理
    _firstTableView.delegate = self;
    _firstTableView.dataSource = self;
    
    _secondTableView.delegate = self;
    _secondTableView.dataSource = self;
    
    _thirdTableView.delegate = self;
    _thirdTableView.dataSource = self;
    
  
}
#pragma mark ======== 第一个表视图网络请求 ==============
- (void)firstTableViewRequestFormServer{
    
    NSInteger uid =   [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    [self.firstSourceArray  removeAllObjects];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSMutableDictionary *pararm = [NSMutableDictionary dictionary];
    [pararm setObject:userid forKey:@"userid"];
    [pararm setObject:@"1" forKey:@"type"];
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"userqueryDocuments"] params:pararm result:^(id responseObj, NSError *error) {
        if ([responseObj[@"result"] intValue] == 0) {
            for (NSDictionary *dic in responseObj[@"msg"]) {
                HomePageModel *model = [HomePageModel initWithDictionary:dic];
                [self.firstSourceArray addObject:model];
            }
        }
        [_firstTableView reloadData];
        
    }];
}

#pragma mark ======== 第二个表视图网络请求 ==============
- (void)secondTableViewRequestFormServer{
    [_secondSourceArray removeAllObjects];
    
    NSInteger uid =   [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSMutableDictionary *pararm = [NSMutableDictionary dictionary];
    [pararm setObject:userid forKey:@"userid"];
    [pararm setObject:@"1" forKey:@"type"];
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"userqueryUserPrint"] params:pararm result:^(id responseObj, NSError *error) {
        if ([responseObj[@"result"] intValue] == 0) {
            for (NSDictionary *dic in responseObj[@"msg"]) {
                if (dic[@"video"] != nil) {
    
                }
                NSArray *array = dic[@"photoList"];
                if (array.count > 0) {
                    for (NSDictionary *smallDic in dic[@"photoList"]) {
                            MediumModel *model = [MediumModel initWithDictionary:smallDic];
                            [self.secondSourceArray addObject:model];
                    }
                }
            }
        }
        [_firstTableView reloadData];
    }];
}

#pragma mark ======== 第三个表视图网络请求 ==============
- (void)thirdTableViewRequestFormServer{
    [self.thirdSourceArray  removeAllObjects];
    
    NSInteger uid =   [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSMutableDictionary *pararm = [NSMutableDictionary dictionary];
    [pararm setObject:userid forKey:@"userid"];
    [pararm setObject:@"4" forKey:@"type"];
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"userqueryDocuments"] params:pararm result:^(id responseObj, NSError *error) {
        if ([responseObj[@"result"] intValue] == 0) {
            for (NSDictionary *dic in responseObj[@"msg"]) {
                HomePageModel *model = [HomePageModel initWithDictionary:dic];
                [self.thirdSourceArray addObject:model];
            }
        }
        [_thirdTableView reloadData];
        
    }];
}


#pragma amrk =====  从服务器获取个人信息 ============
- (void)requestPersonalInfoFromServer{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    NSInteger uid =   [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:userid forKey:@"id"];
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"usergetUserIn"] params:dic result:^(id responseObj, NSError *error) {
        if ([responseObj[@"result"] intValue] == 0) {
            UserInformationModel *model = [UserInformationModel initWithDictionary:responseObj];
            _headerView.nickName.text = model.niCheng;
            _headerView.userNameLabel.text = model.userName;
            if (![model.url isEqualToString:@""]) {
//                [_headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.url]];
                [_headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.46.199/Door%@",model.url]]];
            }
            
            
            [_tableView reloadData];
        }else{
            [self showMessage:responseObj[@"message"]];
        }
    }];
    
}



#pragma mark =========UITableViewDataSource  && UITableViewDelegate ===========
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 2001 ) {
        return self.firstSourceArray.count;
    }else if(tableView.tag == 2002){
        if (self.secondSourceArray.count > 0) {
             return self.secondSourceArray.count;
        }else{
            return 0;
        }
    }else{
        return self.thirdSourceArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 2001) {
        HomePageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.model = self.firstSourceArray[indexPath.row];
        cell.navigationController = self.navigationController;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UITapGestureExtension *tap = [[UITapGestureExtension alloc] initWithTarget:self action:@selector(commentAction:)];
        tap.row = indexPath.row;
        [cell.commentView addGestureRecognizer:tap];
        
        
        return cell;
    }else if (tableView.tag == 2002){
        MediumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediumCell"];
        if (self.secondSourceArray.count > 0) {
            cell.model = self.secondSourceArray[indexPath.row];
        }
        return cell;
    }else{
    HomePageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.thirdSourceArray[indexPath.row];
    cell.navigationController = self.navigationController;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureExtension *tap = [[UITapGestureExtension alloc] initWithTarget:self action:@selector(commentAction:)];
    tap.row = indexPath.row;
    [cell.commentView addGestureRecognizer:tap];
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2002) {
         return KScrennWith / 5 * 3;
    }else if(tableView.tag == 2001){
        return [HomePageCell cellHeight:self.firstSourceArray[indexPath.row]];
    }else{
        return [HomePageCell cellHeight:self.thirdSourceArray[indexPath.row]];
    }
}

#pragma mark=========== 跳转到文章详情======
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2001) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        HomePageModel *model = self.firstSourceArray[indexPath.row];
        ArticleInfoVC *articleVC =[[ArticleInfoVC alloc] initWithNibName:@"ArticleInfoVC" bundle:nil];
        articleVC.documentid = model.beforDocumentId;
        articleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:articleVC animated:YES];
    }else if (tableView.tag == 2002){
        
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        HomePageModel *model = self.thirdSourceArray[indexPath.row];
        
        ArticleInfoVC *articleVC =[[ArticleInfoVC alloc] initWithNibName:@"ArticleInfoVC" bundle:nil];
        
        articleVC.documentid = model.beforDocumentId;
        articleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:articleVC animated:YES];
        
    }    
}

#pragma mark MyMessageViewDelegate
#pragma mark ========== 设置 ==================
-(void)MyMessageViewSetButtonPress{
    MyViewSetViewController *myViewSetPage = [[MyViewSetViewController alloc] init];
    myViewSetPage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myViewSetPage animated:YES];
}
#pragma mark ==========我的钱包 ==================
-(void)MyMessageViewPurseButtonPress{
    PurseViewController *purseVC=[[PurseViewController alloc] init];
    purseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:purseVC animated:YES];
}
#pragma mark ========== 编辑资料 ==================
-(void)MyMessageViewEditePurseButtonPress{
    PersonalDataVC *personlDataVC=[[PersonalDataVC alloc] init];
    personlDataVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personlDataVC animated:YES];
}


#pragma mark ========滑动视图代理  UIScrollViewDelegate =====================
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    int  currentIndex = scrollView.contentOffset.x / KScrennWith;
    _headerView.segmentedControl.selectedSegmentIndex = currentIndex;
    
}

#pragma mark ==== 滑动视图联动效果 ===============
#pragma mark ====此效果暂时不理想, 待定完善 ==================
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
//{
//    NSLog(@"%ld",(long)scrollView.tag);
//    CGFloat yyy = scrollView.contentOffset.y;
//    CGFloat maxYYY =  KScrennHeight /2 - 30  + _headerView.height - 64 - 50;
//    NSLog(@"大的滑动视图的最大偏移量是%f, 当前偏移量是 %f", maxYYY, yyy);
//    if (yyy >= maxYYY) {
////        _bigScrollView.contentOffset =  CGPointMake(0, yyy);
//        _firstTableView.scrollEnabled = YES;
//        _secondTableView.scrollEnabled = YES;
//        _thirdTableView.scrollEnabled = YES;
//    }else{
////       _bigScrollView.contentOffset =  CGPointMake(0, maxYYY);
//        _firstTableView.scrollEnabled = NO;
//        _secondTableView.scrollEnabled = NO;
//        _thirdTableView.scrollEnabled = NO;
//    }
//    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
//}

#pragma mark =========== 评论按钮点击事件 ===================
- (void)commentAction:(UITapGestureExtension *)gesture{
    self.homeCell = (HomePageCell *)gesture.view.superview.superview.superview;
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
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        [params setObject:userid forKey:@"discuss.user.id"];
        [params setObject:_mainModel.ids forKey:@"discuss.document.id"];
        [params setObject:self.commentTextView.text forKey:@"discuss.info"];
        
        [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"useraddDiscussListByDocumentId"] params:params result:^(id responseObj, NSError *error) {
            if ([responseObj[@"result"] intValue] == 0) {
                [self showMessage:responseObj[@"message"]];
                _homeCell.commentImage.image = [UIImage imageNamed:@"home_btn_tlak1"];
                _homeCell.comLabel.textColor = selectColor;
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

#pragma MARK ========= 监听 触摸事件 ===========================
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
