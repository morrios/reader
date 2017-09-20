//
//  ADBookMenu.m
//  reader
//
//  Created by beequick on 2017/8/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADBookMenu.h"
#import "ADBottomButton.h"

static CGFloat const topviewTop = -94;
static CGFloat const bottomviewBottom = -54;
static CGFloat const animateDuration = 0.3;

@interface ADBookMenu ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTopConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomConstraints;

@property (nonatomic, copy) showComplete showBlock;
@property (nonatomic, copy) dismissComplete dismissBlock;
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation ADBookMenu

+ (ADBookMenu *)share{
    static ADBookMenu *menu = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menu = [[[NSBundle mainBundle] loadNibNamed:@"ADBookMenu" owner:nil options:nil]lastObject];
    });
    return menu;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self ConfigUI];
    
}

#pragma mark - menthod
- (void)ConfigUI{
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *banckViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.backView addGestureRecognizer:banckViewGesture];
    [self initialHeight];
    [self initialBottomView];
}

- (void)initialBottomView{
    self.buttons = [NSMutableArray array];
    NSArray *imgArr = @[@"night_mode",@"feedback",@"directory",@"preview_btn",@"reading_setting"];
    NSArray *titleArr = @[@"夜间",@"反馈",@"目录",@"缓存",@"设置"];
    for (NSInteger i = 0; i < imgArr.count; i++) {
        ADBottomButton *btn = [ADBottomButton bottonWith:titleArr[i] imageName:imgArr[i] tag:i];
        btn.tapAction = self.BottomTapAction;
        [self.bottomView addSubview:btn];
        [self.buttons addObject:btn];
    }
}

- (void)setBottomTapAction:(void (^)(NSInteger))BottomTapAction{
    _BottomTapAction = BottomTapAction;
    [self.buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ADBottomButton *button = (ADBottomButton *)obj;
        button.tapAction = BottomTapAction;
    }];
}

- (void)initialHeight{
    self.topViewTopConstraints.constant = topviewTop;
    self.bottomViewBottomConstraints.constant = bottomviewBottom;
}
- (void)dismiss{
    self.dismissBlock();
    [UIView animateWithDuration:animateDuration animations:^{
        [self initialHeight];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}


- (void)show{
    [UIView animateWithDuration:animateDuration animations:^{
        self.topViewTopConstraints.constant = 0;
        self.bottomViewBottomConstraints.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.showBlock();
    }];
}


- (IBAction)cancleButtonOnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(goBack)]) {
        [self.delegate goBack];
    }
}
+ (void)showMenuWithView:(UIView *)myView show:(showComplete)showBlock dismiss:(dismissComplete)dismissBlock{
    [self share].showBlock = showBlock;
    [self showMenuWithView:myView];
    [self share].dismissBlock = dismissBlock;
}

+ (void)showMenuWithView:(UIView *)myView{
    
    [myView addSubview:[self share]];
    [self share].frame = myView.bounds;
    [[self share] show];
    
}


@end
