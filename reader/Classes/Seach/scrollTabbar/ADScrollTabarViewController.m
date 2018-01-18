//
//  ADScrollTabarViewController.m
//  reader
//
//  Created by beequick on 2017/11/16.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADScrollTabarViewController.h"

static NSInteger const baseTag = 879;

@interface ADScrollTabarViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *tabbarScrollview;
@property (nonatomic, strong) UIScrollView *contentScrollview;
@property (nonatomic, strong) UIView *line;
@end

@implementation ADScrollTabarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tabbarScrollview];
    [self.view addSubview:self.contentScrollview];
    NSLog(@"viewdidload");
    if (@available(iOS 11.0, *)) {
        self.tabbarScrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.contentScrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x/self.view.width;
    CGFloat buttonWidth = self.tabbarScrollview.width/self.titles.count;
    [self lineScrollEnd:CGPointMake(buttonWidth*index, 0)];
}
- (void)lineScrollEnd:(CGPoint)offset{
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.line.left = offset.x;
    } completion:nil];
}
#pragma mark - method
- (void)buttonOnClick:(UIButton *)button{
    NSInteger index = button.tag-baseTag;
    CGPoint offset = CGPointMake(index*(self.view.frame.size.width), 0);
    [self.contentScrollview setContentOffset:offset animated:YES];
    CGPoint lineOffset = CGPointMake(index*(self.view.frame.size.width/self.titles.count), 0);
    [self lineScrollEnd:lineOffset];
}

#pragma setter
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    NSLog(@"settitles");
    self.contentScrollview.contentSize = CGSizeMake(self.view.width * titles.count, 0);
    for (int i = 0; i < titles.count; i++) {
        if ([self.delegate ScrollTabar:self ViewForRowAtIndex:i]) {
            CGFloat width = self.contentScrollview.width;
            CGFloat heigth = self.contentScrollview.height;
            CGFloat x = i*width;
            CGFloat y = 0;
            UIView *cell = [self.delegate ScrollTabar:self ViewForRowAtIndex:i];
            cell.frame = CGRectMake(x, y, width, heigth);
            NSLog(@"%@", NSStringFromCGRect(cell.frame));
            [self.contentScrollview addSubview:cell];
        }
    }
   
    [self.tabbarScrollview removeAllSubviews];
    CGFloat buttonWidth = self.tabbarScrollview.width/titles.count;
    CGFloat buttonHeigth = self.tabbarScrollview.height;
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        CGFloat x = i*buttonWidth;
        CGFloat y = 0;
        button.tag = baseTag+i;
        [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(x, y, buttonWidth, buttonHeigth);
        NSLog(@"button = %@", button);
        [self.tabbarScrollview addSubview:button];
    }
    CGFloat lineHeight = 2;
    self.line.frame = CGRectMake(0, self.tabbarScrollview.height-lineHeight, buttonWidth, lineHeight);
    [self.tabbarScrollview addSubview:self.line];
}


- (void)setTabbarTitles:(NSArray *)titles color:(UIColor *)color Font:(UIFont *)font{
    if (titles != nil) {
        [self setTitles:titles];
    }
    if (color != nil) {
        [self setTabbarTitleColor:color];
    }
    if (font != nil) {
        [self setTabbarTitleFont:font];
    }
}
- (void)setTabbarTitleColor:(UIColor *)color{
    [self assertTabbar];
    for (UIView *view in self.tabbarScrollview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:color forState:UIControlStateNormal];
        }
    }
}
- (void)setTabbarTitleFont:(UIFont *)font{
    [self assertTabbar];
    for (UIView *view in self.tabbarScrollview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.titleLabel.font = font;
        }
    }
}
- (void)assertTabbar{
    NSInteger count = self.tabbarScrollview.subviews.count;
    NSCAssert(count != 0, @"titles参数不能为空，必须先设置titles");
}

#pragma mark -  getter
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _contentScrollview.frame = CGRectMake(0, self.tabbarScrollview.frame.size.height, kScreenWidth, self.view.frame.size.height-self.tabbarScrollview.height - self.tabbarScrollview.frame.origin.y);
}
- (UIScrollView *)tabbarScrollview{
    if (!_tabbarScrollview) {
        CGFloat height = 45;
        _tabbarScrollview = [[UIScrollView alloc] init];
        _tabbarScrollview.frame = CGRectMake(0, 0, kScreenWidth, height);
        _tabbarScrollview.backgroundColor = [UIColor whiteColor];
    }
    return _tabbarScrollview;
}
- (UIScrollView *)contentScrollview{
    if (!_contentScrollview) {
        _contentScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.tabbarScrollview.frame.size.height, kScreenWidth, self.view.frame.size.height-self.tabbarScrollview.height - self.tabbarScrollview.frame.origin.y)];
        _contentScrollview.backgroundColor = [UIColor whiteColor];
        _contentScrollview.pagingEnabled = YES;
        _contentScrollview.delegate = self;
//        _contentScrollview.scrollEnabled = NO;
    }
    return _contentScrollview;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#F4D339"];
    }
    return _line;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
