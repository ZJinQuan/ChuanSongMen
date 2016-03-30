//
//  SendTableViewCell.m
//  chuansongmen
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SendTableViewCell.h"
#import "UIUtils.h"

@interface SendTableViewCell ()
{

    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_textLabel;


}
@end

@implementation SendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addContentView];
        
    }

    return self;
}

-(void)addContentView{
    
    _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
    [self addSubview:_imageView];
    
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+5, 5, [UIUtils getWindowWidth]-CGRectGetMaxX(_imageView.frame)-5-5, 30)];
    [self addSubview:_titleLabel];
    
    
    
    _textLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+5, CGRectGetMaxY(_titleLabel.frame), [UIUtils getWindowWidth]-CGRectGetMaxX(_imageView.frame)-5-5, 39)];
    [self addSubview:_textLabel];
    
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textLabel.frame), [UIUtils getWindowWidth], 1)];
    view.backgroundColor=[UIColor greenColor];
    [self addSubview:view];
    

}


-(void)setContentDictionary:(NSDictionary *)dictionary{

    _imageView.image=[UIImage imageNamed:dictionary[@"image"]];
    _titleLabel.text=dictionary[@"title"];
    _textLabel.text=dictionary[@"text"];

}


@end
