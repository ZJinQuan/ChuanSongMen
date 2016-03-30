//
//  HTTPRequestManager.h
//  iZhangChu
//
//  Created by iJeff on 15/8/25.
//  Copyright (c) 2015年 iJeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
//请求数据后返回的Block类型
typedef void(^ResultBlock)(id responseObj, NSError *error);


@interface HTTPRequestManager : NSObject
@property (nonatomic, strong) MBProgressHUD  *hud;
//单例
+ (HTTPRequestManager *)sharedManager;

//GET请求
//参数可以方在url中,也可以放在params(字典)中
- (void)GET:(NSString *)url params:(id)params result:(ResultBlock)resultBlock;

//POST请求
- (void)POST:(NSString *)url params:(id)params result:(ResultBlock)resultBlock;
/**
 上传图片
 */
- (void)POSTImage:(NSString *)url params:(id)params image:(UIImage *)image result:(ResultBlock)resultBlock;
/**
 *  上传图片
 *
 *  @param data      <#data description#>
 *  @param parem     <#parem description#>
 *  @param imageName <#imageName description#>
 *  @param block     <#block description#>
 *  @param errorBack <#errorBack description#>
 */
- (void)me_UpdateHeadImageWithFileData:(NSData *)data parame:(id)parem imageName:(NSString *)imageName callBack:(ResultBlock)block errorBack:(ResultBlock)errorBack ;


@end








