//
//  ADRankTableViewCell.h
//  reader
//
//  Created by beequick on 2017/11/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface ADRankTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconV;

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *downArrowV;
@property (nonatomic, copy) NSString *iconUrlString;
@end
