//
//  UIColor+additions.h
//  daheidou
//
//  Created by adu on 15/7/15.
//  Copyright (c) 2015年 adu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (additions)
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark - 常用色系
+ (UIColor *)ca;
+ (UIColor *)cb;
+ (UIColor *)c1;
+ (UIColor *)c2;
+ (UIColor *)c3;
+ (UIColor *)c4;
+ (UIColor *)c5;
+ (UIColor *)c6;
+ (UIColor *)c7;
+ (UIColor *)c8;

@end
