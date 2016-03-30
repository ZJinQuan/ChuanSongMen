//
//  PersonalTopTableViewCell.m
//  ChuanSongMen
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PersonalTopTableViewCell.h"

@interface PersonalTopTableViewCell ()
{


    UIImageView *_imageView;
    UILabel *_nameLabel;
    UIImageView *_rightImageView;

}
@end

@implementation PersonalTopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self addContentView];
        
    }
    return self;

}

-(void)addContentView{

    _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
    [self addSubview:_imageView];
    
    
    _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, 30, 150, 20)];
    [self addSubview:_nameLabel];
    
    
    _rightImageView=[[UIImageView alloc] initWithFrame:CGRectMake(KScrennWith-30-15, 15, 30, 30)];
    [self addSubview:_rightImageView];


    [self setContentView];
    
}

-(void)setContentView{

    _imageView.image=[UIImage imageNamed:@"0001.png"];

    _nameLabel.text=@"头像";
     _rightImageView.image=[UIImage imageNamed:@"person_right.png"];

}

@end
