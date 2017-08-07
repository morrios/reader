//
//  ADCTFrameParserConfig.m
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADCTFrameParserConfig.h"

@implementation ADCTFrameParserConfig
//初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        _width = 200.f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
    }
    return self;
}
@end
