//
//  MyMessageView.h
//  chuansongmen
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyMessageViewDelegate <NSObject>

-(void)MyMessageViewSetButtonPress;//设置代理方法
-(void)MyMessageViewPurseButtonPress;//我的钱包代理方法
-(void)MyMessageViewEditePurseButtonPress;//编辑资料代理方法

@end

@interface MyMessageView : UIView{
    UIView *_bgView;//背景视图
    
//    UIButton *_imageButton;//头像
//    UILabel *_nickName;//昵称
//    UILabel *_userNameLabel; //用户名
//    
    UIButton *_editMessage;//修改资料
    UIButton *_myPurse;//我的钱包
    UIButton *_setButton;//设置按钮
//    UILabel *_myAttentionLabl; //我关注的
//    UILabel *_attentionMeLabel;//关注我的
}
@property(assign,nonatomic)id delegate;
//增加导航菜单
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIImageView *headerImageView;// 头像
@property (nonatomic, strong) UILabel  *nickName;//昵称
@property (nonatomic, strong) UILabel  *userNameLabel;//用户名
@property (nonatomic, strong) UILabel  *myAttentionLabl;//我关注的
@property (nonatomic, strong) UILabel  *attentionMeLabel;//关注我的





@end
