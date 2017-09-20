//
//  ADMenuLeftCell.h
//  reader
//
//  Created by beequick on 2017/9/20.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADChapterModel.h"

@interface ADMenuLeftCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chapterNumL;
@property (weak, nonatomic) IBOutlet UILabel *chapterNameL;
@property (weak, nonatomic) IBOutlet UIImageView *dotView;
@property (nonatomic, strong) ADChapterModel *model;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSUInteger selectIndex;
@end
