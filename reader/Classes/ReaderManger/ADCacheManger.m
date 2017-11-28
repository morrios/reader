//
//  ADCacheManger.m
//  reader
//
//  Created by beequick on 2017/8/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADCacheManger.h"
#import "YYCache.h"
#import "ADReaderNetWorking.h"

@implementation ADCacheManger{
    dispatch_group_t kgroup;
    dispatch_semaphore_t semaphore;
    dispatch_queue_t k_queue;
}

+ (instancetype)share{
    static ADCacheManger *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[self alloc] init];
    });
    return cache;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        kgroup = dispatch_group_create();
        semaphore = dispatch_semaphore_create(10);
        k_queue = dispatch_queue_create("com.ADCacheManger.download", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}


- (void)loadAllChapters:(NSArray *)chapters{
    [self loadchapters:chapters];
}
- (void)loadAllChaptersFrom:(NSInteger)fromC chatpers:(NSArray *)chapters{
    NSInteger afterCount = chapters.count - fromC - 1;
    [self loadChatpersFrom:fromC After:afterCount chatpers:chapters];
}
- (void)loadChatpersFrom:(NSInteger)fromC After:(NSInteger)count chatpers:(NSArray *)chapters{
    NSMutableArray *newArray = [NSMutableArray array];
    
    for (NSInteger i=fromC; i<(count+fromC); i++) {
        NSInteger listNum = fromC + i;
        if (listNum<chapters.count) {
            [newArray addObject:chapters[listNum]];
        }
        
    }
    [self loadchapters:newArray];
}
- (void)loadchapters:(NSArray *)chapters{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        WeakSelf
        for (int i = 0; i < chapters.count; i++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [self requestChapter:chapters[i]];
            
        }
    });
}
- (void)loadchapters1:(NSArray *)chapters{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        WeakSelf
        for (int i = 0; i < chapters.count; i++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [self requestChapter:chapters[i]];
            dispatch_group_async(kgroup, k_queue, ^{
                StrongSelf
                NSLog(@"下载完成%d", i);
                [strongSelf requestChapter:chapters[i]];
            });
        }
        dispatch_wait(kgroup, DISPATCH_TIME_FOREVER);
    });
}

- (void)requestChapter:(id)object{
    NSString *link = object[@"link"];
    
    
}

@end
