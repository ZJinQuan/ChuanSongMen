//
//  HomePageModel.h
//  ChuanSongMen
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface HomePageModel : BaseModel

@property (nonatomic, strong) NSString *documentUserName;//原文章的发布者的用户名
@property (nonatomic, strong) NSString *documentNiCheng;//原文章的发布者的昵称
@property (nonatomic, strong) NSString *transpondType;
@property (nonatomic, strong) NSString *homeUrl;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *documentInfo;
@property (nonatomic, strong) NSArray  *photoList;
@property (nonatomic, strong) NSString *shareCount;
@property (nonatomic, strong) NSString *topCount;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *niCheng;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *homeDate;
@property (nonatomic, strong) NSString *documentUserHead;
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *userHead;
@property (nonatomic, strong) NSString *discussCount;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger documentId;

@property (nonatomic, strong) NSString *beforDocumentId;
@property (nonatomic, strong) NSString *isCollection;  //是否收藏过  //1为否   0为是
@property (nonatomic, strong) NSString *isDiscuss;     //是否评论过
@property (nonatomic, strong) NSString *isShare;     //是否分享过
@property (nonatomic, strong) NSString *isTop;      //是否点赞过


@property (nonatomic, strong) NSString *preview; //视频图
@property (nonatomic, strong) NSString *video;   //视频流

/*"documentUserName": "chuangsong666",//原文章的发布者的用户名
 "documentNiCheng": "MR王",  //原文章的发布者的昵称
 "transpondType": "1",//类型  ; 0原帖子，1转发
 "homeUrl": "2222",
 "type": "1",//类型  1为免费发布的，2为分享悬赏发布   3为广告位发布
 "documentInfo": "这文章不错//@王先生:good",   //原文章的内容
 "photoList": [],//图片集合
 "shareCount": "0",//分享次数
 "topCount": "0",//点赞次数
 "info": "",
 "id": 17,//文章的id
 "niCheng": "MR王",//文章的发布者
 "price": "0.0",//每条的价格
 "homeDate": "2015-11-09 16:31:31",
 "documentUserHead": "/head/888.jpg",//原文章的发布者的头像
 "userId": 2,//该文章的发布者id
 "userName": "chuangsong666",//该文章的发布者用户名
 "isTop": "0",//是否已点赞
 "createDate": "1小时前",//时间
 "userHead": "/head/888.jpg",//发布者的头像
 "documentId": 15,//原文章的id
 "discussCount": "0"//评论数*/





@end
