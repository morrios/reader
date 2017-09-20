//
//  ADSqlTool.m
//  reader
//
//  Created by beequick on 2017/8/13.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSqlTool.h"
#import "FMDB.h"

static FMDatabase *_db;
static id _instance;
@interface ADSqlTool ()
@end

@implementation ADSqlTool

+ (instancetype)ShareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [self openSql];
    });
    return _instance;
}

+ (void)openSql{
    //数据的路径，放在沙盒的cache下面
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"read.sqlite"];
    NSLog(@"%@", filePath);
    //创建并且打开一个数据库
    _db = [FMDatabase databaseWithPath:filePath];
    
    BOOL flag = [_db open];
    if (flag) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    
//    @property(nonatomic,strong)NSString *_id;
//    @property(nonatomic,strong)NSString *author;
//    @property(nonatomic,strong)NSString *referenceSource;
//    @property(nonatomic,strong)NSString *updated;
    //    @property(nonatomic,strong)NSString *title;
    //    @property(nonatomic,strong)NSString *cover;
    //创建表
    BOOL create =  [_db executeUpdate:@"create table if not exists BookList(id integer primary key  autoincrement, title text,bookId text, author text,cover text, updated text, lastChapter text)"];
    
    if (create) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
}


//插入数据
-(void)inserModel:(ADBookInfo *)model
{
    if ([self queryWithBookId:model._id]) {
        return;
    }
    [_db executeUpdate:@"INSERT INTO BookList (title, bookId, author,cover, updated, lastChapter) VALUES (?, ?, ?, ?, ?, ?);", model.title, model._id,model.author,model.cover,model.updated,model.lastChapter];
}
//-(void)insertName:(NSString *)name bookId:(NSString *)bookid
//{
//    if ([self queryWithBookId:bookid]) {
//        return;
//    }
//    [_db executeUpdate:@"INSERT INTO BookList (name, bookId) VALUES (?, ?);", name, bookid];
// 
//}

//删除数据
-(void)deleteBookId:(NSString *)bookID
{
    
    [_db executeUpdate:@"DELETE FROM BookList WHERE bookId = ?",bookID];

}

//查询
- (NSArray *)query
{
    // 1.执行查询语句
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM BookList"];
    NSMutableArray *array = [NSMutableArray array];
    // 2.遍历结果
    while ([resultSet next]) {
        ADBookInfo *model = [[ADBookInfo alloc] init];
        model._id = [resultSet stringForColumn:@"bookId"];
        model.title = [resultSet stringForColumn:@"title"];
        model.author = [resultSet stringForColumn:@"author"];
        model.cover = [resultSet stringForColumn:@"cover"];
        model.updated = [resultSet stringForColumn:@"updated"];
        model.lastChapter = [resultSet stringForColumn:@"lastChapter"];
        [array addObject:model];
    }
    return array;
}

//查询 莫一条数据
- (BOOL)queryWithBookId:(NSString *)bookId
{
    // 1.执行查询语句
    int count = 0;
    BOOL isExist = NO;
    FMResultSet *resultSet = [_db executeQuery:@"SELECT count(*) FROM BookList WHERE bookId = ?",bookId];
    if ([resultSet next]) {
        count = [resultSet intForColumnIndex:0];
    }
    if (count>0) {
        isExist = YES;
    }
    return isExist;
}

@end
