//
//  ArticleInfoModel.h
//  ChuanSongMen
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleInfoModel : BaseModel

@property (nonatomic, strong) NSString *documentUserName;
@property (nonatomic, strong) NSString *documentNiCheng;
@property (nonatomic, strong) NSString *transpondType;
@property (nonatomic, strong) NSString *homeUrl;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *documentInfo;
@property (nonatomic, strong) NSString *shareCount;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *ids;

@property (nonatomic, strong) NSString *niCheng;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *homeDate;
@property (nonatomic, strong) NSString *documentUserHead;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *userHead;
@property (nonatomic, strong) NSString *documentId;
@property (nonatomic, strong) NSString *discussCount;
@property (nonatomic, strong) NSString *count;

@property (nonatomic,strong) NSArray *photoList;

@property (nonatomic, strong) NSString *topCount; //点赞数
@property (nonatomic, strong) NSString *isTop; //是否点赞

@property (nonatomic, strong) NSString *preview;//视频预览图
@property (nonatomic, strong) NSString *video;




/*7,查看文章详情
	1方法:	door/userqueryDocumentsDetails
	2输入:	userid	    用户id
            documentid	文章id
	3输出: 
 documentUserName	原文章的发布者的用户名
 documentNiCheng	原文章的发布者的昵称
 transpondType	类型  ; 0原帖子，1转发
 homeUrl
 type	类型  1为免费发布的，2为分享悬赏发布   3为广告位发布
 documentInfo	原文章的内容
 shareCount	分享次数
 info	文章的内容
 id	文章的id
 niCheng	文章的发布者
 price	每条的价格
 homeDate
 documentUserHead	原文章的发布者的头像
 userId	该文章的发布者id
 userName	该文章的发布者用户名
 createDate	时间
 userHead	发布者的头像
 documentId	原文章的id
 discussCount	评论数
 count	总数
*/
@end
