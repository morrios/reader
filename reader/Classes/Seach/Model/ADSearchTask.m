//
//  ADSearchTask.m
//  reader
//
//  Created by beequick on 2017/9/28.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSearchTask.h"
#import "AFNetworking.h"

@interface ADSearchTask()
@property (nonatomic, strong) NSMutableArray *arrayOfTasks;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end
@implementation ADSearchTask
+ (instancetype)share{
    static ADSearchTask *task = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        task = [[ADSearchTask alloc] init];
    });
    return task;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] init];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.arrayOfTasks = [NSMutableArray array];
    }
    return self;
}

- (void)requestWithKeyWords:(NSString *)keywords responseObject:(SearchTaskValueChangeBlock)changeBlock{
    [self.arrayOfTasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask *taskObj, NSUInteger idx, BOOL *stop) {
        [taskObj cancel];
    }];
    
    /// empty the arraOfTasks
    [self.arrayOfTasks removeAllObjects];
    
    NSString *urlString = @"http://api.zhuishushenqi.com/book/auto-complete";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:keywords forKey:@"query"];
    /// init new task
    WeakSelf
    NSURLSessionDataTask *task = [self.manager GET:urlString parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        StrongSelf
        changeBlock(responseObject,nil);
        if (strongSelf.changeBlock) {
            strongSelf.changeBlock(responseObject, nil);
        }
        
        if ([strongSelf.delegate respondsToSelector:@selector(SearchTaskValue:responseObject:)]) {
            [strongSelf.delegate SearchTaskValue:keywords responseObject:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        StrongSelf
        if (strongSelf.changeBlock) {
            strongSelf.changeBlock(nil, error);
        }
    }];
    
    [self.arrayOfTasks addObject:task];
}

@end
