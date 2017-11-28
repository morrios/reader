//
//  ADSeachTagCell.m
//  reader
//
//  Created by beequick on 2017/8/9.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSeachTagCell.h"

@implementation ADSeachTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    self.contentLable.text = keyword;
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
}

@end
