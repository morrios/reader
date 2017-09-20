//
//  ADHistoryModel.m
//  reader
//
//  Created by beequick on 2017/8/13.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADHistoryModel.h"

@implementation ADHistoryModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _pageIndex = 0;
        _chapterNum = 0;
    }
    return self;
}

@end
