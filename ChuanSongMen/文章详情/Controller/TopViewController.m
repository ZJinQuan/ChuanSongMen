//
//  TopViewController.m
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TopViewController.h"
#import "ImageCollectionCell.h"
#import "UIViewAdditions.h"
#import "LargerImgVC.h"
#import "PreviewVideoCell.h"
#import "VideoPlayVc.h"
@interface TopViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate>
@property (nonatomic, strong) ArticleInfoModel *model;
@property (nonatomic, strong) UIImageView *rewardImageView;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, assign) BOOL isVideo;
@end

@implementation TopViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imagesArray = [NSMutableArray array];
    [self changeLayerOfSomeControl:self.shareView];
    [self changeBorderOfSomeControl:self.shareView borderColor:RGB(255, 127, 0) borderWidth:1];
    [self changeLayerOfSomeControl:self.userHeaderImageView];
    
    
    
    [self addGestureToSomeView];
    [self requestArticleDetailInfoFromServer];
    
    
    

}
#pragma mark ======  添加手势 =============
- (void)addGestureToSomeView{
    //点赞手势
    UITapGestureRecognizer *praiseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(praiseAction)];
    [_praiseView addGestureRecognizer:praiseTap];
    
    //收藏手势
    UITapGestureRecognizer *collectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectAction)];
    [_collectView addGestureRecognizer:collectTap];
    
    //更多手势
    UITapGestureRecognizer *moreTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreAction)];
    [_moreView addGestureRecognizer:moreTap];
    
}
#pragma mark  ============= 手势实现方法 ============
//点赞
- (void)praiseAction{
    NSLog(@"点赞");
    
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    [params setObject:_model.ids forKey:@"documentId"];
    
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"useraddTopOrCancleTop"] params:params result:^(id responseObj, NSError *error) {
        if ([responseObj[@"result"] intValue] == 0) {
#pragma mark ===== 判断是否是点赞 还是取消赞==========
    if (_isPraise == 0) {
        _zanNumber += 1;
        _praiseNumberLabel.text = [NSString stringWithFormat:@"%d", _zanNumber ];
        _praiseImageView.image = [UIImage imageNamed:@"home_btn_zan1(1)"];
        _zanLabei.textColor = selectColor;
        _isPraise = 1;
        [self showMessage:@"已赞"];
        
    }else{
        _isPraise = 0;
        _zanNumber -= 1;
        _praiseNumberLabel.text = [NSString stringWithFormat:@"%d", _zanNumber];
        _praiseImageView.image = [UIImage imageNamed:@"home_btn_zan.png"];
        _zanLabei.textColor = [UIColor blackColor];
        [self showMessage:@"已取消赞"];
    }
}else{
    [self showMessage:responseObj[@"message"]];
}
}];






}

//收藏
- (void)collectAction{
    NSLog(@"收藏");
    
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    [params setObject:_model.ids forKey:@"documentId"];
    
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"DuseraddCollectionOrCancle"] params:params result:^(id responseObj, NSError *error) {
        if (_isCollect == 0) {
            [self showMessage:@"已收藏"];
            _collectImageView.image = [UIImage imageNamed:@"home_btn_tlak1"];
            _collectLabel.textColor = selectColor;
            _isCollect = 1;
            
        }else{
            _isCollect = 0;
            [self showMessage:@"已取消收藏"];
             _collectImageView.image = [UIImage imageNamed:@"home_btn_tlak.png"];
             _collectLabel.textColor = [UIColor blackColor];
        }
    }];
    
    
    
    
    
}
//更多
- (void)moreAction{
    NSLog(@"更多");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享给好友", @"分享到主页" , @"复制链接", @"举报", nil];
    [actionSheet showInView:self.view];
}








#pragma mark ======  文章详情 请求 ==================
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
            [self addInfoByModel];
        }
    }];
}

#pragma mark ======= 给视图控件赋值==========
- (void)addInfoByModel{
    [_userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BasePicAppending@"%@",_model.userHead]]];
    _userNameLabel.text = _model.userName;   // 用户名
    _nickNAmeLabel.text = _model.niCheng;    //昵称
    _infoLabel.text = _model.info;          //正文
    _timeLabel.text = _model.createDate;   //发布时间
    
    _praiseNumberLabel.text = _model.topCount;   //点赞数
    _zanNumber = [_model.topCount intValue];
    if ([_model.isTop isEqualToString:@"1"]) { //如果已点赞
        _isPraise = 1;
        _praiseImageView.image = [UIImage imageNamed:@"home_btn_zan1(1)"];
        _zanLabei.textColor = selectColor;
    }
    
    _commentNumberLabel.text = _model.discussCount; //评论数
    _shareNumberLabel.text = _model.shareCount; //分享数
    _shareNumber = [_model.shareCount intValue];
    if ([_model.transpondType isEqualToString:@"1"]) { //1为转发
        _topLabel.text = [NSString stringWithFormat:@"%@推转了",_model.documentNiCheng];
    }else{  //0为原创
        [_topView removeFromSuperview];
        _nameViewTop.constant = 0;
    }

   self.infoHeight.constant = [self heightForString:_model.info fontSize:15 andWidth:_infoLabel.width];
    
