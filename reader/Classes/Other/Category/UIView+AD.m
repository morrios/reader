//
//  UIView+AD.m
//  reader
//
//  Created by beequick on 2017/9/20.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "UIView+AD.h"

@implementation UIView (AD)
- (CGFloat)tx {
    return self.transform.tx;
}

- (void)setTx:(CGFloat)tx {
    CGAffineTransform transform = self.transform;
    transform.tx = tx;
    self.transform = transform;
}

- (CGFloat)ty {
    return self.transform.ty;
}

- (void)setTy:(CGFloat)ty {
    CGAffineTransform transform = self.transform;
    transform.ty = ty;
    self.transform = transform;
}

- (UIViewController *)presentViewController{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]&&![nextResponder isKindOfClass:[UINavigationController class]]) {
            UIViewController *vc = (UIViewController *)nextResponder;
            return vc;
        }
        
    }
    return nil;
}

@end
