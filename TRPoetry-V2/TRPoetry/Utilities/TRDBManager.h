//
//  TRDBManager.h
//  TRPoetry
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface TRDBManager : NSObject

//使用单例模式返回一个唯一的数据库对象
+ (FMDatabase *)sharedDatabase;

@end
