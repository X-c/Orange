//
//  TRPoemCategory.h
//  TRPoetry
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPoemCategory : NSObject

//诗词的分类
@property(nonatomic,strong) NSString *poemCategory;
//诗词的id
@property(nonatomic,assign) int number;
//当前分类的介绍
@property(nonatomic,strong) NSString *categoryIntroduction;
//当前分类的备注
@property(nonatomic,strong) NSString *poemComment;


//返回所有已经解析好诗词分类对象数组(TRPoemCategory)
+ (NSArray *)parsePoetryCategory;











@end
