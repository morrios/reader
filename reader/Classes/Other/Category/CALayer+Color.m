//
//  CALayer+Color.m
//  reader
//
//  Created by beequick on 2017/9/21.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "CALayer+Color.h"

@implementation CALayer (Color)
- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
