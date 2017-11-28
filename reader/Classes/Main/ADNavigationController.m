//
//  ADNavigationController.m
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADNavigationController.h"


@interface ADNavigationController ()<UINavigationControllerDelegate>

@end

@implementation ADNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationBar.translucent = YES;
}


///重写push方法 push的控制器隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 隐藏tabbar
    viewController.hidesBottomBarWhenPushed =YES;
    
    //1.添加后退按钮
    [self addBackButton:viewController];
    
    [super pushViewController:viewController animated:animated];
}



//2 自定义后退按钮
- (void)addBackButton:(UIViewController *)viewController {
    
    //开启手势后退
    //    self.interactivePopGestureRecognizer.delegate = (id)self;
    //开启手势滑动后退
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
    //间距
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -20;
    
    viewController.navigationItem.leftBarButtonItems =@[fixed,back];
}

//点击后退的时候执行的方法
- (void)backClick {
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
