//
//  ADFindTableViewCell.h
//  reader
//
//  Created by beequick on 2017/11/14.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADFindTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (copy, nonatomic) NSString *titleString;

@end
