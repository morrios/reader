//
//  ADCacheManger.m
//  reader
//
//  Created by beequick on 2017/8/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADCacheManger.h"
#import "YYCache.h"

@implementation ADCacheManger

+ (instancetype)share{
    static ADCacheManger *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[self alloc] init];
    });
    return cache;
}



@end
