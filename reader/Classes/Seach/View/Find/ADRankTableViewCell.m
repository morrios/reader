//
//  ADRankTableViewCell.m
//  reader
//
//  Created by beequick on 2017/11/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADRankTableViewCell.h"



@implementation ADRankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setIconUrlString:(NSString *)iconUrlString{
    _iconUrlString = iconUrlString;
    NSURL *url = [NSURL URLWithString:iconUrlString];
    [self.iconV sd_setImageWithURL:url];
}


@end
