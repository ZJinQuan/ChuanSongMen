//
//  NoticeSecondTableViewCell.m
//  chuansongmen
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NoticeSecondTableViewCell.h"


#import "UIUtils.h"

@interface NoticeSecondTableViewCell ()
{
    
    UIImageView *_userImageView;
    UILabel *_userTitleLabel;
    UILabel *_userSubTitleLabel;
    UIImageView *_guanzhuImageView;
    UIImageView *_jiahaoyouImageView;
    
    
    
}
@end

@implementation NoticeSecondTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addContentView];
        
    }
    
    return self;
}

-(void)addContentView{
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 1)];
    view.backgroundColor=[UIColor colorWithRed:241.0/255 green:241.0/255 blue:241.0/255 alpha:1.0f];
    [self addSubview:view];
    
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 79, [UIUtils getWindowWidth], 1)];
    view1.backgroundColor=[UIColor colorWithRed:241.0/255 green:241.0/255 blue:241.0/255 alpha:1.0f];
    [self addSubview:view1];
    
    
    UIView *view3=[[UIView alloc] initWithFrame:CGRectMake(0, 159, [UIUtils getWindowWidth], 1)];
    view3.backgroundColor=[UIColor colorWithRed:241.0/255 green:241.0/255 blue:241.0/255 alpha:1.0f];
    [self addSubview:view3];
    
    
    //用户头像
    _userImageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
    [self addSubview:_userImageView];
    
    
    _userTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImageView.frame)+15, CGRectGetMinY(_userImageView.frame), 150, 25)];
    _userTitleLabel.text=@"Christopher";
    [self addSubview:_userTitleLabel];
    
    
    _userSubTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImageView.frame)+15, CGRectGetMaxY(_userTitleLabel.frame)+3, 150, 15)];
    _userSubTitleLabel.text=@"@shangsii112";
    _userSubTitleLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:_userSubTitleLabel];
    
    
    //用户头像
    _guanzhuImageView=[[UIImageView alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]-140, 40, 60, 25)];
    _guanzhuImageView.image=[UIImage imageNamed:@"communication_btn_add.png"];
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test3)];
    [_guanzhuImageView addGestureRecognizer:tap1];

    _guanzhuImageView.userInteractionEnabled=YES;
    [self addSubview:_guanzhuImageView];
    
    
    //用户头像
    _jiahaoyouImageView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_guanzhuImageView.frame)+5, 40, 60, 25)];
    _jiahaoyouImageView.image=[UIImage imageNamed:@"communication_btn_follow.png"];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test)];
    [_jiahaoyouImageView addGestureRecognizer:tap];
    _jiahaoyouImageView.userInteractionEnabled=YES;
    [self addSubview:_jiahaoyouImageView];
    
    
}

-(void)test{

    NSLog(@"测试1");

}
-(void)test3{
    
    NSLog(@"测试3");
    
}


-(void)setCOntentView:(NSDictionary *)dictionary{
    
//    _userImageView.image=[UIImage imageNamed:dictionary[@"image"]];
//    _userTitleLabel.text=dictionary[@"title"];
//    _userSubTitleLabel.text=dictionary[@"text"];
//    _guanzhuImageView.image=[UIImage imageNamed:dictionary[@"image1"]];
//    _jiahaoyouImageView.image=[UIImage imageNamed:dictionary[@"image2"]];
    
    
}

@end
