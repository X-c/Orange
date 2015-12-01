//
//  TRDBManager.m
//  TRPoetry
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "TRDBManager.h"

@implementation TRDBManager

+ (FMDatabase *)sharedDatabase {
    static FMDatabase *database = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //拼接拷贝的路径(/Documents/sqlite.db)
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *copyDBPath = [documentsPath stringByAppendingPathComponent:@"sqlite.db"];
        
        //获取数据文件的路径
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Poetry" ofType:@"bundle"];
        //拼接数据库文件的路径
        NSString *databaseFilePath = [bundlePath stringByAppendingPathComponent:@"sqlite.db"];
        NSError *error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:copyDBPath]) {
                [[NSFileManager defaultManager] copyItemAtPath:databaseFilePath toPath:copyDBPath error:&error];
        }
        
        if (!error) {
            //初始化database对象
            database = [FMDatabase databaseWithPath:copyDBPath];
        } else {
            NSLog(@"拷贝失败:%@", error.userInfo);
        }

    });
    
    //!!!打开数据库
    [database open];
    
    return database;
}




@end
