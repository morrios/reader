//
//  ADCacheManger.h
//  reader
//
//  Created by beequick on 2017/8/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ADChapterContentModel;

@interface ADCacheManger : NSObject

+ (instancetype)share;
- (void)saveChapter:(ADChapterContentModel *)model;
- (NSString *)getChapter:(ADChapterContentModel *)model;

@end
