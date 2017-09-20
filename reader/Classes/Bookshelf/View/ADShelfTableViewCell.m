//
//  ADShelfTableViewCell.m
//  reader
//
//  Created by beequick on 2017/8/14.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADShelfTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ADShelfTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
}

- (void)setModel:(ADSherfModel *)model{
    _model = model;
//    self.cover sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:<#(nullable UIImage *)#>
//    self.bookNameL.text = model.
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
