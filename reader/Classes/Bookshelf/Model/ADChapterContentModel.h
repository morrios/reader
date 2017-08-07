//
//  ADChapterContentModel.h
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADChapterContentModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, assign) NSUInteger pageCount;
- (void)updateContentPaging;

- (NSString *)getStringWith:(NSUInteger)page;

@end
