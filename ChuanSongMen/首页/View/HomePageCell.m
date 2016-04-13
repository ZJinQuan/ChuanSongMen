//
//  HomePageCell.m
//  ChuanSongMen
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomePageCell.h"
#import "UIImageView+WebCache.h"
#import "UIViewAdditions.h"
#import "MyTools.h"
#import "MyTools.h"
#import "HomePhotoCell.h"
#import "AppDelegate.h"
#import "LargerImgVC.h"
#import "VideoPlayVc.h"
#import "FriendsComtroller.h"

@interface HomePageCell ()

@property (nonatomic, strong) FriendsComtroller *friendVC;

@end

@implementation HomePageCell

- (void)awakeFromNib {
    self.app =[UIApplication sharedApplication].delegate;
    self.rewardView.layer.borderColor = [RGB(238, 60, 65)CGColor];
    self.rewardView.layer.borderWidth = 1;
    [self changeLayerOfSomeControl:self.rewardView];
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScrennWith - 85, 20, 80, 80)];
    [self.rightImageView removeFromSuperview];
    
    self.imagesArray  = [NSMutableArray array];
    
    _zanView.tag = 1002;
    _commentView.tag = 1003;
    _shareView.tag = 1004;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationCellZan)];
    [_zanView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationCellShare)];
    [_shareView addGestureRecognizer:tap3];
}
#pragma mark =========   点赞行为 ===================
- (void)operationCellZan{
    NSLog(@"赞");
    
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_ShortVersion"];
    
    NSString *userid = [[NSNumber numberWithInteger:uid] stringValue];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    [params setObject:_model.ids forKey:@"documentId"];
    
    [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"useraddTopOrCancleTop"] params:params result:^(id responseObj, NSError *error) {
        if ([responseObj[@"result"] intValue] == 0) {
            NSString *resultInfo = responseObj[@"message"];
#pragma mark ===== 判断是否是点赞 还是取消赞==========
            if ([resultInfo isEqualToString:@"点赞成功"]) {
                _zanNumber += 1;
              _praiseLabel.text = [NSString stringWithFormat:@"%d", _zanNumber ];
                _zanImage.image = [UIImage imageNamed:@"home_btn_zan1(1)"];
                _zanLabel.textColor = selectColor;
                _praiseLabel.textColor = selectColor;
            }else{
                _zanNumber -= 1;
                _praiseLabel.text = [NSString stringWithFormat:@"%d", _zanNumber];
                _zanImage.image = [UIImage imageNamed:@"home_btn_zan.png"];
                _zanLabel.textColor = [UIColor blackColor];
                _praiseLabel.textColor = [UIColor blackColor];
            }
        }else{
            [self showMessage:responseObj[@"message"]];
        }
    }];
    
    
    
}

#pragma mark  =============分享行为 ===========
- (void)operationCellShare{
       NSLog(@"分享");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享给好友", @"分享到主页" , @"复制链接", @"举报", nil];
    [actionSheet showInView:self.superview.window];
}

#pragma mark ===  跳入视频播放页面 =================
- (void)skipToPlayVideosPage:(UITapGestureRecognizer *)tap{
    VideoPlayVc *videoVC = [[VideoPlayVc alloc] init];
    videoVC.videoUrl = _model.video;
    videoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:videoVC animated:YES];


    
}


