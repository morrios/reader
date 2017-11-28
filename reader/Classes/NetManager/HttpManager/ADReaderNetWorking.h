//
//  ADReaderNetWorking.h
//  reader
//
//  Created by beequick on 2017/8/10.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADNetManager.h"
#import "ADCache.h"
#import "YYModel.h"

typedef void (^ADCompleteHandle)(id responseObject, NSError * error);


@interface ADReaderNetWorking : NSObject

+ (void)seach_KeyWords:(ADCompleteHandle)complete;
+ (void)seach_GetBookList:(NSString *)keyWord complete:(ADCompleteHandle)complete;
+ (void)seach_GetBookInfoWithId:(NSString *)bookId complete:(ADCompleteHandle)complete;
+ (void)book_getAllChapters:(NSString *)bookId complete:(ADCompleteHandle)complete;
+ (void)book_getBookContentLink:(NSString *)link bookId:(NSString *)bookId complete:(ADCompleteHandle)complete;
+ (void)Home_getReadBookInfo:(NSArray *)bookids complete:(ADCompleteHandle)complete;

//获取分类
+ (void)Search_getAllCategory:(ADCompleteHandle)complete;
+ (void)Search_getAllRanking:(ADCompleteHandle)complete;

//获取排行榜的列表
+ (void)Rank_getRankListId:(NSString *)listId complete:(ADCompleteHandle)complete;
//获取分类列表
+ (void)Category_getRankListGender:(NSString *)gender type:(NSString *)type major:(NSString *)major minor:(NSString *)minor page:(int)page complete:(ADCompleteHandle)complete;

@end
