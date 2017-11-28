//
//  ADRecommendCell.h
//  reader
//
//  Created by beequick on 2017/9/22.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADSeachDataSouce.h"
#import "ADSeachDelegate.h"
#import "EqualSpaceFlowLayoutEvolve.h"

@class ADRecommendCell;


@interface ADRecommendCell : UITableViewCell
@property (nonatomic, strong) ADSeachDataSouce *seachDatasouce;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) ADSeachDelegate *delegateFlowlayout;

@property (nonatomic, strong) NSArray *colorArr;
@property (nonatomic, strong) NSArray *hotwordDatas;
@property (weak, nonatomic) IBOutlet EqualSpaceFlowLayoutEvolve *flowLayout;

@property (strong, nonatomic) UICollectionView *myCollectionView;


@end
