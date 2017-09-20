//
//  ADChapterTableViewCell.m
//  reader
//
//  Created by beequick on 2017/8/17.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADChapterTableViewCell.h"

@interface ADChapterTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *chapterNumL;
@property (weak, nonatomic) IBOutlet UILabel *chapterNameL;
@property (weak, nonatomic) IBOutlet UIImageView *dotView;

@end

@implementation ADChapterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithHexString:@"#555555"].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 1);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 30, 0);
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, self.frame.origin.x + self.frame.size.width, 0);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {3,1};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
}


- (void)setModel:(ADChapterModel *)model{
    _model = model;
    self.chapterNameL.text = model.title;
}

- (void)setIndex:(NSUInteger)index{
    _index = index;
    self.chapterNumL.text = [NSString stringWithFormat:@"%ld.", index];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