#pragma mark  =============获取单元格的高度自适应  ===========
+ (CGFloat)cellHeight:(HomePageModel *)model
{
    /*
     NSString的对象方法,
     1.用于计算给定的某段文体,在某种字体和字号下,在某个范围下根据不同的断行方式要正常显示需要的高度
     参1: 参考显示范围,(注意,宽度给正确,高度随意,0就行(因为是自适应))
     参2: 断行方式(一下代码中的值,计算结果是较准确的,视情况自定)
     参3: 字体,字号 [注]:和最终所在label的字号一定要一致
     参4: nil

     */
    int topHeight = 50;
    if ([model.transpondType isEqualToString:@"0"]) {
        topHeight = 30;
    }
    
    
    CGRect rect = [model.info boundingRectWithSize:CGSizeMake(KScrennWith - 65, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil];

    if (model.photoList.count < 1 && [model.preview isEqualToString:@""]) {
        CGFloat height = topHeight + rect.size.height + 45;
        if (height < 120 ) {
            if ([model.type isEqualToString:@"1"]) {
              return  height + 15;
            }else{
                return height + 50 + 30;
            }
        }else{
            return height + 15;
        }
    }else {
        return rect.size.height + 5 + (KScrennWith - 67)/ 5 * 3 + topHeight + 40;
    }
}



#pragma mark  =============点击图片后的执行动作  ===========
-(void)selectedPhotoToVisit:(UITapGestureRecognizer *)gesture{
    
    NSLog(@"点击了第%d张图片",((UIImageViewExtension *)gesture.view).row);

    LargerImgVC *largeVC = [[LargerImgVC alloc] init];
    largeVC.imgDataArr = [_model.photoList mutableCopy];
    largeVC.currentIndex = ((UIImageViewExtension *)gesture.view).row;
    largeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:largeVC animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark ===  重写Model, 给单元格赋予数据================================
- (void)setModel:(HomePageModel *)model{
    _model = model;
    
    self.friendVC.model = model;
    
    _photoTop = 30;
    if ([_model.transpondType isEqualToString:@"0"]) {
          [_topView removeFromSuperview];
        _leftViewTop.constant = 0;
        _nameViewTop.constant  = 0;
        _timeLabelTop.constant = 0;
    }else{
        _topLabel.text = [NSString stringWithFormat:@"%@转推了", _model.niCheng];
        _photoTop += 20;
    }
    
    _titleHeight.constant = [self heightForString:_model.info fontSize:13 andWidth:KScrennWith - 65] + 5;
    _nameWidth.constant = [self widthForString:_model.niCheng fontSize:16 andHeight:25];
    _photoTop += _titleHeight.constant + 5;
    //用户头像
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.46.199/Door%@",_model.userHead]]];
    [self changeLayerOfSomeControl:_headerImageView];
    
    _nameLabebl.text = _model.niCheng;   //昵称
    _subNameLabel.text = _model.userName; //用户名
    _titleLabel.text = _model.info; //正文
 
    _praiseLabel.text = _model.topCount; //点赞数
    _zanNumber = [_model.topCount intValue];
    
    _commentLabel.text = _model.discussCount; //评论数
    _timeLabel.text = model.createDate; //发布时间
     self.imageArray = [_model.photoList copy];
    
#pragma mark ======= 底部图标文字是否变色 ===================
    if ([_model.isTop isEqualToString:@"1"]) {  //若点赞了
        _zanImage.image = [UIImage imageNamed:@"home_btn_zan1(1)"];
        _zanLabel.textColor = selectColor;
        _praiseLabel.textColor = selectColor;
        
    }else{
        _zanImage.image = [UIImage imageNamed:@"home_btn_zan.png"];
        _zanLabel.textColor = [UIColor blackColor];
        _praiseLabel.textColor = [UIColor blackColor];
    }
    if ([_model.isDiscuss isEqualToString:@"1"]) { //若评论过
        _commentImage.image = [UIImage imageNamed:@"home_btn_tlak1"];
        _comLabel.textColor = selectColor;
        _commentLabel.textColor = selectColor;
    }else{
        _commentImage.image = [UIImage imageNamed:@"home_btn_tlak.png"];
        _comLabel.textColor = [UIColor blackColor];
        _commentLabel.textColor = [UIColor blackColor];
        
    }
    if ([_model.isShare isEqualToString:@"1"]) { //若分享过
        _shaeLabel.textColor = selectColor;
        _shareImage.image = [UIImage imageNamed:@"转发.png"];
        _shareLabel.textColor = selectColor;
    }else{
        _shaeLabel.textColor = [UIColor blackColor];
        _shareImage.image = [UIImage imageNamed:@"home_btn_zhuanfa.png"];
        _shareLabel.textColor = [UIColor blackColor];
    }
    
    
#pragma  mark ============ 判断是否模型中添加了图片类型 ========================
    if (_model.photoList.count < 1) {
        [self.photoView removeFromSuperview];
    }else{
        self.imagesArray = [_model.photoList mutableCopy];
        self.photoView = [[UIView alloc] initWithFrame:CGRectMake(62, _photoTop, KScrennWith - 67, (KScrennWith - 67) / 5 * 3)];
        [self addSubview:self.photoView];
    [self setContentView:(int)_model.photoList.count array:_model.photoList];
    }
    
    
#pragma mark ====== 判断是否添加了视频流 ===========
    if ([_model.preview isEqualToString:@""] && _model.photoList.count < 1) {
            [self.photoView removeFromSuperview];
    }else if(![_model.preview isEqualToString:@""] && _model.photoList.count < 1){
        
        self.photoView = [[UIView alloc] initWithFrame:CGRectMake(62, _photoTop, KScrennWith - 67, (KScrennWith - 67) / 5 * 3)];
        [self addSubview:self.photoView];
        self.videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.photoView.width, self.photoView.height)];
        [self changeLayerOfSomeControl:self.videoImageView];
        UIImageView *playImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.videoImageView.center.x - 20, self.videoImageView.center.y - 20, 40, 40)];
        playImage.image = [UIImage imageNamed:@"videoplay"];
        [self.videoImageView addSubview:playImage];
        
        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:_model.preview]];
        self.videoImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *videoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipToPlayVideosPage:)];
        [self.videoImageView addGestureRecognizer:videoTap];
        [self.photoView addSubview:self.videoImageView];

    }else if([_model.preview isEqualToString:@""] && _model.photoList.count > 0){
        [self.videoImageView removeFromSuperview];
    }
    

    
    //判断是否推转, 根据条件来改变改变悬赏图标的位置
    if ([model.transpondType isEqualToString:@"0"]) {
        self.rightImageView.frame  = CGRectMake(KScrennWith - 85, 0, 80, 80);
    }

    
