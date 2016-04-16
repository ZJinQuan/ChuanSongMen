//
//  HTTPRequestManager.m
//  iZhangChu
//
//  Created by iJeff on 15/8/25.
//  Copyright (c) 2015年 iJeff. All rights reserved.
//

#import "HTTPRequestManager.h"
#import "AFNetworking.h"
#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"

@interface HTTPRequestManager ()
{
    //HTTP请求管理器
    AFHTTPRequestOperationManager *manager;
}
@end

@implementation HTTPRequestManager

//单例
+ (HTTPRequestManager *)sharedManager
{
    static HTTPRequestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTTPRequestManager alloc] init];
        
    });
    return instance;
}

//初始化
- (instancetype)init
{
    if (self = [super init]) {
        
        manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = 15;
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}


//隐藏加载
- (void)hideHUD
{
    [self.hud hide:YES];
}

//GET请求
-(void)GET:(NSString *)url params:(id)params result:(ResultBlock)resultBlock
{
    manager.requestSerializer.timeoutInterval = 30;

//    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; //很重要，去掉就容易遇到错误，暂时还未了解更加详细的原因
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"=======%@    %@", url, params);
        NSLog(@"===========%@=====", responseObject);
        [self hideHUD];
        
        //获取到data数组
        NSArray *dataArr = responseObject[@"list"];
        
        //回传数据
        if (resultBlock) {
            resultBlock(dataArr, nil);
             AppDelegate *app = [UIApplication sharedApplication].delegate;
//            [UIView animateKeyframesWithDuration:0.5 delay:5 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
//                              [MBProgressHUD hideAllHUDsForView:app.window animated:YES];
//                            } completion:^(BOOL finished) {
//                            }];
            
             [MBProgressHUD hideAllHUDsForView:app.window animated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //回传错误信息
        if (resultBlock) {
            resultBlock(nil, error);
            AppDelegate *app = [UIApplication sharedApplication].delegate;
//            [UIView animateKeyframesWithDuration:0.5 delay:5 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
//              [MBProgressHUD hideAllHUDsForView:app.window animated:YES];
//            } completion:^(BOOL finished) {
//                
//                
//            }];
            [MBProgressHUD hideAllHUDsForView:app.window animated:YES];
            
        }
        
    }];
    
}

//POST请求
- (void)POST:(NSString *)url params:(id)params result:(ResultBlock)resultBlock
{
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer ];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"=======%@    %@", url, params);
        NSLog(@"===========%@=====", responseObject);
        
        NSDictionary * dict = responseObject;
//        NSArray * dataArr = dict[@"resultData"];
        if(resultBlock)
        {
            resultBlock(dict, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //回传错误信息
        if (resultBlock) {
            resultBlock(nil, error);
        }
    }];
}

- (void)POSTImage:(NSString *)url params:(id)params image:(UIImage *)image result:(ResultBlock)resultBlock
{

//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
                // jpg图片转二进制
        NSData *iconData = UIImageJPEGRepresentation(image, 0.5);
        
        //如果你的图片本身就是2进制的NSData形式，那么可以判断第一个字节得出类型：
        uint8_t c;
        NSString * mimeType;
        [iconData getBytes:&c length:1];
        switch (c) {
                
            case 0xFF:
                
                mimeType = @"image/jpeg";
                break;
            case 0x89:
                
                mimeType = @"image/png";
                break;
            case 0x47:
                
                mimeType = @"image/gif";
                break;
            case 0x4D:
                
                mimeType = @"image/tiff";
                break;
            default:
                break;
        }
        // 拼装Body
        [formData appendPartWithFileData:iconData name:@"headimage" fileName:[NSString stringWithFormat:@"photo.jpg"] mimeType:mimeType];\
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//        NSLog(@"responseObject = %@", result);
        NSDictionary * dict = responseObject;
        NSLog(@"dict = %@", dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@", error);
    }];


}




#pragma mark-- 头像上传
- (void)me_UpdateHeadImageWithFileData:(NSData *)data parame:(id)parem imageName:(NSString *)imageName callBack:(ResultBlock)block errorBack:(ResultBlock)errorBack  {
    NSString *urlString=[NSString stringWithFormat:BaseUrl@"userupdateUserIn"];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:parem constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *newImageName = [NSString stringWithFormat:@"%@.png",imageName];
        [formData appendPartWithFileData:data name:@"doc" fileName:newImageName mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBack(nil, error);
        
    }];
}

@end



