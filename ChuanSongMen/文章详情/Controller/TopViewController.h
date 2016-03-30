//
//  TopViewController.h
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "ArticleInfoModel.h"
@interface TopViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel; //推转标签

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView; //用户头像
@property (weak, nonatomic) IBOutlet UILabel *nickNAmeLabel; //  昵称标签
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel; // 用户名 标签
@property (weak, nonatomic) IBOutlet UILabel *infoLabel; //正文
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoHeight; // 正文高度约束
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView; //图片集合

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewHeight; //中间视图高度约束
@property (weak, nonatomic) IBOutlet UIView *shareView; //悬赏分享视图
@property (weak, nonatomic) IBOutlet UILabel *rewordMoneyLabel; // 赏金标签
@property (weak, nonatomic) IBOutlet UILabel *timeLabel; //发布时间标签
@property (weak, nonatomic) IBOutlet UILabel *praiseNumberLabel; // 点赞数标签
@property (weak, nonatomic) IBOutlet UILabel *commentNumberLabel;// 评论数标签
@property (weak, nonatomic) IBOutlet UILabel *shareNumberLabel; //分享数标签
@property (weak, nonatomic) IBOutlet UIView *praiseView; // 赞视图
@property (weak, nonatomic) IBOutlet UIView *collectView;  //收藏视图
@property (weak, nonatomic) IBOutlet UIView *moreView;   //更多视图
@property (weak, nonatomic) IBOutlet UIImageView *praiseImageView; //点赞图
@property (weak, nonatomic) IBOutlet UILabel *zanLabei; //点赞标签
@property (weak, nonatomic) IBOutlet UIImageView *collectImageView; //收藏图
@property (weak, nonatomic) IBOutlet UILabel *collectLabel; //收藏标签


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewTop; //中间视图的顶部约束

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;

@property (nonatomic, strong) NSString *documentid;

@property (nonatomic, strong) UINavigationController *naviga;

@property (nonatomic, assign) BOOL isPraise; //是否点赞
@property (nonatomic, assign) int zanNumber;//点赞数
@property (nonatomic, assign) BOOL isCollect; //是否收藏
@property (nonatomic, assign) int shareNumber;


+ (CGFloat)heightForTheHeaderView:(ArticleInfoModel *)model;





@end
