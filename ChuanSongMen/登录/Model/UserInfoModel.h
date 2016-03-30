//
//  UserInfoModel.h
//  ChuanSongMen
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel
@property (nonatomic, strong) NSString *email; //用户邮箱
@property (nonatomic, strong) NSString *name; //账号名
@property (nonatomic, strong) NSString *phone; //手机号

@property (nonatomic, strong) NSString *type; //用户类型
@property (nonatomic, strong) NSString *url; //用户头像
@property (nonatomic, strong) NSString *userName; //用户名
@property (nonatomic, assign) int userId;




@end
