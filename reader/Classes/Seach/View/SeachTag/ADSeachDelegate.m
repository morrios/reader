//
//  ADSeachDelegate.m
//  reader
//
//  Created by beequick on 2017/8/10.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSeachDelegate.h"
#import "ADSearchTask.h"

@implementation ADSeachDelegate

- (instancetype)initWithItems:(NSArray *)items{
    self = [super init];
    if (self) {
        self.items = [items copy];
    }
    return self;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.items[indexPath.row];
    
    NSLog(@"select");
    [[ADSearchTask share] requestWithKeyWords:str responseObject:^(id responseObject, NSError *errpr) {
        if (!errpr) {
            self.selectBlock(responseObject);
        }
    }];
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.items[indexPath.row];
    CGFloat width = [str widthForFont:[UIFont systemFontOfSize:12]]+25;
    return CGSizeMake(width, 25);
}



//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    (CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
@end
