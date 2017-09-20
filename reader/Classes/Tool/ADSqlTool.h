//
//  ADSqlTool.h
//  reader
//
//  Created by beequick on 2017/8/13.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADBookInfo.h"


@interface ADSqlTool : NSObject
+ (instancetype)ShareInstance;

//插入数据
-(void)inserModel:(ADBookInfo *)model;

//删除数据
-(void)deleteBookId:(NSString *)bookID;

//查询
- (NSArray *)query;
//查询某一天数据
- (BOOL)queryWithBookId:(NSString *)bookId;

@end
