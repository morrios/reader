//
//  ADReaderSetting.m
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADReaderSetting.h"
#import "ADCache.h"
@implementation ADBookPageModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _lineSpace = 10;
        _fontSize = 16.0;
        _backViewColor = [UIColor whiteColor];
        _alphaValue = 0.85;
        _textColor = [UIColor blackColor];
        _font = [UIFont systemFontOfSize:_fontSize];
        _unsimplified = NO;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeFloat:self.fontSize forKey:@"fontSize"];
    [aCoder encodeFloat:self.lineSpace forKey:@"lineSpace"];
    [aCoder encodeObject:self.textColor forKey:@"textColor"];
    [aCoder encodeObject:self.fontName forKey:@"fontName"];
    [aCoder encodeObject:self.backViewColor forKey:@"backViewColor"];
    [aCoder encodeFloat:self.alphaValue forKey:@"alphaValue"];
    [aCoder encodeObject:self.font forKey:@"font"];
    [aCoder encodeBool:self.unsimplified forKey:@"unsimplified"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self.fontSize = [aDecoder decodeFloatForKey:@"fontSize"]?[aDecoder decodeFloatForKey:@"fontSize"]:16.0;
    self.lineSpace = [aDecoder decodeFloatForKey:@"lineSpace"]?[aDecoder decodeFloatForKey:@"lineSpace"]:10;
    self.textColor = [aDecoder decodeObjectForKey:@"textColor"]?[aDecoder decodeObjectForKey:@"textColor"]:[UIColor blackColor];
    self.fontName = [aDecoder decodeObjectForKey:@"fontName"];
    self.backViewColor = [aDecoder decodeObjectForKey:@"backViewColor"]?[aDecoder decodeObjectForKey:@"backViewColor"]:[UIColor whiteColor];
    self.alphaValue = [aDecoder decodeFloatForKey:@"alphaValue"]?[aDecoder decodeFloatForKey:@"alphaValue"]:0.85;
    self.font = [aDecoder decodeObjectForKey:@"font"]?[aDecoder decodeObjectForKey:@"font"]:[UIFont systemFontOfSize:self.fontSize];
    self.unsimplified = [aDecoder decodeBoolForKey:@"unsimplified"]?[aDecoder decodeBoolForKey:@"unsimplified"]:NO;
    return self;
    
}
- (void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    if (_fontName) {
        _font = [UIFont fontWithName:_fontName size:fontSize];
    }else{
        _font = [UIFont systemFontOfSize:fontSize];
    }
    [[ADCache share].cache setObject:self forKey:cacheReadSetting];
}
- (void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
    [[ADCache share].cache setObject:self forKey:cacheReadSetting];

}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [[ADCache share].cache setObject:self forKey:cacheReadSetting];

}
- (void)setFontName:(NSString *)fontName{
    _fontName = fontName;
    if ([fontName isEqualToString:aSystemFontName]) {
        _font = [UIFont systemFontOfSize:_fontSize];
    }else{
        _font = [UIFont fontWithName:_fontName size:_fontSize];
    }
    [[ADCache share].cache setObject:self forKey:cacheReadSetting];

}
- (void)setBackViewColor:(UIColor *)backViewColor{
    _backViewColor = backViewColor;
    [[ADCache share].cache setObject:self forKey:cacheReadSetting];

}
- (void)setAlphaValue:(CGFloat)alphaValue{
    _alphaValue = alphaValue;
    [[ADCache share].cache setObject:self forKey:cacheReadSetting];
}
- (void)setUnsimplified:(BOOL)unsimplified{
    _unsimplified = unsimplified;
    [[ADCache share].cache setObject:self forKey:cacheReadSetting];

}

@end
@implementation ADReaderSetting

+(ADReaderSetting *)shareInstance{
    static ADReaderSetting *sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ADReaderSetting alloc] init];
        if ([[ADCache share].cache containsObjectForKey:cacheReadSetting]) {
            sharedInstance.setting = (ADBookPageModel *)[[ADCache share].cache objectForKey:cacheReadSetting];
        }else{
            sharedInstance.setting = [[ADBookPageModel alloc] init];
            [[ADCache share].cache setObject:sharedInstance.setting forKey:cacheReadSetting];
        }
    });
    return sharedInstance;
}


- (NSDictionary *)readerAttributes{
    NSMutableDictionary *dic = @{}.mutableCopy;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = _setting.lineSpace;
    //这种方式两个字符位置更加准确,但是每一页的开始也会空格,但是这不一定是段落的开始
    //    paragraphStyle.firstLineHeadIndent = [@"汉字" boundingRectWithSize:CGSizeMake(200, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:NULL].size.width;
    dic[NSForegroundColorAttributeName] = _setting.textColor;
    dic[NSFontAttributeName] = _setting.font;
    dic[NSParagraphStyleAttributeName] = paragraphStyle;
    _readerAttributes = dic.copy;
    return _readerAttributes;
}

@end

