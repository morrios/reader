//
//  ADPageMenu.m
//  reader
//
//  Created by beequick on 2017/9/19.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADPageMenu.h"
#import "Masonry.h"
#import "UIView+AD.h"

static CGFloat const animateDuration = 0.3;

@interface ADPageMenu ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTopConstraints;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeightContraints;

@property (nonatomic, copy) showComplete showBlock;
@property (nonatomic, copy) dismissComplete dismissBlock;

@end

@implementation ADPageMenu
static inline CGFloat bottomviewHeight(){
    return (100+(ADTabBarHeight_Add));
}
static inline CGFloat fontMenuHeight(){
    return (242+(ADTabBarHeight_Add));
}
static inline CGFloat lightViewHeight(){
    return ADTabBarHeight;
}
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
    self.backgroundColor = [UIColor clearColor];
    NSLog(@"%f",bottomviewHeight());
    self.topViewHeightContraints.constant = (ADNavBarHeight);
    [self.MenuBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.height.mas_equalTo(bottomviewHeight());
        make.bottom.equalTo(self).offset(bottomviewHeight());
    }];
    [self initialHeight];
    [self layoutIfNeeded];

}
- (void)layoutSubviews{
    [super layoutSubviews];
//    self.topViewHeightContraints.constant = ADNavBarHeight;
}
- (void)initialHeight{
    self.topViewTopConstraints.constant = -(ADNavBarHeight);
    [_MenuBottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(bottomviewHeight());
    }];
}
#pragma mark - show
- (void)dismiss{
    [self dismissWithAnimate:YES];
}
- (void)dismissWithAnimate:(BOOL)animate{
    self.dismissBlock();
    if (_fontMenu) {
        [_fontMenu mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(fontMenuHeight());
        }];
    }
    if (_lightView) {
        [_lightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(lightViewHeight());
        }];
    }
    [UIView animateWithDuration:animate?animateDuration:0 animations:^{
        [self initialHeight];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self dismissSecondView];
    }];
}

- (void)show{
    [self dismissSecondView];
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
- (void)dismissSecondView{
    if (_fontMenu) {
        [_fontMenu removeFromSuperview];
        _fontMenu = nil;
    }
    if (_lightView) {
        [_lightView removeFromSuperview];
        _lightView = nil;
    }
}
+ (void)showMenuWithView:(UIView *)myView{
    
    [myView addSubview:[self share]];
    [[self share] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(myView);
    }];
//    [self share].frame = myView.bounds;
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

#pragma mark - secondMenu
- (void)showFontMenu{
    [_MenuBottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(bottomviewHeight());
    }];
    [self.fontMenu mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
    }];
    [self layoutIfNeeded];
}
- (void)showLightView{
    [_MenuBottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(bottomviewHeight());
    }];
    [self.lightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
    }];
    [self layoutIfNeeded];
}


#pragma mark - setter && getter
- (UIView *)MenuBottom{
    if (!_MenuBottom) {
        _MenuBottom = [ADMenuBottom mainView];
        [self addSubview:self.MenuBottom];
        
    }
    return _MenuBottom;
}
- (ADMenuFontView *)fontMenu{
    if (!_fontMenu) {
        _fontMenu = [ADMenuFontView fontView];
        [self addSubview:_fontMenu];
        [_fontMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.height.mas_equalTo(fontMenuHeight());
            make.bottom.equalTo(self).offset(fontMenuHeight());
        }];
    }
    return _fontMenu;
}
- (ADMenuLightView *)lightView{
    if (!_lightView) {
        _lightView = [ADMenuLightView lightView];
        [self addSubview:_lightView];
        [_lightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.height.mas_equalTo(lightViewHeight());
            make.bottom.equalTo(self).offset(lightViewHeight());
        }];
    }
    return _lightView;
}

@end
