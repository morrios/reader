//
//  ADChapterTableViewCell.h
//  reader
//
//  Created by beequick on 2017/8/17.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADChapterModel.h"

@interface ADChapterTableViewCell : UITableViewCell

@property (nonatomic, strong) ADChapterModel *model;
@property (nonatomic, assign) NSUInteger index;

@end
