//
//  PersonalCenterCell.m
//  ChuanSongMen
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PersonalCenterCell.h"

@interface PersonalCenterCell ()
{

    UILabel *_label;

}

@end

@implementation PersonalCenterCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        [self addContentView];
        
    }
    return self;
    
}

-(void)addContentView{

    _label=[[UILabel alloc] initWithFrame:CGRectMake(15, 5, 60, 30)];
    _label.font=[UIFont systemFontOfSize:14];
    _label.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_label];

    
    self.textView=[[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_label.frame)-5, 5, KScrennWith-CGRectGetMaxX(_label.frame)-20, 30)];
    self.textView.font=[UIFont systemFontOfSize:14];
    self.textView.scrollEnabled=NO;
    [self addSubview:self.textView];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 39, KScrennWith, 2)];
    view.backgroundColor=navBarColor(233.0, 233.0, 233.0);
    [self addSubview:view];

}



-(void)setContentView:(NSDictionary *)dictionary{
    
    _label.text=dictionary[@"label"];
    
    _textView.text=dictionary[@"content"];
    
}

@end
