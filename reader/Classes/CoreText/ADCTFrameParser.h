//
//  ADCTFrameParser.h
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADCTFrameParserConfig.h"
#import "ADCoreTextData.h"
#import "ADDisplayView.h"

@interface ADCTFrameParser : NSObject
/**
 *  给内容设置配置信息
 *
 *  @param content 内容
 *  @param config  配置信息
 *
 */
+(ADCoreTextData *)parseContent:(NSString *)content config:(ADCTFrameParserConfig *)config;
@end
