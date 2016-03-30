//
//  HomePageCell.h
//  ChuanSongMen
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"
#import "UIImageViewExtension.h"
#import "AppDelegate.h"
@interface HomePageCell : UITableViewCell<UITextViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *topLabel;//推转 label
@property (weak, nonatomic) IBOutlet UILabel *nameLabebl; //名字
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;//子名
@property (weak, nonatomic) IBOutlet UILabel *timeLabel; //时间
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; //主题文本标签
@property (weak, nonatomic) IBOutlet UIView *bottomView; //底部view
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;//点赞数
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;//评论数
@property (weak, nonatomic) IBOutlet UILabel *shareLabel; //分享数量
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
//@property (nonatomic, strong) UIView *photoView; //存放照片视频的view
//@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (nonatomic, strong) UIView *photoView;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelTop;

@property (nonatomic, strong) AppDelegate *app;


@property (nonatomic, strong) HomePageModel *model;
/**图片组*/
@property (nonatomic, strong) UIImageViewExtension *imageView1;
@property (nonatomic, strong) UIImageViewExtension *imageView2;
@property (nonatomic, strong) UIImageViewExtension *imageView3;
@property (nonatomic, strong) UIImageViewExtension *imageView4;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIView *rewardView;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (nonatomic, strong) NSMutableArray *imagesArray;

@property (nonatomic, strong) UIImageView *rightImageView;



@property (weak, nonatomic) IBOutlet UIView *zanView;

@property (weak, nonatomic) IBOutlet UIView *commentView;

@property (weak, nonatomic) IBOutlet UIView *shareView;


@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UINavigationController *navigationController;


@property (nonatomic, strong) UIView *bottomCommentView;
@property (nonatomic, strong) UITextView *commentTextView;
@property (nonatomic, strong) UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UILabel *zanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zanImage;
@property (weak, nonatomic) IBOutlet UILabel *comLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (weak, nonatomic) IBOutlet UILabel *shaeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shareImage;


@property (nonatomic, assign) int zanNumber;
@property (nonatomic, assign) int shareNumber;

@property (nonatomic, strong) UIView  *myMaskView;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, assign) int photoTop;

+ (CGFloat)cellHeight:(HomePageModel *)model;


@end
