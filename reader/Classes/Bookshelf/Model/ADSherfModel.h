//
//  ADSherfModel.h
//  reader
//
//  Created by beequick on 2017/8/14.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADSherfModel : NSObject
@property(nonatomic,strong)NSString *_id;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *referenceSource;
@property(nonatomic,strong)NSString *updated;
@property(nonatomic,assign)NSInteger chaptersCount;
@property(nonatomic,strong)NSString *lastChapter;

@end
