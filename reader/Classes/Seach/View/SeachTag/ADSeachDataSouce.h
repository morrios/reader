//
//  ADSeachDataSouce.h
//  reader
//
//  Created by beequick on 2017/8/9.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CollectionViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexpath);

@interface ADSeachDataSouce : NSObject<UICollectionViewDataSource>

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(CollectionViewCellConfigureBlock)ConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) NSArray *items;

@end
