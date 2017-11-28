//
//  ADCategoryCell.h
//  reader
//
//  Created by beequick on 2017/9/28.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADCategoryModel.h"

typedef NS_ENUM(NSInteger,lineType) {//上下左右
    lineTypeTop,
    lineTypeBottom,
    lineTypeLeft,
    lineTypeRight
};
@interface ADCategoryCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *majorL;
@property (weak, nonatomic) IBOutlet UILabel *booksL;
@property (nonatomic, strong) ADCategoryModel *model;
- (void)addLine:(lineType)type;
@end
