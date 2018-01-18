//
//  UIColor+additions.m
//  daheidou
//
//  Created by adu on 15/7/15.
//  Copyright (c) 2015年 adu. All rights reserved.
//

#import "UIColor+additions.h"

@implementation UIColor (additions)
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark - 常用色系
/**
 *  主色系
 */
+ (UIColor *)ca{
    return [self hexStringToColor:@"#FD9526"];
}
/**
 *  默认背景颜色
 */
+ (UIColor *)cb{
    return [self hexStringToColor:@"#F5F5F5"];
}

+ (UIColor *)c1{
    return [self hexStringToColor:@"#2e333a"];
}

+ (UIColor *)c2{
    return [self hexStringToColor:@"#727b88"];
}

+ (UIColor *)c3{
    return [self hexStringToColor:@"#b7bdc6"];
}

+ (UIColor *)c4{
    return [self hexStringToColor:@"#d1d9e4"];
}

+ (UIColor *)c5{
    return [self hexStringToColor:@"#dbe0e8"];
}

+ (UIColor *)c6{
    return [self hexStringToColor:@"#ebeff5"];
}

+ (UIColor *)c7{
    return [self hexStringToColor:@"#f2f5f8"];
}

+ (UIColor *)c8{
    return [self hexStringToColor:@"#ffffff"];
}



@end
