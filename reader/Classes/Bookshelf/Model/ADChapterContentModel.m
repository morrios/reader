//
//  ADChapterContentModel.m
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADChapterContentModel.h"
#import "ADReaderSetting.h"
#import <CoreText/CoreText.h>

@implementation ADChapterContentModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _index = 0;
        _chapterNum = 0;
    }
    return self;
}
- (void)setBody:(NSString *)body{
    _body = body;
    [self updateContentPaging];
}

- (void)updateContentPaging {
    [self pagingWithBounds:CGRectMake(kYReaderLeftSpace, kYReaderTopSpace, kScreenWidth - kYReaderLeftSpace - kYReaderRightSpace, kScreenHeight - kYReaderTopSpace - kYReaderBottomSpace)];
}
- (void)pagingWithBounds:(CGRect)rect{
    NSMutableArray *rangArr = @[].mutableCopy;
    ADReaderSetting *setting = [ADReaderSetting shareInstance];
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.body attributes:setting.readerAttributes];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)att);
    CFRange range = CFRangeMake(0, 0);
    NSUInteger rangeOffset = 0;
    do {
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(rangeOffset, 0), path, NULL);
        range = CTFrameGetVisibleStringRange(frame);
        [rangArr addObject:[NSValue valueWithRange:NSMakeRange(rangeOffset, range.length)]];
        rangeOffset = rangeOffset + range.length;
        if (frame) {
            CFRelease(frame);
        }
    } while (range.length+range.location<att.length);
    
    
    if (path) {
        CFRelease(path);
    }
    
    if (framesetter) {
        CFRelease(framesetter);
    }
    _pageArray = rangArr;
    _pageCount = rangArr.count;
}

- (NSString *)getStringWith:(NSUInteger)page{
    NSRange range = [self getRangeWithPage:page];
    if (range.length > 0) {
        return [_body substringWithRange:range];
    }
    return nil;
}

- (NSRange)getRangeWithPage:(NSUInteger)page{
    if (page < _pageArray.count) {
        return [_pageArray[page] rangeValue];
    }
    return NSMakeRange(NSNotFound, 0);
}

- (NSString *)content{
    if (!_body) {
        return @"暂无数据";
    }
    return [self getStringWith:_index];
}

@end
