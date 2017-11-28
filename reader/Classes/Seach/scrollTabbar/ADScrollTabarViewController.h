//
//  ADScrollTabarViewController.h
//  reader
//
//  Created by beequick on 2017/11/16.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ADScrollTabarViewController;
@protocol ADScrollTabarDelegate
- (UIView *)ScrollTabar:(ADScrollTabarViewController *)ScrollTabar ViewForRowAtIndex:(NSInteger)index;

@end

@interface ADScrollTabarViewController : UIViewController
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<ADScrollTabarDelegate>delegate;

- (void)setTabbarTitleColor:(UIColor *)color;
- (void)setTabbarTitleFont:(UIFont *)font;
- (void)setTabbarTitles:(NSArray *)titles color:(UIColor *)color Font:(UIFont *)font;

@end
