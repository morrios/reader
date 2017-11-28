//
//  NSArray+AD.m
//  reader
//
//  Created by beequick on 2017/11/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "NSArray+AD.h"

@implementation NSArray (AD)
-(NSMutableArray *)map:(MapBlock)block{
    NSMutableArray *t = @[].mutableCopy;
    int index = 0;
    for (id obj in self) {
        id result = block(obj,index);
        if ([result isKindOfClass:[NSArray class]]) {
            [t bqAddObjectsFromArray:result];
        }else{
            [t bqAddObject:result];
        }
        index++;
    }
    return t;
}
@end
@implementation NSMutableArray (AD)

-(void)bqAddObjectsFromArray:(NSArray *)otherArray{
    if (!otherArray || ![otherArray isKindOfClass:[NSArray class]] || [otherArray count]<=0) {
        return;
    }
    return [self addObjectsFromArray:otherArray];
}
-(void)bqAddObject:(id)anObject{
    if (!anObject) {
        return;
    }
    return [self addObject:anObject];
}
@end
