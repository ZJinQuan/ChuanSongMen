//
//  UIImage+Extension.h
//  BuyAi
//
//  Created by femto01 on 15/10/29.
//  Copyright © 2015年 femto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  生成水印
 *
 *  @param bgName  背景图片
 *  @param logNmae 水印图片
 *
 *  @return 生成好的图片(带水印的图片)
 */
+ (instancetype)imageWithBackgroundImageName:(NSString *)bgName log:(NSString *)logNmae;

/**
 *  生成头像
 *
 *  @param icon   头像图片名称
 *  @param border 头像边框大小
 *  @param color  头像边框的颜色
 *
 *  @return 生成好的头像
 */
+ (instancetype)imageWithIcon:(UIImage *)icon border:(NSInteger)border color:(UIColor *)color;


/**
 *  根据url请求图片
 *
 *  @param url  请求图片的url地址
 *
 *  @return
 */
+ (instancetype)imageWithURL:(NSString *)url;

+ (UIImage *)resizeImage:(NSString *)imageName;

+ (UIImage *)resizeImage2:(NSString *)imageName;

/**
 *  根据颜色生成纯色的图片
 *
 *  @param color 颜色
 *
 *  @return iamge
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  把图片变成灰色的
 *
 *  @param sourceImage 原来的图片
 *
 *  @return 改变后的灰色图片
 */
+ (UIImage *)grayImage:(UIImage *)sourceImage;


@end