#pragma mark ==== 悬赏图设置=====-=-=-=-=-
    if ([_model.type isEqualToString:@"2"]) { //赏金悬赏
        _rewardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width - 100, 0, 100, 100)];
        _rewardImageView.image = [UIImage imageNamed:@"share_reward.png"];
        [self.view addSubview:_rewardImageView];
    }else if ([_model.type isEqualToString:@"3"]) { //广告位悬赏
        _rewardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width - 100, 0, 100, 100)];
        _rewardImageView.image = [UIImage imageNamed:@"advert_reward.png"];
        [self.view addSubview:_rewardImageView];
    }else{
        [_shareView removeFromSuperview];
        _middleViewHeight.constant = 120;
    }
    
    
#pragma mark ======== 集合视图设置 ========================
    if (_model.photoList.count > 0) {
        _isVideo = 0;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;

        [_collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"imageCell"];
        
        _collectionHeight.constant = (KScrennWith / 5 * 3) * _model.photoList.count + 2 * (_model.photoList.count - 1);
        _collectionView.scrollEnabled = NO;
        
        _middleViewTop.constant = _collectionHeight.constant + 25 + (int)_infoHeight.constant;
#pragma mark  ========== 这里暂时待定, 等待检测 =====================
        [_imagesArray removeAllObjects];
//        [_collectionView reloadData];
    }else if(![_model.preview isEqualToString:@""]){
                _isVideo = 1;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"PreviewVideoCell" bundle:nil] forCellWithReuseIdentifier:@"videoCell"];

        _collectionHeight.constant = KScrennWith / 5 * 3;
        _collectionView.scrollEnabled = NO;
        
        _middleViewTop.constant = _collectionHeight.constant + 25 + (int)_infoHeight.constant;

        
    }else{
        [_collectionView removeFromSuperview];
        _middleViewTop.constant = _infoHeight.constant + 25;
    }
            [_collectionView reloadData];
}


#pragma mark  ============= 集合视图代理 =======================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_model.photoList.count > 0) {
          return _model.photoList.count;
    }else{
        return 1;
    }
    
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    if ([_model.preview isEqualToString:@""]) {
         NSDictionary *dic = _model.photoList[indexPath.row];
        ImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
         [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BasePicAppending@"%@", dic[@"url"]]]];
        return cell;
    }else{
        PreviewVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCell" forIndexPath:indexPath];
        cell.preViewImage.contentMode = UIViewContentModeScaleAspectFill;
        [cell.preViewImage sd_setImageWithURL:[NSURL URLWithString:_model.preview]];
        return cell;
    }

    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     return CGSizeMake(KScrennWith, KScrennWith / 5 * 3);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isVideo == 0) {
        LargerImgVC *largeVC = [[LargerImgVC alloc] init];
        largeVC.imgDataArr = [_model.photoList mutableCopy];
        largeVC.currentIndex = indexPath.row;
        [self.naviga pushViewController:largeVC animated:YES];
    }else{
        VideoPlayVc *videoPlayVc = [[VideoPlayVc alloc] init];
        videoPlayVc.videoUrl = _model.video;
        [self.naviga pushViewController:videoPlayVc animated:YES];
    }

}





#pragma mark === 高度自适应 ========
+ (CGFloat)heightForTheHeaderView:(ArticleInfoModel *)model{
    NSLog(@"model =====%@", model);
    CGFloat rect = 70;
    if ([model.transpondType isEqualToString:@"1"]) { //1为转发
        rect += 25;
    }
    
     CGRect textHeight = [model.info boundingRectWithSize:CGSizeMake(KScrennWith - 60, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    rect += textHeight.size.height;

    if ([model.type isEqualToString:@"1"]) { //免费发布
        rect += 120;
    }else{
        rect += 150;
    }
    
    
    if (model.photoList.count == 0 && [model.preview isEqualToString:@""]) {
        rect += 15;  // 空隙之和
    }else if(model.photoList.count > 0 && [model.preview isEqualToString:@""]){
        rect += 15;
       CGFloat photosHeight = (KScrennWith / 5 * 3) * model.photoList.count;
        rect += photosHeight;
    }else{
        rect += 15;
        CGFloat photosHeight = KScrennWith / 5 * 3;
        rect += photosHeight;
    }
    NSLog(@" rect === >>>>>%f", rect);
    return rect;
    
}








#pragma mark ========== actionSheetDelegate ================
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"分享给好友");
        }
            break;
        case 1:
        {
            NSLog(@"分享到主页");
            NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
            
            NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
            
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:userid forKey:@"user.id"];
            [params setObject:@"11" forKey:@"document.info"];
            [params setObject:_model.ids forKey:@"document.id"];
            [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"usertranspondDocument"] params:params result:^(id responseObj, NSError *error) {
                if ([responseObj[@"result"] intValue] == 0) {
                    [self showMessage:@"分享数量+1"];
                    self.shareNumber += 1;
                    _shareNumberLabel.text = [NSString stringWithFormat:@"%d", self.shareNumber];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"successToTuiZhuan" object:nil];

                    
                }else{
                    [self showMessage:responseObj[@"message"]];
                }
                
                
                
            }];
            
            
            
            

            
        }
            break;
        case 2:
        {
            NSLog(@"复制链接");
        }
            break;
        case 3:
        {
            NSLog(@"举报");
        }
            break;
            
        default:
            break;
    }
}







- (void)showMessage:(NSString *)string {
    LPPopup *popup = [LPPopup popupWithText:string];
    popup.textColor = [UIColor blackColor];
    [popup showInView:self.view.superview.window
        centerAtPoint:self.view.superview.window.center
             duration:1
           completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
