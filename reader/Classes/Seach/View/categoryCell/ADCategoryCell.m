//
//  ADCategoryCell.m
//  reader
//
//  Created by beequick on 2017/9/28.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADCategoryCell.h"
#import "Masonry.h"
@implementation ADCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self addLine:lineTypeRight];
    [self addLine:lineTypeTop];
}
- (void)layoutSubviews{
    [super layoutSubviews];
   

}
- (void)setModel:(ADCategoryModel *)model{
    _model = model;
    self.majorL.text = model.name;
    self.booksL.text = [NSString stringWithFormat:@"%ld本",model.bookCount];
}

- (void)addLine:(lineType)type{
    UIColor *lineColor = [UIColor colorWithHexString:@"eeeeee"];
    UIView *line = [UIView new];
    line.backgroundColor = lineColor;
    [self addSubview:line];

    switch (type) {
        case lineTypeLeft:
            [self lineMakeLeftConstraint:line];
            break;
        case lineTypeRight:
            [self lineMakeRightConstraint:line];
            break;
        case lineTypeTop:
            [self lineMakeTopConstraint:line];
            break;
        case lineTypeBottom:
            [self lineMakeBottomConstraint:line];
            break;
        default:
            break;
    }
}

- (void)lineMakeLeftConstraint:(UIView *)line{
    CGFloat lineWidth = 1.0;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_offset(lineWidth);
        make.bottom.equalTo(self);
    }];
}
- (void)lineMakeRightConstraint:(UIView *)line{
    CGFloat lineWidth = 1.0;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_offset(lineWidth);
        make.bottom.equalTo(self);
    }];
}
- (void)lineMakeTopConstraint:(UIView *)line{
    CGFloat lineWidth = 1.0;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_offset(lineWidth);
        make.right.equalTo(self);
    }];
}
- (void)lineMakeBottomConstraint:(UIView *)line{
    CGFloat lineWidth = 1.0;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_offset(lineWidth);
        make.right.equalTo(self);
    }];
}
@end
