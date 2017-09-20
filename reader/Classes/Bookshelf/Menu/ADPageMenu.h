//
//  ADPageMenu.h
//  reader
//
//  Created by beequick on 2017/9/19.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADMenuBottom.h"

typedef void(^showComplete)();
typedef void(^dismissComplete)();


@protocol ADPageMenuDelegate <NSObject>

- (void)goBack;
//BottomTapAction
@end
@interface ADPageMenu : UIView
+ (ADPageMenu *)share;

+ (void)showMenuWithView:(UIView *)myView;
+ (void)showMenuWithView:(UIView *)myView show:(showComplete)showBlock dismiss:(dismissComplete)dismissBlock;
- (void)dismissWithAnimate:(BOOL)animate;

- (void)dismiss;

@property (copy, nonatomic) void(^BottomTapAction)(NSInteger);
@property (nonatomic, strong) ADMenuBottom *MenuBottom;


@property (nonatomic,weak) id<ADPageMenuDelegate>delegate;

@end
