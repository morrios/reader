//
//  ADMenuLightView.h
//  reader
//
//  Created by beequick on 2017/10/12.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADMenuLightView : UIView
@property (weak, nonatomic) IBOutlet UISlider *lightSider;
+ (instancetype)lightView;
- (void)setLightValue:(float)value;
@end
