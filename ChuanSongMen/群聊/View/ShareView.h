//
//  shareView.h
//  ChuanSongMen
//
//  Created by QUAN on 16/4/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsergetMyAction.h"
#import "HomePageModel.h"

@interface ShareView : UIView

//昵称
@property (nonatomic, copy) NSString *niCheng;

@property (nonatomic, strong) UsergetMyAction *model;

@property (nonatomic, strong) HomePageModel *model2;

@end
