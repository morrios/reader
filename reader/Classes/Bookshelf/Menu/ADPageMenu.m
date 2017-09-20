//
//  ADPageMenu.m
//  reader
//
//  Created by beequick on 2017/9/19.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADPageMenu.h"
#import "Masonry.h"

static CGFloat const topviewTop = 64;
static CGFloat const bottomviewBottom = 100;
static CGFloat const animateDuration = 0.3;
@interface ADPageMenu ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTopConstraints;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (nonatomic, copy) showComplete showBlock;
@property (nonatomic, copy) dismissComplete dismissBlock;

@end

@implementation ADPageMenu
+ (ADPageMenu *)share{
    static ADPageMenu *menu = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menu = [[[NSBundle mainBundle] loadNibNamed:@"ADPageMenu" owner:nil options:nil]lastObject];
    });
    return menu;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self ConfigUI];
}
- (void)ConfigUI{
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *banckViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.backView addGestureRecognizer:banckViewGesture];
    [self initialHeight];
    self.backgroundColor = [UIColor clearColor];
    CGFloat bottomHeight = 100.0;
    [self.MenuBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.height.mas_equalTo(bottomHeight);
        make.bottom.equalTo(self).offset(bottomviewBottom);
    }];
    [self layoutIfNeeded];

}
- (void)initialHeight{
    self.topViewTopConstraints.constant = -topviewTop;
    [_MenuBottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(bottomviewBottom);
    }];
}
#pragma mark - show
- (void)dismiss{
//    self.dismissBlock();
//    [UIView animateWithDuration:animateDuration animations:^{
//        [self initialHeight];
//        [self layoutIfNeeded];
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        
//    }];
    [self dismissWithAnimate:YES];
}
- (void)dismissWithAnimate:(BOOL)animate{
    self.dismissBlock();
    [UIView animateWithDuration:animate?animateDuration:0 animations:^{
        [self initialHeight];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

- (void)show{
    [UIView animateWithDuration:animateDuration animations:^{
        self.topViewTopConstraints.constant = 0;
        [_MenuBottom mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.showBlock();
    }];
}

+ (void)showMenuWithView:(UIView *)myView{
    
    [myView addSubview:[self share]];
    [self share].frame = myView.bounds;
    [[self share] show];
}

+ (void)showMenuWithView:(UIView *)myView show:(showComplete)showBlock dismiss:(dismissComplete)dismissBlock{
    [self share].showBlock = showBlock;
    [self showMenuWithView:myView];
    [self share].dismissBlock = dismissBlock;
}

- (IBAction)backAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(goBack)]) {
        [self.delegate goBack];
    }
}
#pragma mark - setter && getter
- (UIView *)MenuBottom{
    if (!_MenuBottom) {
        _MenuBottom = [ADMenuBottom mainView];
        [self addSubview:self.MenuBottom];
        
    }
    return _MenuBottom;
}

@end
