//
//  ADReaderNetWorking.h
//  reader
//
//  Created by beequick on 2017/8/10.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADNetManager.h"

typedef void (^ADCompleteHandle)(id responseObject, NSError * error);


@interface ADReaderNetWorking : NSObject

+ (void)seach_KeyWords:(ADCompleteHandle)complete;
+ (void)seach_GetBookList:(NSString *)keyWord complete:(ADCompleteHandle)complete;
+ (void)seach_GetBookInfoWithId:(NSString *)bookId complete:(ADCompleteHandle)complete;
+ (void)book_getAllChapters:(NSString *)bookId complete:(ADCompleteHandle)complete;
+ (void)book_getBookContentLink:(NSString *)link complete:(ADCompleteHandle)complete;
+ (void)Home_getReadBookInfo:(NSArray *)bookids complete:(ADCompleteHandle)complete;
@end
