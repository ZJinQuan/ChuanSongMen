//
//  NSDictionary+getObjectWithType.h
//  空瀞
//
//  Created by femtoapp's macbook pro  on 15/8/28.
//  Copyright (c) 2015年 WL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (getObjectWithType) //安全的读取JSON解析结果字典
-(NSString *)getString:(NSString *)key;
-(NSInteger)getInteger:(NSString *)key;
-(CGFloat)getDouble:(NSString *)key;
-(BOOL)getBool:(NSString *)key;
-(NSArray *)getArray:(NSString *)key;
-(NSDictionary *)getDictionary:(NSString *)key;
@end

@interface NSMutableDictionary(setObjectWithType)
-(void)setString:(NSString *)str forKey:(id<NSCopying>)key;
-(void)setInteger:(NSInteger)num forKey:(id<NSCopying>)key;
-(void)setDouble:(CGFloat)num forKey:(id<NSCopying>)key;
@end

@interface NSDictionary (headDictionary)

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end