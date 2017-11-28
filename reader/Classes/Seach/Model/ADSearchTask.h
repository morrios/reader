//
//  ADSearchTask.h
//  reader
//
//  Created by beequick on 2017/9/28.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SearchTaskValueChangeBlock)(id responseObject,NSError *errpr);

@protocol ADSearchTaskDelegate <NSObject>
@optional
- (void)SearchTaskValue:(id)value responseObject:(id)object;

@end
@interface ADSearchTask : NSObject
- (void)requestWithKeyWords:(NSString *)keywords responseObject:(SearchTaskValueChangeBlock)changeBlock;
+ (instancetype)share;
@property (nonatomic, copy) SearchTaskValueChangeBlock changeBlock;

@property (nonatomic,weak) id <ADSearchTaskDelegate>delegate;
@end
