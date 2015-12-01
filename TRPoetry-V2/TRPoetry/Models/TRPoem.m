//
//  TRPoem.m
//  TRPoetry
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "TRPoem.h"
#import "TRDBManager.h"
#import "FMDatabase.h"

@implementation TRPoem

+ (NSArray *)poetryListWithCategory:(NSString *)category {
    //获取数据库对象
    FMDatabase *database = [TRDBManager sharedDatabase];
    //有条件的查询resultSet
    FMResultSet *resultSet = [database executeQueryWithFormat:@"select * from T_SHI where D_KIND=%@", category];
    //循环解析(resultSet <--> TRPoem)
    NSMutableArray *mutableArray = [NSMutableArray array];
    while ([resultSet next]) {
        TRPoem *poem = [TRPoem new];
        poem.poemID = [resultSet intForColumn:@"D_ID"];
        poem.poemContent = [resultSet stringForColumn:@"D_SHI"];
        poem.poemIntroduction = [resultSet stringForColumn:@"D_INTROSHI"];
        poem.poemAuthor = [resultSet stringForColumn:@"D_AUTHOR"];
        poem.poemCategory = [resultSet stringForColumn:@"D_KIND"];
        poem.poemTitle = [resultSet stringForColumn:@"D_TITLE"];
        [mutableArray addObject:poem];
    }
    
    //收尾工作
    [database closeOpenResultSets];
    [database close];
    
    return [mutableArray copy];
}

+ (BOOL)removePoem:(int)poemID {
    FMDatabase *database = [TRDBManager sharedDatabase];
    /*执行删除操作
     除了查询操作, 其他任何操作(增/删/改)指定为更新操作
     */
    BOOL isSuccess = [database executeUpdateWithFormat:@"delete from T_SHI where D_ID=%d", poemID];
    
    //关闭数据库
    [database close];
    return isSuccess;
}









@end
