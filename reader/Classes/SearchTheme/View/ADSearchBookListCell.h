//
//  ADSearchBookListCell.h
//  reader
//
//  Created by beequick on 2017/10/25.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADListBookModel.h"

@interface ADSearchBookListCell : UITableViewCell
@property (nonatomic, strong) ADListBookModel *book;
- (CGFloat)transformRect:(ADListBookModel *)model;

@end
