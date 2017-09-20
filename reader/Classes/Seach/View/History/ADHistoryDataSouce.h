//
//  ADHistoryDataSouce.h
//  reader
//
//  Created by beequick on 2017/8/9.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexpath);

@interface ADHistoryDataSouce : NSObject<UITableViewDataSource>

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
 ConfigureCellBlock:(TableViewCellConfigureBlock)ConfigureCellBlock;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) TableViewCellConfigureBlock ConfigureCellBlock;

@end
