//
//  ADRecommendCell.m
//  reader
//
//  Created by beequick on 2017/9/22.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADRecommendCell.h"
#import "ADSeachTagCell.h"

static NSString *const idCollectionViewCell = @"idCollectionViewCell";

@implementation ADRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    _flowLayout.cellType = AlignWithLeft;
    _flowLayout.betweenOfCell = 10;
    CollectionViewCellConfigureBlock block = ^(ADSeachTagCell *cell, NSString *name, NSIndexPath *indexpath){
        cell.keyword = name;
        NSInteger index = indexpath.row % 6;
        cell.backgroundColor = self.colorArr[index];
    };
    if (!_hotwordDatas) {
        _hotwordDatas = @[];
    }
    self.seachDatasouce = [[ADSeachDataSouce alloc] initWithItems:self.hotwordDatas cellIdentifier:idCollectionViewCell configureCellBlock:block];
    _collectionView.dataSource = _seachDatasouce;
    
    self.delegateFlowlayout = [[ADSeachDelegate alloc] initWithItems:self.hotwordDatas];
    _collectionView.delegate = self.delegateFlowlayout;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"ADSeachTagCell" bundle:nil] forCellWithReuseIdentifier:idCollectionViewCell];
}

- (void)setHotwordDatas:(NSArray *)hotwordDatas{
    self.delegateFlowlayout = [[ADSeachDelegate alloc] initWithItems:self.hotwordDatas];
    [self.collectionView reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSArray *)colorArr{
    if (!_colorArr) {
        UIColor *color1 = [UIColor colorWithHexString:@"#92C6EE"];
        UIColor *color2 = [UIColor colorWithHexString:@"#BE6CCE"];
        UIColor *color3 = [UIColor colorWithHexString:@"#F4BB82"];
        UIColor *color4 = [UIColor colorWithHexString:@"#93CED4"];
        UIColor *color5 = [UIColor colorWithHexString:@"#6BCBB7"];
        UIColor *color6 = [UIColor colorWithHexString:@"#E58F90"];
        _colorArr = [NSArray arrayWithObjects:color1,color2,color3,color4,color5,color6, nil];
    }
    return _colorArr;
}
@end
