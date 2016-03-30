//
//  GrouChatMainView.m
//  chuansongmen
//
//  Created by apple on 15/9/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GrouChatMainView.h"
#import "UIUtils.h"


@interface GrouChatMainView ()
{

    UIView *_topView;
    
    UIImageView *_rightImageView;
    
    UILabel *_titleLabel;
    UILabel *_titleSubLabel;
    
    UILabel *_userNameLabel;



}
@end


@implementation GrouChatMainView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        [self addContentView];
        
        self.backgroundColor=[UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1.0f];
    }
    
    return self;
}

-(void)addContentView{
  
   _topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth]/2-10, 140)];
   _topView.backgroundColor=[UIColor whiteColor];
   [_topView.layer setCornerRadius:5];
   [self addSubview:_topView];
    
   _rightImageView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_topView.frame)-22, 10, 20, 25)];
   _rightImageView.backgroundColor=[UIColor redColor];
   _rightImageView.image=[UIImage imageNamed:@"0007.png"];
   [_topView addSubview:_rightImageView];
    
    //添加群标题
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame)+15, [UIUtils getWindowWidth]/2-10, 20)];
    _titleLabel.text=@"格维恩,miked";
    
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.font=[UIFont systemFontOfSize:14];
    
    [self addSubview:_titleLabel];
    
    
}

@end
