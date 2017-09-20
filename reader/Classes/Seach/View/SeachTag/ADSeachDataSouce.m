//
//  ADSeachDataSouce.m
//  reader
//
//  Created by beequick on 2017/8/9.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSeachDataSouce.h"

@interface ADSeachDataSouce ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CollectionViewCellConfigureBlock ConfigureCellBlock;

@end

@implementation ADSeachDataSouce

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(CollectionViewCellConfigureBlock)ConfigureCellBlock{
    self = [super init];
    if (self) {
        self.items = [items copy];
        self.cellIdentifier = aCellIdentifier;
        self.ConfigureCellBlock = [ConfigureCellBlock copy];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    return self.items[(NSUInteger)indexPath.row];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    self.ConfigureCellBlock(cell,[self itemAtIndexPath:indexPath],indexPath);
    return cell;
}

@end
