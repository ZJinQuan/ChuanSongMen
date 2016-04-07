//
//  FriendsCell.m
//  ChuanSongMen
//
//  Created by QUAN on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FriendsCell.h"
#import "UIImageView+WebCache.h"

@interface FriendsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *nichengLab;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *goodFriend;

@end

@implementation FriendsCell

- (void)awakeFromNib {

}

-(void)setModel:(UsergetMyAction *)model{
    
    _model = model;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:BasePicAppending@"%@",model.imgUrl]]];
    self.nameLab.text = model.name;
    self.nichengLab.text = model.niCheng;
    self.userNameLab.text = model.userName;
    self.goodFriend.text = model.isGoodFriend;
    
}




@end
