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
        self.editEnable = NO;
        self.items = [items copy];
        self.cellIdentifier = aCellIdentifier;
        self.ConfigureCellBlock = [ConfigureCellBlock copy];
    }
    return self;
}
- (id)initWithItems:(NSArray *)items
         editEnable:(BOOL)editEnable
     cellIdentifier:(NSString *)aCellIdentifier
 ConfigureCellBlock:(TableViewCellConfigureBlock)ConfigureCellBlock{
    self = [super init];
    if (self) {
        self.editEnable = editEnable;
        self.items = [items copy];
        self.cellIdentifier = aCellIdentifier;
        self.ConfigureCellBlock = [ConfigureCellBlock copy];
    }
    return self;
}
- (id)initWithCellIdentifier:(NSString *)aCellIdentifier ConfigureCellBlock:(TableViewCellConfigureBlock)ConfigureCellBlock{
    self = [super init];
    if (self) {
        self.editEnable = NO;
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
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{}
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
    }else if ([self.delegate respondsToSelector:@selector(adTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate adTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
// 先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.editEnable;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self itemAtIndexPath:indexPath];
    if (self.cellEditBlock) {
        self.cellEditBlock((AATableViewCellEditingStyle)editingStyle, item, indexPath);
    }
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        /*
         [_dataMArr removeObjectAtIndex:indexPath.row];
         [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [_tableView reloadData];
         */
        if (self.cellDeleteBlock) {
            self.cellDeleteBlock(item, indexPath);
        }
        
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        if (self.cellInsertBlock) {
            self.cellInsertBlock(item, indexPath);
        }
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}  
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(adTableView:heightForRowAtIndexPath:)]) {
        return [self.delegate adTableView:tableView heightForRowAtIndexPath:indexPath];
    }else{
        if (self.rowHeight) {
            return self.rowHeight;
        }
    }
    
    return 44.0;
}

@end
