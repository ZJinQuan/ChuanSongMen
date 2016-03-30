//
//  MediumCell.m
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MediumCell.h"
#import "UIImageView+WebCache.h"
@implementation MediumCell

- (void)awakeFromNib {
}


- (void)setModel:(MediumModel *)model{
    _model = model;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_model.url]];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
