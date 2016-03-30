//
//  addImageCell.m
//  ChuanSongMen
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddImageCell.h"

@implementation AddImageCell

- (void)awakeFromNib {
    _imageView.layer.masksToBounds = YES;
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
