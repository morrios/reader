//
//  ADHistoryDataSouce.m
//  reader
//
//  Created by beequick on 2017/8/9.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADHistoryDataSouce.h"


@interface ADHistoryDataSouce ()

@property (nonatomic, copy) NSString *cellIdentifier;

@end

@implementation ADHistoryDataSouce

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
 ConfigureCellBlock:(TableViewCellConfigureBlock)ConfigureCellBlock{
    self = [super init];
    if (self) {
        self.items = [items copy];
        self.cellIdentifier = aCellIdentifier;
        self.ConfigureCellBlock = [ConfigureCellBlock copy];
    }
    return self;
}
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    id item = [self itemAtIndexPath:indexPath];
    self.ConfigureCellBlock(cell, item, indexPath);
    return cell;
}

@end
