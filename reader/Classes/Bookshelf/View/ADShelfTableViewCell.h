//
//  ADShelfTableViewCell.h
//  reader
//
//  Created by beequick on 2017/8/14.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADSherfModel.h"

@interface ADShelfTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *bookNameL;
@property (weak, nonatomic) IBOutlet UILabel *desLable;

@property (nonatomic,strong) ADSherfModel *model;

@end
