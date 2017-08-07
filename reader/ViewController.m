//
//  ViewController.m
//  reader
//
//  Created by beequick on 2017/8/4.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ViewController.h"
#import "ADPageViewController.h"
#import "ADPageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ADPageViewController *page = [[ADPageViewController alloc] init];
    [self presentViewController:page animated:YES completion:nil];
}

@end
