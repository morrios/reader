//
//  ADBaseViewController.m
//  reader
//
//  Created by beequick on 2017/8/8.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADBaseViewController.h"

@interface ADBaseViewController ()

@end

@implementation ADBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg size:(CGSize)size title:(NSString *)title action:(SEL)action
{
    self.navigationItem.rightBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg size:size title:title action:action left:NO];
}

- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg size:(CGSize)size title:(NSString *)title action:(SEL)action
{
    self.navigationItem.leftBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg size:size title:title action:action left:YES];
}
- (UIBarButtonItem *)getButtonItemWithImg:(NSString *)norImg selImg:(NSString *)selImg size:(CGSize)size title:(NSString *)title action:(SEL)action left:(BOOL)left
{
    CGSize navbarSize = self.navigationController.navigationBar.bounds.size;
    CGRect frame = CGRectZero;
    if (size.height>0) {
        frame = CGRectMake(0, 0, size.width, size.height);
    }else{
        frame = CGRectMake(0, 0, navbarSize.height, navbarSize.height);
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    if (norImg)
        [button setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    if (selImg)
        [button setImage:[UIImage imageNamed:selImg] forState:UIControlStateHighlighted];
    if (title) {
        CGSize strSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]}];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [button setTitleColor:RGBA(198, 198, 198, 1) forState:UIControlStateHighlighted];
        frame.size.width = MAX(frame.size.width, strSize.width + 20);
        
        if (left) {
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
        }
        else {
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
        }
    }
    else {
        if (left) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
        }
        else {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
        }
    }
    button.frame = frame;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* tmpBarBtnItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    return tmpBarBtnItem;
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
