//
//  UserInformationModel.h
//  ChuanSongMen
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface UserInformationModel : BaseModel

@property (nonatomic, strong) NSString *address; //住址
@property (nonatomic, strong) NSString *email; //邮箱
@property (nonatomic, strong) NSString *imgCreateDate; //图片创建时间
@property (nonatomic, strong) NSString *imgUrl;  //头像url
@property (nonatomic, strong) NSString *info;  //个人说明, 关于我
@property (nonatomic, strong) NSString *niCheng;  //昵称
@property (nonatomic, strong) NSString *phone; //手机号
@property (nonatomic, strong) NSString *school;  //毕业院校
@property (nonatomic, strong) NSString *url;     //
@property (nonatomic, strong) NSString *userName;  // 用户名

/*
 address = "\U6df1\U5733\U5317\U7ad9";
 email = "597694121@qq.com";
 imgCreateDate = "";
 imgUrl = "";
 info = "\U5cf0\U4f1a\U5373\U5c06\U56de\U5f52 vv";
 message = "\U67e5\U770b\U7528\U6237\U6210\U529f!";
 niCheng = "\U672c\U5c4a\U6606\U4ea4\U4f1a";
 phone = 15638175921;
 result = 0;
 school = "\U56fd\U5bb6\U79d1\U6280\U5956";
 url = "";
 userName = "@@Rooses";
 */










@end
