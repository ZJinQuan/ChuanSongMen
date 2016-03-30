
//
//  SearchFriendResultCell.m
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchFriendResultCell.h"

@implementation SearchFriendResultCell

- (void)awakeFromNib {
    _addButton.layer.cornerRadius = 5;
    _addButton.layer.masksToBounds = YES;
    _addButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _addButton.layer.borderWidth = 1;
    _headerImage.layer.cornerRadius = 5;
    _headerImage.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