#pragma mark =========  判断发布类型 =========================================
    NSLog(@"%@",model.type);
    if ([_model.type isEqualToString:@"2"]) { //悬赏发布
        self.rewardView.hidden = NO;
        self.shareView.hidden = YES;
        self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f", [_model.price floatValue]];

        self.rightImageView.image = [UIImage imageNamed:@"share_reward.png"];
        [self addSubview:_rightImageView];

    }
    if ([_model.type isEqualToString:@"3"]) { //广告位发布

        self.rightImageView.image = [UIImage imageNamed:@"advert_reward.png"];
        [self addSubview:_rightImageView];

        self.rewardView.hidden = NO;
        self.shareView.hidden = YES;
        self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f", [_model.price floatValue]];
    }
    if ([_model.type isEqualToString:@"1"]){  //免费发布
        self.shareLabel.text = _model.shareCount;
        self.shareNumber = [_model.shareCount intValue];
        [self.rightImageView removeFromSuperview];
        self.rightImageView.image = nil;
        self.rewardView.hidden = YES;
        self.shareView.hidden = NO;
    }
    
    if (self.moneyLabel.text.length <= 6) {
        self.moneyLabel.font = [UIFont systemFontOfSize:14];
    }else{
        self.moneyLabel.font = [UIFont systemFontOfSize:10];
    }
 
}



-(void)setContentView:(int)num array:(NSArray *)array{
    if (num == 1) {
        [self grout1:array];
    }
    if (num == 2) {
        [self grout2:array];
    }
    if (num == 3) {
        [self grout3:array];
    }
    if (num >= 4) {
        [self grout4:array];
    }
}
#pragma mark  =============添加图片  ===========
-(void)grout1:(NSArray *)array{
//添加图片1
    [_imageView1 removeFromSuperview];
    [_imageView2 removeFromSuperview];
    [_imageView3 removeFromSuperview];
    [_imageView4 removeFromSuperview];
    _imageView1 = [[UIImageViewExtension alloc ] initWithFrame:self.photoView.bounds];
    [self changeLayerOfSomeControl:_imageView1];
    [self.photoView addSubview: _imageView1];
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.46.199/Door%@",[array[0] objectForKey:@"url"]]]];
    _imageView1.ids = [[array[0] objectForKey:@"id"] intValue];
    
    _imageView1.userInteractionEnabled = YES;
    _imageView1.contentMode = UIViewContentModeScaleAspectFill;
    _imageView1.row = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    [_imageView1 addGestureRecognizer:tap];
    
}

