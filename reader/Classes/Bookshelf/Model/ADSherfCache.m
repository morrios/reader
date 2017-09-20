//
//  ADSherfCache.m
//  reader
//
//  Created by beequick on 2017/8/17.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSherfCache.h"
#import "YYModel.h"

static NSString *const bookCacheName = @"books";
static NSString *const bookCacheKey = @"info";

@interface ADSherfCache ()

@property (nonatomic, strong) NSMutableArray *books;

@end

@implementation ADSherfCache

+ (instancetype)share{
    static ADSherfCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[ADSherfCache alloc] init];
        NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [cacheFolder stringByAppendingPathComponent:bookCacheName];
        NSLog(@"path = %@", path);
        bookCache = [YYCache cacheWithName:bookCacheName];
        
    });
    return cache;
}
//添加书籍
+ (void)addBook:(ADBookInfo *)bookinfo{
    [[ADSherfCache share] addBook:bookinfo];
}
//查询书籍
+ (BOOL)queryWithBookId:(NSString *)bookid{
    return [[ADSherfCache share] queryWithBookId:bookid];
}
//移除书籍
+ (void)removeBook:(ADBookInfo *)bookinfo{
    [[ADSherfCache share] removeBook:bookinfo];
}
+ (ADSherfCusModel *)ADObjectForId:(NSString *)bookid{
    return (ADSherfCusModel *)[bookCache objectForKey:bookid];
}
+ (NSMutableArray *)query{
    return [[ADSherfCache share] query];
}

+ (void)UpdateWithBookInfo:(ADSherfCusModel *)bookinfo{
    [[ADSherfCache share] updateWithBookInfo:bookinfo];
}
//保存阅读历史
+ (void)UpdateHistoryWithBookId:(NSString *)bookID chapter:(NSInteger)chapter pageIndex:(NSInteger)pageIndex{
    [[ADSherfCache share] UpdateHistoryWithBookId:bookID chapter:chapter pageIndex:pageIndex];
}

- (void)UpdateHistoryWithBookId:(NSString *)bookID chapter:(NSInteger)chapter pageIndex:(NSInteger)pageIndex{
    if ([self queryWithBookId:bookID]) {
        ADSherfCusModel *model = (ADSherfCusModel *)[bookCache objectForKey:bookID];
        model.chapter = chapter;
        model.pageIndex = pageIndex;
        [bookCache setObject:model forKey:bookID];
    }
}
//搜索保存历史
+ (ADSherfCusModel *)QueryHistoryWithBookId:(NSString *)bookID{
    return [[ADSherfCache share] QueryHistoryWithBookId:bookID];
}
- (ADSherfCusModel *)QueryHistoryWithBookId:(NSString *)bookID{
    return (ADSherfCusModel *)[bookCache objectForKey:bookID];
}


- (void)updateWithBookInfo:(ADSherfCusModel *)bookinfo{
    if ([self queryWithBookId:bookinfo._id]) {
        [bookCache setObject:bookinfo forKey:bookinfo._id];
    }
}

- (NSMutableArray *)query{
    __block NSMutableArray *datas = [NSMutableArray array];
    [self.books enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id newobj = [bookCache objectForKey:obj];
        if (newobj) {
            [datas addObject:newobj];
        }
    }];
    
    return datas;
}

- (void)addBook:(ADBookInfo *)bookinfo{
    NSDictionary *json = [bookinfo yy_modelToJSONObject];
    ADSherfCusModel *model = [ADSherfCusModel yy_modelWithJSON:json];
    if (![self queryWithBookId:model._id]) {
        model.chapter = 0;
        model.pageIndex = 0;
        [self.books addObject:model._id];
        [bookCache setObject:self.books forKey:bookCacheKey];
        [bookCache setObject:model forKey:model._id];
        
    }
}


- (BOOL)queryWithBookId:(NSString *)bookId{
    __block BOOL isexit = NO;
    [self.books enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *_id = obj;
        if ([bookId isEqualToString:_id]) {
            NSLog(@"bookid = %@", _id);
            isexit = YES;
        }
    }];
    return isexit;
}

- (void)removeBook:(ADBookInfo *)bookinfo{
    if ([self queryWithBookId:bookinfo._id]) {
        [self.books removeObject:bookinfo._id];
        [bookCache removeObjectForKey:bookinfo._id];
    }
}

- (NSMutableArray *)books{
    if (!_books) {
        _books = [NSMutableArray array];
        NSArray *obj = (NSArray *)[bookCache objectForKey:bookCacheKey];
        if (obj) {
            [_books addObjectsFromArray:obj];
        }
    }
    return _books;
}

@end

@implementation ADSherfCusModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.referenceSource forKey:@"referenceSource"];
    [aCoder encodeObject:self.updated forKey:@"updated"];
    [aCoder encodeInteger:self.chaptersCount forKey:@"chaptersCount"];
    [aCoder encodeObject:self.lastChapter forKey:@"lastChapter"];
    [aCoder encodeObject:self.cover forKey:@"cover"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.chapter forKey:@"chapter"];
    [aCoder encodeInteger:self.pageIndex forKey:@"pageIndex"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self._id = [aDecoder decodeObjectForKey:@"_id"];
    self.author = [aDecoder decodeObjectForKey:@"author"];
    self.referenceSource = [aDecoder decodeObjectForKey:@"referenceSource"];
    self.updated = [aDecoder decodeObjectForKey:@"updated"];
    self.chaptersCount = [aDecoder decodeIntegerForKey:@"chaptersCount"];
    self.lastChapter = [aDecoder decodeObjectForKey:@"lastChapter"];
    self.cover = [aDecoder decodeObjectForKey:@"cover"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.chapter = [aDecoder decodeIntegerForKey:@"chapter"];
    self.pageIndex = [aDecoder decodeIntegerForKey:@"pageIndex"];
    return self;

   
}

@end
