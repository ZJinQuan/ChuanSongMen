//
//  DataBaseHelper.h
//  FemtoBaseProjectFramwork
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 femto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface DataBaseHelper : NSObject
@property (nonatomic, strong) NSMutableArray *dataSource;

+(DataBaseHelper *)shareDataBaseHelper;

/*插入搜索条目*/
- (void)insertSearchID:(int)searchId Result:(NSString *)searchInfo;

/*删除搜索条目*/
- (void)deleteSearchID:(int)searchId Result:(NSString *)searchInfo;

/*更新搜索条目*/
- (void)updateSearchID:(int)searchId Result:(NSString *)searchInfo;

/*查询搜索结果信息*/
-(NSMutableArray *)querySearchInfo;


@end
