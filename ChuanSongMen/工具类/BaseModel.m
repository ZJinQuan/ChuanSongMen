//
//  BaseModel.m
//  空瀞
//
//  Created by femtoapp's macbook pro  on 15/9/2.
//  Copyright (c) 2015年 WL. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+(instancetype)initWithDictionary:(NSDictionary *)dict
{   //该方法会自动给模型赋值，其中NSString与NSNumber会互相转换，如果模型中有为nil的JSON解析类型的属性，会先自动赋一个默认值,NSString默认为@"",NSNumber默认为NSNotFound，NSArray与NSDictionary会默认一个空的数组或字典，然后再根据数据源进行赋值操作
    id obj = [[self alloc] init];
    [MAAA ModelAttributeAutomaticAssignment:dict kindOfClass:[self class] ToModel:obj WithNameDictionary:@{@"ids":@"id"} openRecursive:NO];
    return obj;
}
@end
