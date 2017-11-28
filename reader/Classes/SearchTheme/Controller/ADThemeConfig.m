//
//  ADThemeConfig.m
//  reader
//
//  Created by beequick on 2017/10/25.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADThemeConfig.h"


@implementation ADThemeConfig

+ (instancetype)share{
    static ADThemeConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!config) {
            config = [[ADThemeConfig alloc] init];
        }
    });
    return config;
}

- (UIColor *)c1{
    return [UIColor colorWithHexString:@"#313745"];
}

@end
