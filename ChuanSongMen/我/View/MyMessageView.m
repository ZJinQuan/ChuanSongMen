//
//  MyMessageView.m
//  chuansongmen
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyMessageView.h"
#import "UIButton+UIButtonImageWithLable.h"
#import "UIUtils.h"
#import "AppDelegate.h"
@interface MyMessageView ()



@end

@implementation MyMessageView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    
    if (self) {
        [self addContentView];
    }
    return self;
}






-(void)addContentView{

    //用户头像
  _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 50, 50)];
    _headerImageView.backgroundColor = [UIColor yellowColor];
    _headerImageView.layer.cornerRadius = 5;
    _headerImageView.layer.masksToBounds = YES;
    [self addSubview:_headerImageView];
    
    
    //用户名称
    _nickName =[[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_headerImageView.frame)+5, 150, 20)];
    _nickName.font = [UIFont systemFontOfSize:15];
    [self addSubview:_nickName];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_nickName.frame), 120, 15)];
    _userNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_userNameLabel];
    
    
    _myAttentionLabl = [[UILabel alloc] initWithFrame:CGRectMake(KScrennWith - 115, CGRectGetMidY(_nickName.frame), 100, 20)];
    _myAttentionLabl.text = @"关注:0";
    _myAttentionLabl.textAlignment = NSTextAlignmentRight;
    _myAttentionLabl.font = [UIFont systemFontOfSize:14];
    [self addSubview:_myAttentionLabl];
    
    _attentionMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScrennWith - 240, CGRectGetMidY(_nickName.frame), 125, 20)];
    _attentionMeLabel.textAlignment = NSTextAlignmentRight;
    _attentionMeLabel.text = @"关注者:0";
    _attentionMeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_attentionMeLabel];
    
    
    //修改资料
    _editMessage=[UIButton buttonWithType:UIButtonTypeCustom];
    _editMessage.frame=CGRectMake(KScrennWith-220, 10, 60, 40);
    
    [_editMessage setImage:[UIImage imageNamed:@"info_btn_xxx.png"] withTitle:@"编辑资料" forState:UIControlStateNormal];
    [_editMessage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_editMessage addTarget:self action:@selector(editPurseMessage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editMessage];
    
    //添加竖线
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_editMessage.frame)+5, 20, 1, _editMessage.frame.size.height-15)];
    view1.backgroundColor=[UIColor grayColor];
    [self addSubview:view1];
    
    
    //我的钱包
    _myPurse=[UIButton buttonWithType:UIButtonTypeCustom];
    _myPurse.frame=CGRectMake(CGRectGetMaxX(view1.frame)+5, 10, 60, 40);
    [_myPurse setImage:[UIImage imageNamed:@"info_btn_s.png"] withTitle:@"我的钱包" forState:UIControlStateNormal];
    [_myPurse setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myPurse addTarget:self action:@selector(purseMessage) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_myPurse];

    
    //添加竖线
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_myPurse.frame)+5, 20, 1, _editMessage.frame.size.height-15)];
    view2.backgroundColor=[UIColor grayColor];
    [self addSubview:view2];

    
    //设置
    _setButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _setButton.frame=CGRectMake(CGRectGetMaxX(view2.frame)+5, 10, 60, 40);
    [_setButton setImage:[UIImage imageNamed:@"info_btn_setup.png"] withTitle:@"设置" forState:UIControlStateNormal];
    [_setButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_setButton addTarget:self action:@selector(setButtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_setButton];

    
    //增加选择按钮
    [self addMenuView];
    
}


//菜单栏视图
-(void)addMenuView{
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"推文",@"媒体",@"发布汇",nil];
    _segmentedControl=[[UISegmentedControl alloc] initWithItems:segmentedData];
    _segmentedControl.frame=CGRectMake(20, 100, [UIUtils getWindowWidth]-40, 30);
    _segmentedControl.tintColor=[UIColor colorWithRed:0.0/255 green:115.0/255 blue:179.0/255 alpha:1.0f];;
    
    _segmentedControl.selectedSegmentIndex=2;
    /*
     下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
     */
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName,[UIColor blackColor], NSForegroundColorAttributeName, nil ];
    
    
    [_segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:0.0/255 green:115.0/255 blue:179.0/255 alpha:1.0f] forKey:NSForegroundColorAttributeName];
    
    [_segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [_segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_segmentedControl];
    
    
    
}

#pragma mark 菜单栏按钮点击方法
-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    
    NSString *IndexStr = [NSString stringWithFormat:@"%d",(int)Seg.selectedSegmentIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"选中分组控制" object:IndexStr];
}




#pragma mark 按钮点击方法
//设置按钮点击方法
-(void)setButtnPress{
    
       if (self.delegate &&[self.delegate respondsToSelector:@selector(MyMessageViewSetButtonPress)]) {
        [self.delegate MyMessageViewSetButtonPress];
    }
    
}

//我的钱包按钮点击方法
-(void)purseMessage{
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(MyMessageViewPurseButtonPress)]) {
        [self.delegate MyMessageViewPurseButtonPress];
    }
}


//编辑资料按钮点击方法

-(void)editPurseMessage{

    if (self.delegate &&[self.delegate respondsToSelector:@selector(MyMessageViewEditePurseButtonPress)]) {
        [self.delegate MyMessageViewEditePurseButtonPress];
    }



}



@end
