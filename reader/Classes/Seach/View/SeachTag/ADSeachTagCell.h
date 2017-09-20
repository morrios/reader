//
//  ADSeachTagCell.h
//  reader
//
//  Created by beequick on 2017/8/9.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSeachTagCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (nonatomic, copy) NSString *keyword;
@end
