//
//  PersonalProfileCell.m
//  ChuanSongMen
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PersonalProfileCell.h"

@interface PersonalProfileCell ()
{

    UILabel *_label;
    UITextView *_textView;

}
@end

@implementation PersonalProfileCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        self.backgroundColor=navBarColor(233.0, 233.0, 233.0);
        [self addContentView];
        
    }
    return self;
    
}

-(void)addContentView{
    
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, KScrennWith-20, 150)];
    bgView.backgroundColor=[UIColor whiteColor];
    
    _label=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 50, 20)];
    _label.font=[UIFont systemFontOfSize:14];
    
    [bgView addSubview:_label];
    
    _textView=[[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_label.frame)+5, bgView.frame.size.width-20, 120)];
  
    [bgView addSubview:_textView];
    
    [self addSubview:bgView];
    
    
    [self setContentView];
    
}

-(void)setContentView{
    
    _label.text=@"简介:";
    
    _textView.text=@"SGS；两家公司珀金斯；的刚开始；刚开始";
    
}

@end
