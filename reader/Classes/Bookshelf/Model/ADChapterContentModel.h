//
//  ADChapterContentModel.h
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADChapterContentModel : NSObject

@property (nonatomic, copy) NSString *body;

@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, assign) NSUInteger pageCount;

@property (nonatomic, copy) NSString *content;

/**
 需要手动赋值的
 */
//章节题目
@property (nonatomic, copy) NSString *title;
//书籍id
@property (nonatomic, copy) NSString *bookId;
//阅读到哪页
@property (nonatomic, assign) NSUInteger index;
//阅读到哪章
@property (nonatomic, assign) NSUInteger chapterNum;

- (void)updateContentPaging;

- (NSString *)getStringWith:(NSUInteger)page;

@end
