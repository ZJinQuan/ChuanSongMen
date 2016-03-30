//
//  PurseSubView.m
//  chuansongmen
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PurseSubView.h"

#import "UIUtils.h"

@interface PurseSubView ()
{
    UILabel *_titleLabel;

    UIImageView *_logoImageView;
    UILabel *_numLabel;
    UILabel *_numLabeltext;
    
    UILabel *_zfLabel;
    UILabel *_zfText;
    
    UILabel *_xsLabel;
    UILabel *_xsText;
    

}
@end

@implementation PurseSubView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }
    
    return self;
    
}

-(void)addContentView{
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 20)];
    _titleLabel.text=@"账户余额";
    _titleLabel.textColor=[UIColor grayColor];
    _titleLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
    
    _logoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(([UIUtils getWindowWidth]-45)/2, CGRectGetMaxY(_titleLabel.frame)+15, 45, 45)];
    _logoImageView.image=[UIImage imageNamed:@"info_btn_s"];
    [self addSubview:_logoImageView];
    
    
    _numLabel=[[UILabel alloc] initWithFrame:CGRectMake(([UIUtils getWindowWidth]-140)/2, CGRectGetMaxY(_logoImageView.frame)+10, 140, 50)];
    _numLabel.text=@"20.00";
    _numLabel.textAlignment=NSTextAlignmentCenter;
    _numLabel.textColor=[UIColor colorWithRed:0.0/255 green:115.0/255 blue:179.0/255 alpha:1.0f];
    _numLabel.font=[UIFont systemFontOfSize:50];
    [self addSubview:_numLabel];
    
    
    _numLabeltext=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numLabel.frame), CGRectGetMaxY(_numLabel.frame)-30, 30, 30)];
    _numLabeltext.text=@"元";
    _numLabeltext.textColor=[UIColor grayColor];
    _numLabeltext.font=[UIFont systemFontOfSize:16];
    [self addSubview:_numLabeltext];
    
    
    _zfLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_numLabel.frame)+25, [UIUtils getWindowWidth]/2-1, 25)];
    _zfLabel.text=@"80.00";
    _zfLabel.textColor=[UIColor grayColor];
    _zfLabel.textAlignment=NSTextAlignmentCenter;
    _zfLabel.font=[UIFont systemFontOfSize:16];
    [self addSubview:_zfLabel];
    
    _zfText=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_zfLabel.frame), [UIUtils getWindowWidth]/2-1, 25)];
    _zfText.text=@"阅读转发收益";
    _zfText.textColor=[UIColor grayColor];
    _zfText.textAlignment=NSTextAlignmentCenter;
    _zfText.font=[UIFont systemFontOfSize:16];
    [self addSubview:_zfText];
    
    
    _xsLabel=[[UILabel alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]/2, CGRectGetMaxY(_numLabel.frame)+25, [UIUtils getWindowWidth]/2-1, 25)];
    _xsLabel.text=@"0.00";
    _xsLabel.textColor=[UIColor grayColor];
    _xsLabel.textAlignment=NSTextAlignmentCenter;
    _xsLabel.font=[UIFont systemFontOfSize:16];
    [self addSubview:_xsLabel];
    
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]/2-1, CGRectGetMaxY(_numLabel.frame)+25, 1, 30)];
    view.backgroundColor=[UIColor grayColor];
    [self addSubview:view];
    
    
    
    _xsText=[[UILabel alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]/2, CGRectGetMaxY(_zfLabel.frame), [UIUtils getWindowWidth]/2-1, 25)];
    _xsText.text=@"悬赏转发支出";
    _xsText.textColor=[UIColor grayColor];
    _xsText.textAlignment=NSTextAlignmentCenter;
    _xsText.font=[UIFont systemFontOfSize:16];
    [self addSubview:_xsText];

    
    
}

@end
