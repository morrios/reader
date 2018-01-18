//
//  ADSherfCache.h
//  reader
//
//  Created by beequick on 2017/8/17.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCache.h"
#import "ADBookInfo.h"

@class ADSherfCusModel;

//static YYCache *bookCache = nil;

@interface ADSherfCache : NSObject

+ (void)addBook:(ADBookInfo *)bookinfo;

+ (BOOL)queryWithBookId:(NSString *)bookid;
+ (ADSherfCusModel *)ADObjectForId:(NSString *)bookid;

+ (void)removeBook:(ADBookInfo *)bookinfo;
+ (void)removeBookId:(NSString *)bookId;
+ (void)UpdateWithBookInfo:(ADSherfCusModel *)bookinfo;
+ (void)UpdateHistoryWithBookId:(NSString *)bookID chapter:(NSInteger)chapter pageIndex:(NSInteger)pageIndex;
+ (ADSherfCusModel *)QueryHistoryWithBookId:(NSString *)bookID;

+ (NSMutableArray *)query;
+ (NSMutableArray *)queryDesending;

@end

@interface ADSherfCusModel : NSObject<NSCoding>
@property(nonatomic,strong)NSString *_id;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *referenceSource;
@property(nonatomic,strong)NSString *updated;
@property(nonatomic,assign)NSInteger chaptersCount;
@property(nonatomic,strong)NSString *lastChapter;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *title;

@property(nonatomic,assign)NSInteger chapter;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSString *updateDate;
- (void)updateModelDate;
@end


