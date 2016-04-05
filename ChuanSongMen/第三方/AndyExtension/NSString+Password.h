//
//  NSString+Password.h
//  03.数据加密
//
//  Created by 刘凡 on 13-12-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Password)

/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)MD5;

/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)SHA1;


#pragma mark 根据项目需求添加的
/**
 *  获取request_token（用于BuyAi项目）
 *
 *  @return request_token加密结果
 */
+ (NSString *)get_request_token:(NSDate *)date;

/**
 *  获取request_time_stamp（用于BuyAi项目）
 *
 *  @return request_time_stamp  毫秒
 */
+ (NSString *)get_request_time_stamp:(NSDate *)date;


/**
 *  获取当前时间的时间戳
 *
 *  @return 返回时间戳字符串
 */
+(NSString *)getCurrentTime;

/**
 *  时间戳转date
 *
 *  @param timestamp 时间戳的字符串
 *
 *  @return 格式化后的时间字符串
 */
+ (NSString *)timestampChangeDate:(NSString *)timestamp;

/**
 *  时间转换显示，
 *
 *  @param date       时间
 *  @param formate    时间格式
 *
 *  @return 转换后对应显示的时间
 */
+ (NSString *)formateDate:(NSDate *)date withFormate:(NSString *) formate;
@end
