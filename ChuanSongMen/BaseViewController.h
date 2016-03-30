//
//  BaseViewController.h
//  JinKouDai
//
//  Created by femto01 on 15/9/9.
//  Copyright (c) 2015年 femto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LPPopup.h"
#import "AFNetworking.h"
#import "HTTPRequestManager.h"
#import "UIImageView+WebCache.h"

#import "UserInfoModel.h"
#import "UIView+Extension.h"
#import "UITapGestureExtension.h"
#import <Foundation/Foundation.h>
@interface BaseViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) AppDelegate *app;
@property (strong, nonatomic) UILabel *titleLable;
@property (nonatomic, strong) MBProgressHUD  *hud;
@property (nonatomic,assign) int userId;

@property (nonatomic, strong) UserInfoModel *userInfoModel;

/*添加底部评论视图控件*/
@property (nonatomic, strong) UIView     *bottomCommentView;
@property (nonatomic, strong) UITextView *commentTextView;
@property (nonatomic, strong) UIButton   *sendButton;
@property (nonatomic, strong) UIView     *myMaskView;



/*  退出键盘*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;


/* 设置导航栏左边按钮*/
- (void)initBaseNavigationLeftBar;

/*设置导航栏右边按钮*/
- (void)initBaseNavigationRightBar;


/*返回上一页*/
//- (void)backToLastPage;

/*信息弹出框*/
- (void)showMessage:(NSString *)string;

//调整一些控件的圆角度
- (void)changeLayerOfSomeControl:(UIView *)control;

//调整一些控件的边宽和边色
- (void)changeBorderOfSomeControl:(UIView *)control borderColor:(UIColor *)borderColor borderWidth:(int)borderWidth;

/*邮箱验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateEmail:(NSString *)email;

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateMobile:(NSString *)mobile;


- (void)showHUD:(NSString *)title;
- (void)hideHUD;





- (NSString *)getNowDate;





- (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;


- (CGFloat)widthForString:(NSString *)value fontSize:(CGFloat)fontSize andHeight:(CGFloat)height;


//添加底部评论视图
-(void)adBottomCommentView;
-(void)sendCommentToServer:(UIButton *)sender;
@end
