//
//  ADMenuLeftCell.m
//  reader
//
//  Created by beequick on 2017/9/20.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADMenuLeftCell.h"


@interface ADMenuLeftCell ()

@end

@implementation ADMenuLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ADChapterModel *)model{
    _model = model;
    self.chapterNameL.text = model.title;
}

- (void)setIndex:(NSUInteger)index{
    _index = index;
    self.chapterNumL.text = [NSString stringWithFormat:@"%ld ", index+1];
    if (_selectIndex) {
        if (_index == _selectIndex) {
            UIColor *selectColor = [UIColor colorWithHexString:@"#FD8B25"];
            self.chapterNumL.textColor = selectColor;
            self.chapterNameL.textColor = selectColor;
        }else{
            self.chapterNumL.textColor = [UIColor colorWithHexString:@"#848484"];
            self.chapterNameL.textColor = [UIColor colorWithHexString:@"#333333"];
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
