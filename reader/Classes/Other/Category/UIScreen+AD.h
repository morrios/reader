//
//  UIScreen+AD.h
//  reader
//
//  Created by beequick on 2017/10/24.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (AD)
//保存之前的光亮值
+ (void)AD_SaveScreenLightValue;
//恢复之前的光亮值
+ (void)AD_ReinstateScreenLightValue;

@end
