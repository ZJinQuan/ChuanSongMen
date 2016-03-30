//
//  MediumCell.h
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediumModel.h"
@interface MediumCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imagView;
@property (nonatomic, strong) MediumModel *model;


@end
