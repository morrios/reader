//
//  UIScreen+AD.m
//  reader
//
//  Created by beequick on 2017/10/24.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "UIScreen+AD.h"
#import "ADPageMenu.h"

static NSString *const ADLightKey = @"ADUserLightValue";

@implementation UIScreen (AD)
+ (void)AD_SaveScreenLightValue{
    [[NSUserDefaults standardUserDefaults] setFloat:[UIScreen mainScreen].brightness forKey:ADLightKey];
}
+ (void)AD_ReinstateScreenLightValue{
    float value = [[NSUserDefaults standardUserDefaults] floatForKey:ADLightKey];
    [[ADPageMenu share].lightView setLightValue:value];
}
@end
