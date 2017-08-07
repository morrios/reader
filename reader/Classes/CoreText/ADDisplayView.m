//
//  ADDisplayView.m
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADDisplayView.h"
#import <CoreText/CoreText.h>

@implementation ADDisplayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.



- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    self.backgroundColor = [UIColor whiteColor];
    
    //1.获取当前绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.旋转坐坐标系(默认和UIKit坐标是相反的)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //3.绘制内容
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
    
}


@end
