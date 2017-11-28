//
//  ADMenuLightView.m
//  reader
//
//  Created by beequick on 2017/10/12.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADMenuLightView.h"

@implementation ADMenuLightView

+ (instancetype)lightView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ADMenuLightView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    CGFloat width = 15.0;
    UIImage *thumbImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(width, width)];
    thumbImage = [thumbImage imageByRoundCornerRadius:width*0.5];
    [self.lightSider setThumbImage:thumbImage forState:UIControlStateNormal];
    self.lightSider.continuous = YES;
    [self.lightSider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.lightSider.value = [UIScreen mainScreen].brightness;
}

- (void)sliderValueChanged:(id)sender{
    UISlider *slider = (UISlider *)sender;
    NSLog(@"%f", slider.value);
    [[UIScreen mainScreen] setBrightness:slider.value];
}
- (void)setLightValue:(float)value{
    [[UIScreen mainScreen] setBrightness:value];
}

@end
