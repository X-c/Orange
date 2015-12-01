//
//  TRPoemCategory.m
//  TRPoetry
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "TRPoemCategory.h"
#import "TRDBManager.h"
#import "FMDatabase.h"

@implementation TRPoemCategory

+ (NSArray *)parsePoetryCategory {
    //获取数据库对象
    FMDatabase *database = [TRDBManager sharedDatabase];
    //获取T_KIND表中的所有数据
    FMResultSet *resultSet = [database executeQuery:@"select * from T_KIND"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    //循环解析
    while ([resultSet next]) {
        TRPoemCategory *poemCategory = [TRPoemCategory new];
        //解析(resultSet每条记录<-->poemCategory)
        poemCategory.poemCategory = [resultSet stringForColumn:@"D_KIND"];
        poemCategory.number = [resultSet intForColumn:@"D_NUM"];
        poemCategory.categoryIntroduction = [resultSet stringForColumn:@"D_INTROKIND"];
        poemCategory.poemComment = [resultSet stringForColumn:@"D_INTROKIND2"];
        [mutableArray addObject:poemCategory];
    }
    
    //收尾工作(释放resultSet占用内存;关闭数据库)
    [database closeOpenResultSets];
    [database close];
    
    return [mutableArray copy];
}





@end
