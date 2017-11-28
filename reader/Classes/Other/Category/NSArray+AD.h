//
//  NSArray+AD.h
//  reader
//
//  Created by beequick on 2017/11/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef id (^MapBlock)(id obj,int index);

@interface NSArray (AD)
-(NSMutableArray *)map:(MapBlock)block;

@end
@interface NSMutableArray (AD)
-(void)bqAddObjectsFromArray:(NSArray *)otherArray;
-(void)bqAddObject:(id)anObject;
@end