-(void)grout2:(NSArray *)array{
//添加图片1
    [_imageView1 removeFromSuperview];
    [_imageView2 removeFromSuperview];
    [_imageView3 removeFromSuperview];
    [_imageView4 removeFromSuperview];
        _imageView1 = [[UIImageViewExtension alloc ] initWithFrame:CGRectMake(0, 0, (self.photoView.width - 3) / 2, self.photoView.height)];
    [self changeLayerOfSomeControl:_imageView1];
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.46.199/Door%@",[array[0] objectForKey:@"url"]]]];
    _imageView1.ids = [[array[0] objectForKey:@"id"] intValue];
    [self.photoView addSubview:_imageView1];
  
//添加图片2
        _imageView2 = [[UIImageViewExtension alloc ] initWithFrame:CGRectMake(_imageView1.right + 3, _imageView1.top, _imageView1.width, self.photoView.height)];
    [self changeLayerOfSomeControl:_imageView2];
    [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.46.199/Door%@",[array[1] objectForKey:@"url"]]]];
    _imageView2.ids = [[array[1] objectForKey:@"id"] intValue];
    [self.photoView addSubview:_imageView2];
    
    
    _imageView1.row = 0;
    _imageView2.row = 1;
    
        _imageView1.contentMode = UIViewContentModeScaleAspectFill;
        _imageView2.contentMode = UIViewContentModeScaleAspectFill;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    [_imageView1 addGestureRecognizer:tap];
    [_imageView2 addGestureRecognizer:tap1];
        _imageView1.userInteractionEnabled = YES;
        _imageView2.userInteractionEnabled = YES;
}

-(void)grout3:(NSArray *)array{
//添加图片1
        [_imageView1 removeFromSuperview];
        [_imageView2 removeFromSuperview];
        [_imageView3 removeFromSuperview];
        [_imageView4 removeFromSuperview];
 
    _imageView1 = [[UIImageViewExtension alloc ] initWithFrame:CGRectMake(0, 0, (self.photoView.width - 3) / 2, self.photoView.height)];
    [self changeLayerOfSomeControl:_imageView1];
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.46.199/Door%@",[array[0] objectForKey:@"url"]]]];
    _imageView1.ids = [[array[0] objectForKey:@"id"] intValue];
    [self.photoView addSubview:_imageView1];
//添加图片2
        _imageView2 = [[UIImageViewExtension alloc ] initWithFrame:CGRectMake(_imageView1.right + 3, _imageView1.top, _imageView1.width, (self.photoView.height - 3) / 2)];

    [self changeLayerOfSomeControl:_imageView2];

    [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BaseUrl@"%@",[array[1] objectForKey:@"url"]]]];
    _imageView2.ids = [[array[1] objectForKey:@"id"] intValue];
    [self.photoView addSubview:_imageView2];
//添加图片3

        _imageView3 = [[UIImageViewExtension alloc ] initWithFrame:CGRectMake(_imageView2.left, _imageView2.bottom + 3, _imageView2.width, _imageView2.height)];
    [self changeLayerOfSomeControl:_imageView3];
    [_imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BaseUrl@"%@",[array[2] objectForKey:@"url"]]]];
    _imageView3.ids = [[array[2] objectForKey:@"id"] intValue];
    [self.photoView addSubview:_imageView3];
    
    
    _imageView1.row = 0;
    _imageView2.row = 1;
    _imageView3.row = 2;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    [_imageView1 addGestureRecognizer:tap];
    [_imageView2 addGestureRecognizer:tap1];
    [_imageView3 addGestureRecognizer:tap2];

    
    _imageView1.contentMode = UIViewContentModeScaleAspectFill;
    _imageView2.contentMode = UIViewContentModeScaleAspectFill;
    _imageView3.contentMode = UIViewContentModeScaleAspectFill;

    
    _imageView1.userInteractionEnabled = YES;
    _imageView2.userInteractionEnabled = YES;
    _imageView3.userInteractionEnabled = YES;
}

-(void)grout4:(NSArray *)array{
        [_imageView1 removeFromSuperview];
        [_imageView2 removeFromSuperview];
        [_imageView3 removeFromSuperview];
        [_imageView4 removeFromSuperview];
//添加图片1
    _imageView1 = [[UIImageViewExtension alloc ] initWithFrame:CGRectMake(0, 0, (self.photoView.width - 3) / 2, (self.photoView.height - 3) / 2)];
    [self changeLayerOfSomeControl:_imageView1];
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BaseUrl@"%@",[array[0] objectForKey:@"url"]]]];
    _imageView1.ids = [[array[0] objectForKey:@"id"] intValue];
    [self.photoView addSubview:_imageView1];
    
//添加图片2
  
        _imageView2 = [[UIImageViewExtension alloc ] initWithFrame:CGRectMake(_imageView1.right + 3, _imageView1.top, _imageView1.width, _imageView1.height)];
    [self changeLayerOfSomeControl:_imageView2];
    [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BaseUrl@"%@",[array[1] objectForKey:@"url"]]]];
    _imageView2.ids = [[array[1] objectForKey:@"id"] intValue];
    [self.photoView addSubview:_imageView2];
    
