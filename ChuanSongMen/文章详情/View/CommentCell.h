//
//  CommentCell.h
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nickNameWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoHeight;

+(CGFloat)heightForCellByModel:(CommentModel *)model;






@property (nonatomic, strong) CommentModel *model;


@end
