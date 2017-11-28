//
//  ADReaderNetWorking.m
//  reader
//
//  Created by beequick on 2017/8/10.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADReaderNetWorking.h"
#import "NSString+AD.h"
#import "ADBookInfo.h"


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
+ (void)book_getBookContentLink:(NSString *)link bookId:(NSString *)bookId complete:(ADCompleteHandle)complete{
//    link = [NSString stringWithFormat:@"%@%@",ChapterBaseUrl, [link AD_stringByURLEncode]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"t"] = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
    dict[@"k"] = @"a51d7fe251e4ecd1";
    AABookContentCacheModel *model = [AABookContentCacheModel new];
    model.link = link;
    model.bookId = bookId;
    if ([[ADCache share] AA_containsObject:model]) {
        id responseObject = [[ADCache share] getChapter:model];
        complete(responseObject, nil);
    }else{
        [ADNetManager GET:link params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"网络请求成功");
            complete(responseObject, nil);
            [[ADCache share] saveChapter:responseObject model:model];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            complete(nil, error);
        }];
    }
    
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
+ (void)Search_getAllCategory:(ADCompleteHandle)complete{
    
    NSString *url = @"http://api.zhuishushenqi.com/cats/lv2/statistics";
    [ADNetManager GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject, nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
}
+ (void)Search_getAllRanking:(ADCompleteHandle)complete{
    NSString *url = @"http://api.zhuishushenqi.com/ranking/gender";
    [ADNetManager GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject, nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
}

+ (void)Rank_getRankListId:(NSString *)listId complete:(ADCompleteHandle)complete{
    NSString *rankBaseUrl = @"http://api.zhuishushenqi.com/ranking/";
    NSString *url = [NSString stringWithFormat:@"%@%@", rankBaseUrl, listId];
    [ADNetManager GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject, nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
}

+ (void)Category_getRankListGender:(NSString *)gender type:(NSString *)type major:(NSString *)major minor:(NSString *)minor start:(int)satrt complete:(ADCompleteHandle)complete{
    NSString *urlString = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/by-categories?gender=%@&type=%@&major=%@&minor=%@&start=%d&limit=50",gender, type, minor, minor, satrt];
    [ADNetManager GET:urlString params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(responseObject, nil);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        complete(nil, error);
    }];
    
}

@end
