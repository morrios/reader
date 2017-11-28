//
//  ADRankViewController.m
//  reader
//
//  Created by beequick on 2017/11/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADRankViewController.h"
#import "ADRankTableViewCell.h"
#import "ADReaderNetWorking.h"
#import "ADRanking.h"
#import "YYModel.h"
#import "ADRankTableViewHeadView.h"
#import "ADRankChildViewController.h"
static NSString *idcell = @"idcell";
static NSString *idHeadcell = @"idHeadcell";
static NSInteger const numL = 6;
@interface ADRankViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) ADRanking *model;
@property (nonatomic, assign) BOOL firstUnfurled;
@property (nonatomic, assign) BOOL secondUnfurled;

@end

@implementation ADRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableview];
    self.firstUnfurled = NO;
    self.secondUnfurled = NO;
    [self loadDatas];
}
- (void)loadDatas{
    [SVProgressHUD showWithStatus:@"加载中"];
    WeakSelf
    [ADReaderNetWorking Search_getAllRanking:^(id responseObject, NSError *error) {
        if (error != nil) {
            [SVProgressHUD showErrorWithStatus:@"网络加载错误"];
        }
        [SVProgressHUD dismiss];
        NSLog(@"%@", responseObject);
        ADRanking *model = [[ADRanking alloc] initWithDictionary:responseObject];
        ADStoreRanking *insertM = [[ADStoreRanking alloc] init];
        insertM.title = @"别人家的排行榜";
        [model.female insertObject:insertM atIndex:(numL-1)];
        [model.male insertObject:insertM atIndex:(numL-1)];
        weakSelf.model = model;
        [weakSelf.tableview reloadData];
    }];
}
#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = numL;
    NSArray *ranks = (section==0)?self.model.male:self.model.female;
    if (self.firstUnfurled && section==0) {
        count = ranks.count;
    }
    if (self.secondUnfurled && section==1) {
        count = ranks.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSArray * iconName = [@[@"淘小说最热榜 Top100",@"d_cate"] copy];
    NSArray *ranks = (indexPath.section==0)?self.model.male:self.model.female;
    ADStoreRanking *model = ranks[indexPath.row];
    ADRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idcell];
    cell.titleL.text = model.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    if (indexPath.row == (numL - 1)) {
        cell.downArrowV.hidden = NO;
        cell.iconV.image = [UIImage imageNamed:@"ranking_other"];
    }else{
        cell.downArrowV.hidden = YES;
         cell.iconUrlString = model.cover;
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ADRankTableViewHeadView *headView = [ADRankTableViewHeadView headView];
    headView.titleL.text = (section==0)?@"男生":@"女生";
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 56;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == (numL - 1)) {
        if (indexPath.section == 0) {
            self.firstUnfurled = !self.firstUnfurled;
        }else{
            self.secondUnfurled = !self.secondUnfurled;
        }
        [tableView reloadData];
    }else{
        NSArray *ranks = (indexPath.section==0)?self.model.male:self.model.female;
        ADStoreRanking *model = ranks[indexPath.row];
        ADRankChildViewController *rank = [[ADRankChildViewController alloc] init];
        rank.model = model;
        [self.navigationController pushViewController:rank animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerNib:[UINib nibWithNibName:@"ADRankTableViewCell" bundle:nil] forCellReuseIdentifier:idcell];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    }
    return _tableview;
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
