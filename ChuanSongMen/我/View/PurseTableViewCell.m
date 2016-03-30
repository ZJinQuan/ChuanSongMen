//
//  PurseTableViewCell.m
//  chuansongmen
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PurseTableViewCell.h"
#import "UIUtils.h"

@interface PurseTableViewCell ()
{

    UIImageView *_imageView;
    UILabel *_titlelabel;

}
@end


@implementation PurseTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addContentView];
        
    }
    
    return self;
}

-(void)addContentView{
    
    _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self addSubview:_imageView];
    
    _titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, 10, [UIUtils getWindowWidth]-CGRectGetMaxX(_imageView.frame)-30, 30)];
    _titlelabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_titlelabel];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 43, [UIUtils getWindowWidth], 2)];
    view.backgroundColor=[UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1.0f];
    [self addSubview:view];
    
    
}

-(void)setContentView:(NSDictionary *)dictionary{

    _imageView.image=[UIImage imageNamed:dictionary[@"image"]];
    _titlelabel.text=dictionary[@"title"];


}


@end
