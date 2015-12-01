//
//  TRPoem.h
//  TRPoetry
//
//  Created by tarena on 15/11/27.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPoem : NSObject

//诗词ID
@property (nonatomic, assign) int poemID;
//诗词内容
@property(nonatomic,strong) NSString *poemContent;
//诗词介绍
@property(nonatomic,strong) NSString *poemIntroduction;
//诗词作者名字
@property(nonatomic,strong) NSString *poemAuthor;
//诗词属于哪个分类
@property(nonatomic,strong) NSString *poemCategory;
//诗词标题
@property(nonatomic,strong) NSString *poemTitle;

//给定一个诗词的类别,返回解析好的TRPoem数组
+ (NSArray *)poetryListWithCategory:(NSString *)category;

//给定一个诗词的ID, 返回是否删除成功的BOOL值
+ (BOOL)removePoem:(int)poemID;










@end
