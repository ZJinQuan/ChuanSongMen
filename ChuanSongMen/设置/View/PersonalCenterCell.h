//
//  PersonalCenterCell.h
//  ChuanSongMen
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterCell : UITableViewCell

@property(strong,nonatomic)UITextView *textView;


-(void)setContentView:(NSDictionary *)dictionary;

@end
