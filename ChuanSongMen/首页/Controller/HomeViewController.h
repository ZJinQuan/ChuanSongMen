//
//  HomeViewController.h
//  ChuanSongMen
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController :BaseViewController


/*添加底部评论视图控件*/
@property (nonatomic, strong) UIView     *homeBottomCommentView;
@property (nonatomic, strong) UITextView *homeCommentTextView;
@property (nonatomic, strong) UIButton   *homeSendButton;
@property (nonatomic, strong) UIView     *homeMyMaskView;


@end
