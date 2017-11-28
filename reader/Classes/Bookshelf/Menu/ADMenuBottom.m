//
//  ADMenuBottom.m
//  reader
//
//  Created by beequick on 2017/9/19.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADMenuBottom.h"

static NSInteger const baseTag = 309;

@implementation ADMenuBottom

+ (instancetype)mainView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ADMenuBottom" owner:nil options:nil]lastObject];
}


- (void)awakeFromNib{
    [super awakeFromNib];
    CGFloat width = 15.0;
    UIImage *thumbImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(width, width)];
    thumbImage = [thumbImage imageByRoundCornerRadius:width*0.5];
    [self.sliderView setThumbImage:thumbImage forState:UIControlStateNormal];
    self.sliderView.continuous = NO;
    [self.sliderView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    int btnNum = 5;
    CGFloat btnWidth = kScreenWidth/btnNum;
    CGFloat btnHeight = 50;
    CGFloat iconWidth = 25;
    CGFloat leading = (btnWidth - iconWidth)*0.5;
    self.lastChapterLeading.constant = leading;
    self.nextChapterTrailing.constant = leading;
    
    NSArray *images = @[@"reading_menu_catalog",@"reading_menu_font",@"reading_menu_light",@"reading_menu_download_normal",@"reading_menu_more"];
    for (int i = 0; i<btnNum; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(btnWidth*i, 0, btnWidth, btnHeight);
        button.tag = baseTag + i;
        [button addTarget:self action:@selector(menuBottonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.aboveView addSubview:button];
    }
    self.MinValue = 1;
    self.MaxValue = 2;
    self.CurrentValue = 1;
}


- (void)menuBottonOnClick:(UIButton *)button{
    if ([self.bottomDelegate respondsToSelector:@selector(MenuBottomButtonAction:)]) {
        NSInteger tag = button.tag -  baseTag;
        TapActionType type = TapActionTypeChapters;
        switch (tag) {
            case 0:
                type = TapActionTypeChapters;
                break;
            case 1:
                type = TapActionTypeFont;
                break;
            case 2:
                type = TapActionTypeDark;
                break;
            case 3:
                type = TapActionTypeDownLoad;
                break;
            case 4:
                type = TapActionTypeMore;
                break;
            default:
                break;
        }
        [self.bottomDelegate MenuBottomButtonAction:type];
    }
   
}

- (IBAction)preChapterOnCLick:(id)sender {
    if ([self.bottomDelegate respondsToSelector:@selector(MenuBottomChapterActionType:)]) {
        [self.bottomDelegate MenuBottomChapterActionType:ChapterActionTypePre];
    }
    
}
- (IBAction)nextChapterOnCLick:(id)sender {
    if ([self.bottomDelegate respondsToSelector:@selector(MenuBottomChapterActionType:)]) {
        [self.bottomDelegate MenuBottomChapterActionType:ChapterActionTypeNext];
    }
}

- (void)sliderValueChanged:(id)sender{
    UISlider *slider = (UISlider *)sender;
    NSLog(@"slider = %@, slider.value = %f,int = %d",slider,slider.value, (int)slider.value);
    if ([self.bottomDelegate respondsToSelector:@selector(MenuBottomValueChange:)]) {
        [self.bottomDelegate MenuBottomValueChange:(NSUInteger)slider.value];
    }
}

#pragma mark - setter && getter

- (void)setMaxValue:(NSUInteger)MaxValue{
    _MaxValue = MaxValue;
    [self.sliderView setMaximumValue:(float)MaxValue];
}

- (void)setCurrentValue:(NSUInteger)CurrentValue{
    _CurrentValue = CurrentValue;
    [self.sliderView setValue:(float)CurrentValue];
}



@end
