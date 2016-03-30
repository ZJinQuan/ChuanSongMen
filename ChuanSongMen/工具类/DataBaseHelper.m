//
//  DataBaseHelper.m
//  FemtoBaseProjectFramwork
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 femto. All rights reserved.
//

#import "DataBaseHelper.h"

@interface DataBaseHelper ()
@property (nonatomic, strong)FMDatabase *db;

@end

@implementation DataBaseHelper

+ (DataBaseHelper *)shareDataBaseHelper{
    static DataBaseHelper *DBHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DBHelper = [[DataBaseHelper alloc] init];
        //调用创建数据库和表的方法
//        [DBHelper createDataBase];
//        [DBHelper createTable];
    });
    return DBHelper;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        //1, 创建数据库
        //1.1 创建数据库存储路径
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        path = [path stringByAppendingPathComponent:@"searchInfo.db"];
        NSLog(@"path:%@", path);
        
        //1.2 打开数据库(如果第一次打开,会先创建数据库,然后再打开)
        self.db = [FMDatabase databaseWithPath:path];
        BOOL ret = [self.db open];
        if (!ret) {
            NSLog(@"打开数据库失败!");
            return self;
        }
        NSLog(@"打开数据库成功!");
        
        //2, 创建表
        [self createTable];
        
    }
    return self;
}


//初始化数据原数组
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark========创建数据库================
- (void)createDataBase{
    //获取数据库文件的路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
     NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //拼接路径
    NSString *dataBaseFilePath = [path stringByAppendingString:@"devicesInfo.db"];
    //创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:dataBaseFilePath];
    self.db = db;
}
#pragma mark =========创建表============
-(void)createTable{
    if ([self.db open]) {
        //创建表
        BOOL result = [self.db executeUpdate:@"create table if not exists t_searchInfo (searchID text primary key autoincrement, searchResult text NOT NULL);"];
        if (result) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }
    }else{
        NSLog(@"数据库打开失败");
    }
    [self.db close];
}



#pragma mark=============== 插入数据 ===================
- (void)insertSearchID:(int)searchId Result:(NSString *)searchInfo{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"INSERT INTO t_searchInfo (searchID,searchResult) VALUES (?,?);",searchId,searchInfo];
        if (result) {
            NSLog(@"插入成功");
        }
        else
        {
            NSLog(@"插入失败");
        }
    }
    [self.db close];
}
#pragma mark=============== 删除数据 ===================
- (void)deleteSearchID:(int)searchId Result:(NSString *)searchInfo
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"delete from t_searchInfo  where searchID = ?", searchId];
        if (result) {
            NSLog(@"删除成功");
        }
        else
        {
            NSLog(@"删除失败");
        }
    }
    [self.db close];
    
}
#pragma mark=============== 修改数据 ===================
- (void)updateSearchID:(int)searchId Result:(NSString *)searchInfo
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"UPDATE t_searchInfo SET searchResult = ? WHERE searchID = ? ", searchInfo, searchInfo];
        if (result) {
            NSLog(@"修改成功");
        }
        else
        {
            NSLog(@"修改失败");
        }
    }
    [self.db close];
}
#pragma mark=============== 查询数据 ===================
- (NSMutableArray *)queryDevicesInfo
{
    NSMutableArray *arr = [NSMutableArray array];
    if ([self.db open]) {
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_searchInfo"];
        
        while ([resultSet next]) {
            NSString *searchResult = [resultSet stringForColumn:@"searchResult"];
            [arr addObject:searchResult];
            NSLog(@"%@", arr);
        }
    }
    NSLog(@"%@" ,arr);
    return arr;
}









@end
