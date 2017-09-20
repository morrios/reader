//
//  ADReaderSetting.m
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADReaderSetting.h"

@implementation ADReaderSetting

+(instancetype)shareInstance{
    static ADReaderSetting *sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ADReaderSetting alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _lineSpace = 10;
        _fontSize = 16.0;
        _font = [UIFont systemFontOfSize:_fontSize];
    }
    return self;
}

- (NSDictionary *)readerAttributes{
    if (!_readerAttributes) {
        NSMutableDictionary *dic = @{}.mutableCopy;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = self.lineSpace;
        //这种方式两个字符位置更加准确,但是每一页的开始也会空格,但是这不一定是段落的开始
        //    paragraphStyle.firstLineHeadIndent = [@"汉字" boundingRectWithSize:CGSizeMake(200, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:NULL].size.width;
        dic[NSForegroundColorAttributeName] = self.textColor;
        dic[NSFontAttributeName] = self.font;
        dic[NSParagraphStyleAttributeName] = paragraphStyle;
        _readerAttributes = dic.copy;
        return _readerAttributes;
    }
    return _readerAttributes;
}

@end
