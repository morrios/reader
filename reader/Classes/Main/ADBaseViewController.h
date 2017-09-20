//
//  ADBaseViewController.h
//  reader
//
//  Created by beequick on 2017/8/8.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADNavigationController.h"

@interface ADBaseViewController : UIViewController
- (void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg size:(CGSize)size title:(NSString *)title action:(SEL)action;

- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg size:(CGSize)size title:(NSString *)title action:(SEL)action;
@end