//添加图片3
        _imageView3 = [[UIImageViewExtension alloc ] initWithFrame:CGRectMake(_imageView1.left, _imageView1.bottom + 3, _imageView1.width, _imageView1.height)];
    [self changeLayerOfSomeControl:_imageView3];

    [_imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.46.199/Door%@",[array[2] objectForKey:@"url"]]]];
    _imageView3.ids = [[array[2] objectForKey:@"id"] intValue];
    [self.photoView addSubview:_imageView3];

    
//添加图片4
    _imageView4 = [[UIImageViewExtension alloc ] initWithFrame:CGRectMake(_imageView1.right + 3, _imageView1.bottom + 3, _imageView1.width, _imageView1.height)];
    [self changeLayerOfSomeControl:_imageView4];
    [_imageView4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.24.46.199/Door%@",[array[3] objectForKey:@"url"]]]];
    _imageView4.ids = [[array[3] objectForKey:@"id"] intValue];
    [self.photoView addSubview:_imageView4];
    
    
    _imageView1.row = 0;
    _imageView2.row = 1;
    _imageView3.row = 2;
    _imageView4.row = 3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPhotoToVisit:)];
    [_imageView1 addGestureRecognizer:tap];
    [_imageView2 addGestureRecognizer:tap1];
    [_imageView3 addGestureRecognizer:tap2];
    [_imageView4 addGestureRecognizer:tap3];
    
    
    
    _imageView1.contentMode = UIViewContentModeScaleAspectFill;
    _imageView2.contentMode = UIViewContentModeScaleAspectFill;
    _imageView3.contentMode = UIViewContentModeScaleAspectFill;
    _imageView4.contentMode = UIViewContentModeScaleAspectFill;

    _imageView1.userInteractionEnabled = YES;
    _imageView2.userInteractionEnabled = YES;
    _imageView3.userInteractionEnabled = YES;
    _imageView4.userInteractionEnabled = YES;
    
   
#pragma mark ===  如果图片超出4张, 显示白色标签 ==================
    if (_model.photoList.count > 4) {
        [_nameLabebl removeFromSuperview];
        [_myMaskView removeFromSuperview];
        
        _myMaskView = [[UIView alloc] initWithFrame:_imageView4.bounds];
        _myMaskView.backgroundColor = [UIColor blackColor];
        _myMaskView.alpha = 0.3;
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.frame = CGRectMake(_imageView4.center.x - 50, _imageView4.center.y - 20, 100, 40);
        _numberLabel.text = [NSString stringWithFormat:@"+%lu", _model.photoList.count - 4];
        _numberLabel.font = [UIFont systemFontOfSize:40];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor whiteColor];
        [_imageView4 addSubview:_numberLabel];
        [_imageView4 addSubview:_myMaskView];
        [_imageView4 bringSubviewToFront:_numberLabel];
    }
  
    
    
}



//调整一些控件的圆角度
- (void)changeLayerOfSomeControl:(UIView *)control{
    control.layer.cornerRadius = 5;
    control.layer.masksToBounds = YES;
}


- (void)layoutSubviews{

    [self.titleLabel sizeToFit];
    [self.photoView sizeToFit];
}







#pragma mark ===== 获得字符串的高度 =========
- (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
   CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    CGFloat height = sizeToFit.height;
    return height;
}
#pragma mark ===== 获取字符串的宽度 ====
- (CGFloat)widthForString:(NSString *)value fontSize:(CGFloat)fontSize andHeight:(CGFloat)height
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    CGFloat width = sizeToFit.width;
    return width;
}

- (void)showMessage:(NSString *)string {
    LPPopup *popup = [LPPopup popupWithText:string];
    popup.textColor = [UIColor blackColor];
    [popup showInView:self.superview.window
        centerAtPoint:self.superview.window.center
             duration:1
           completion:nil];
    [self bringSubviewToFront:popup];
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

#pragma mark ========== actionSheetDelegate ================
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"分享给好友");

            FriendsComtroller *friendVC = [[FriendsComtroller alloc] init];
            friendVC.tableId = nil;
            friendVC.model = _model;
            [friendVC setHidesBottomBarWhenPushed:YES];
            
            self.friendVC = friendVC;
            
            [self.navigationController pushViewController:friendVC animated:YES];
            
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
            [params setObject:_model.beforDocumentId forKey:@"document.id"];
            [[HTTPRequestManager sharedManager] POST:[NSString stringWithFormat:BaseUrl@"usertranspondDocument"] params:params result:^(id responseObj, NSError *error) {
                if ([responseObj[@"result"] intValue] == 0) {
                    [self showMessage:@"分享数量+1"];
                    self.shareNumber += 1;
                    self.shareLabel.text = [NSString stringWithFormat:@"%d", self.shareNumber];
                    _shaeLabel.textColor = selectColor;
                    _shareImage.image = [UIImage imageNamed:@"转发.png"];
                    _shareLabel.textColor = selectColor;
                    
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



@end
