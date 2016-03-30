//
//  SetUserNameVC.h
//  ChuanSongMen
//
//  Created by femtoapp's macbook pro  on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@protocol returnUserInfoDelegate <NSObject>

@required
- (void)returnTheUsernameAndPassword:(NSArray *)array;
@end

@interface SetUserNameVC : BaseViewController

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSMutableDictionary *pararm;

@property (nonatomic, assign) id<returnUserInfoDelegate> RegisterDelegate;

@end
