//
//  ADFindTableViewCell.m
//  reader
//
//  Created by beequick on 2017/11/14.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADFindTableViewCell.h"

@implementation ADFindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.titleL.text = titleString;
    [self.titleL sizeToFit];
}
@end
