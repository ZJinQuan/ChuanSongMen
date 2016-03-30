//
//  HomeTableViewCell.h
//  chuansongmen
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"
@protocol HomeTableViewCellDelegate <NSObject>

-(void)HomeTableViewCellZanButtonPress:(int)index;
-(void)HomeTableViewCellPingLunButtonPress:(int)index;
-(void)HomeTableViewCellShareButtonPress:(int)index;

//文本点击后跳转
-(void)HomeTableViewCellTextViewButtonPress:(int)index;

-(void)HomeTableViewCellPhotoImageViewButtonPress:(int)index;

@end


@interface HomeTableViewCell : UITableViewCell
@property(assign,nonatomic)id delegate;

@property (nonatomic, strong) HomePageModel *model;


-(void)setContentView:(NSDictionary *)dictionary andIndex:(int)num andImgType:(NSString *)imgType;

@end
