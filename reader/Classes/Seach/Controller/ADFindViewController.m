//
//  ADFindViewController.m
//  reader
//
//  Created by beequick on 2017/11/14.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADFindViewController.h"
#import "ADFindTableViewCell.h"
#import "AACategateViewController.h"
#import "ADRankViewController.h"

static NSString *idcell = @"idcell";
@interface ADFindViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation ADFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableview];
    self.title = @"找书";
}
#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * iconName = [@[@"d_ranking",@"d_cate"] copy];
    NSArray * titles = [@[@"排行榜",@"分类"] copy];
    ADFindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idcell];
    cell.iconView.image = [UIImage imageNamed:iconName[indexPath.row]];
    cell.titleString = titles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ADRankViewController *rank = [[ADRankViewController alloc] init];
        [self.navigationController pushViewController:rank animated:YES];
    }else if (indexPath.row == 1) {
        AACategateViewController *category = [[AACategateViewController alloc] init];
        [self.navigationController pushViewController:category animated:YES];
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
        [_tableview registerNib:[UINib nibWithNibName:@"ADFindTableViewCell" bundle:nil] forCellReuseIdentifier:idcell];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
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
