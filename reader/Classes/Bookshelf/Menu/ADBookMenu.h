//
//  ADBookMenu.h
//  reader
//
//  Created by beequick on 2017/8/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^showComplete)();
typedef void(^dismissComplete)();

@protocol ADBookMenuDelegate <NSObject>

- (void)goBack;

@end

@interface ADBookMenu : UIView

+ (ADBookMenu *)share;

+ (void)showMenuWithView:(UIView *)myView;
+ (void)showMenuWithView:(UIView *)myView show:(showComplete)showBlock dismiss:(dismissComplete)dismissBlock;
- (void)dismiss;

@property (copy, nonatomic) void(^BottomTapAction)(NSInteger);

@property (nonatomic,weak) id<ADBookMenuDelegate>delegate;

@end
