//
//  MyTools.h
//  ERenovate
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTools : NSObject

//用当前的时间戳减去已有的时间戳
+ (NSString *)getHayMenosTiempoTimestampSelloActual:(NSString *)timeSPed;
/*
 时间戳
 **/
+ (NSString *)timestampChangeDate:(NSString *)timestamp;
@end
