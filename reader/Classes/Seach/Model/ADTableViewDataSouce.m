//
//  ADTableViewDataSouce.m
//  reader
//
//  Created by beequick on 2017/8/11.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADTableViewDataSouce.h"

@implementation ADTableViewDataSouce
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

- (id)initWithCellIdentifier:(NSString *)aCellIdentifier ConfigureCellBlock:(TableViewCellConfigureBlock)ConfigureCellBlock{
    self = [super init];
    if (self) {
        self.cellIdentifier = aCellIdentifier;
        self.ConfigureCellBlock = [ConfigureCellBlock copy];
    }
    return self;
}


- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}
#pragma mark - method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(adScrollViewDidScroll:)]) {
        [self.delegate adScrollViewDidScroll:scrollView];
    }
}


#pragma mark - dataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellForRowBlock) {
        self.cellForRowBlock(indexPath);
    }else if ([self.delegate respondsToSelector:@selector(adTableView:cellForRowAtIndexPath:)]) {
        return [self.delegate adTableView:tableView cellForRowAtIndexPath:indexPath];
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        id item = [self itemAtIndexPath:indexPath];
        self.ConfigureCellBlock(cell, item, indexPath);
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellSelectBlock) {
        id item = [self itemAtIndexPath:indexPath];
        self.cellSelectBlock(item, indexPath);
    }
    if ([self.delegate respondsToSelector:@selector(adTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate adTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.rowHeight) {
        return self.rowHeight;
    }
    return 44.0;
}

@end
