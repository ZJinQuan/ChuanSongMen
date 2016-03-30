//
//  FriendTableViewCell.m
//  chuansongmen
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "FriendTableViewCell.h"

#import "UIUtils.h"

@interface FriendTableViewCell ()
{

    UIImageView *_userImageView;
    UILabel *_userTitleLabel;
    UILabel *_userSubTitleLabel;
    UIImageView *_guanzhuImageView;
    UIImageView *_jiahaoyouImageView;
    


}
@end

@implementation FriendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addContentView];
        
    }
    
    return self;
}

-(void)addContentView{
    
    
    //用户头像
    _userImageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
    [self addSubview:_userImageView];
    
    
    _userTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImageView.frame)+15, CGRectGetMinY(_userImageView.frame), 150, 25)];
    [self addSubview:_userTitleLabel];
    
    
    _userSubTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImageView.frame)+15, CGRectGetMaxY(_userTitleLabel.frame)+3, 150, 15)];
    [self addSubview:_userSubTitleLabel];

    
    //用户头像
    _guanzhuImageView=[[UIImageView alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]-15-40-15, 10, 40, 25)];
    [self addSubview:_guanzhuImageView];
    
    
    //用户头像
    _jiahaoyouImageView=[[UIImageView alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]-15-40-15, CGRectGetMaxY(_guanzhuImageView.frame)+5, 40, 25)];
    [self addSubview:_jiahaoyouImageView];
    
    
}


-(void)setCOntentView:(NSDictionary *)dictionary{

    _userImageView.image=[UIImage imageNamed:dictionary[@"image"]];
    _userTitleLabel.text=dictionary[@"title"];
    _userSubTitleLabel.text=dictionary[@"text"];
    _guanzhuImageView.image=[UIImage imageNamed:dictionary[@"image1"]];
    _jiahaoyouImageView.image=[UIImage imageNamed:dictionary[@"image2"]];


}


@end
