//
//  ADReaderNetWorking.m
//  reader
//
//  Created by beequick on 2017/8/10.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADReaderNetWorking.h"
#import "NSString+AD.h"

@implementation ADReaderNetWorking

+ (void)seach_KeyWords:(ADCompleteHandle)complete{
    NSString *url = @"http://api.zhuishushenqi.com/book/hot-word";
    [ADNetManager GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject,nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
}

+ (void)seach_GetBookList:(NSString *)keyWord complete:(ADCompleteHandle)complete{
    NSString *url = @"http://api.zhuishushenqi.com/book/fuzzy-search";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"query"] = keyWord;
    dict[@"limit"] = @"100";
    dict[@"v"] = @"1";
    dict[@"start"] = @"0";
    [ADNetManager GET:url params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject,nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
}

+ (void)seach_GetBookInfoWithId:(NSString *)bookId complete:(ADCompleteHandle)complete{
    NSString *url = @"http://api.zhuishushenqi.com/book/";
    url = [NSString stringWithFormat:@"%@%@", url,bookId];
    [ADNetManager GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject,nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
}

+ (void)book_getAllChapters:(NSString *)bookId complete:(ADCompleteHandle)complete{
    NSString *url = @"http://api.zhuishushenqi.com/mix-toc/";
    url = [NSString stringWithFormat:@"%@%@", url, bookId];
    [ADNetManager GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject, nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
    
}

+ (void)book_getBookContentLink:(NSString *)link complete:(ADCompleteHandle)complete{
//    link = [NSString stringWithFormat:@"%@%@",ChapterBaseUrl, [link AD_stringByURLEncode]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"t"] = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
    dict[@"k"] = @"a51d7fe251e4ecd1";
    [ADNetManager GET:link params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject, nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
    
}

+ (void)Home_getReadBookInfo:(NSArray *)bookids complete:(ADCompleteHandle)complete{
    NSString *url = @"http://api.zhuishushenqi.com/book";
    if (bookids.count<=0) {
        return;
    }
    __block NSString *ids = @"";
    [bookids enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ADBookInfo *model = (ADBookInfo *)obj;
        if (ids.length==0) {
            ids = model._id;
        }else{
            ids = [NSString stringWithFormat:@"%@,%@", ids, model._id];
        }
        
    }];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"view"] = @"updated";
    dict[@"id"] = ids;
    [ADNetManager GET:url params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject, nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
}
@end
