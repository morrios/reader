//
//  ADDisplayView.m
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADDisplayView.h"
#import "ADReaderSetting.h"
#import "NSString+AD.h"

@implementation ADDisplayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setContentFrame:(CTFrameRef)contentFrame{
    if (_contentFrame) {
        CFRelease(_contentFrame);
    }
    
    _contentFrame = contentFrame;
    [self setNeedsDisplay];
}

- (void)dealloc{
    if (_contentFrame) {
        CFRelease(_contentFrame);
    }
}

- (void)setContent:(NSString *)content{
    _content = content;
    if (content) {
        ADReaderSetting *setting = [ADReaderSetting shareInstance];
        content = [ADReaderSetting shareInstance].setting.unsimplified?[content reverseString]:content;
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:content attributes:setting.readerAttributes];
        CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)att);
        CGPathRef pathRef = CGPathCreateWithRect(self.bounds, NULL);
        CTFrameRef frame = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, [att length]), pathRef, NULL);
        if (setterRef) {
            CFRelease(setterRef);
        }
        if (pathRef) {
            CFRelease(pathRef);
        }
        if (_contentFrame) {
            CFRelease(_contentFrame);
        }
        _contentFrame = frame;
        
        [self setNeedsDisplay];
    }
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    self.backgroundColor = [UIColor clearColor];
    
    //1.获取当前绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.旋转坐坐标系(默认和UIKit坐标是相反的)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //3.绘制内容
    CTFrameDraw(self.contentFrame, context);
    
    
}


@end
