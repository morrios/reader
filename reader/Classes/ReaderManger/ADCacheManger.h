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
- (void)loadAllChapters:(NSArray *)chapters;
- (void)loadAllChaptersFrom:(NSInteger)fromC chatpers:(NSArray *)chapters;
- (void)loadChatpersFrom:(NSInteger)fromC After:(NSInteger)count chatpers:(NSArray *)chapters;

- (void)loadchapters:(NSArray *)chapters;
@end
