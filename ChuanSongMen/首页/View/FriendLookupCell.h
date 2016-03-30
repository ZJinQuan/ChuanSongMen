//
//  FriendLookupCell.h
//  ChuanSongMen
//
//  Created by FemtoappMacpro15 on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonExtension.h"
#import "FriendModel.h"
@interface FriendLookupCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButtonExtension *attentionButton;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (nonatomic, strong) FriendModel *model;



@end
