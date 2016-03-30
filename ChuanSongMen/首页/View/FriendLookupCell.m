//
//  FriendLookupCell.m
//  ChuanSongMen
//
//  Created by FemtoappMacpro15 on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FriendLookupCell.h"
#import "UIImageView+WebCache.h"
@implementation FriendLookupCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(FriendModel *)model{
    _model = model;
    
    [_userHeaderImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BasePicAppending@"%@", _model.url]]];
    
    _nickNameLabel.text = _model.niCheng;
    _userNameLabel.text = _model.userName;
    if ([_model.atten isEqualToString:@"1"]) { // 1 为已关注
        [_attentionButton setImage:[UIImage imageNamed:@"tab_communication_pre"] forState:UIControlStateNormal];
    }else{
        [_attentionButton setImage:[UIImage imageNamed:@"tab_communication"] forState:UIControlStateNormal];
    }
    
    
}



@end
