//
//  ADCache.h
//  ImageBrowser
//
//  Created by 杜林伟 on 16/9/28.
//  Copyright © 2016年 adu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADChapterContentModel.h"
#import "YYCache.h"
@class AABookContentCacheModel;
@interface ADCache : NSObject
@property (nonatomic, strong) YYCache *cache;
+ (instancetype)share;
/**
 *  key生成：
 *  章节url -> md5
 */
- (void)saveChapter:(id)chapter key:(NSString *)key;
- (void)saveChapter:(id)chapter model:(AABookContentCacheModel *)model;
- (BOOL)AA_containsObject:(AABookContentCacheModel *)model;

- (id)getChapter:(AABookContentCacheModel *)model;
@end

@interface AABookContentCacheModel : NSObject
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *bookId;

@end
