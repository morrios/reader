//
//  ADRankChildViewController.m
//  reader
//
//  Created by beequick on 2017/11/16.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADRankChildViewController.h"
#import "ADScrollTabarViewController.h"
#import "ADBookListViewController.h"

@interface ADRankChildViewController ()<ADScrollTabarDelegate>
@property (strong, nonatomic) ADScrollTabarViewController *contentVC;
@end

@implementation ADRankChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentVC = [[ADScrollTabarViewController alloc] init];
    [self addChildViewController:self.contentVC];
    self.contentVC.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    [self.view addSubview:self.contentVC.view];
    self.contentVC.delegate = self;
    if (self.type == RankChildTypeRanking) {
        self.contentVC.titles = [@[@"周榜",@"月榜",@"总榜"] copy];
    }else if (self.type == RankChildTypeCategate){
        self.contentVC.titles = [@[@"热门",@"新书",@"好评",@"完结"] copy];
    }
    self.title = self.model.title;
}

- (UIView *)ScrollTabar:(ADScrollTabarViewController *)ScrollTabar ViewForRowAtIndex:(NSInteger)index{
    ADBookListViewController *bookList = [[ADBookListViewController alloc] init];
    switch (index) {
        case 0:
            bookList.listId = self.model._id;
            break;
        case 1:
            bookList.listId = self.model.monthRank;
            break;
        case 2:
            bookList.listId = self.model.totalRank;
            break;
        default:
            break;
    }
    [ScrollTabar addChildViewController:bookList];
    return bookList.view;
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
