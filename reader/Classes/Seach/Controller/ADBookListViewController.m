//
//  ADBookListViewController.m
//  reader
//
//  Created by beequick on 2017/11/16.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADBookListViewController.h"
#import "ADTableViewDataSouce.h"
#import "SeachBookListTableViewCell.h"
#import "ADReaderNetWorking.h"
#import "ADRankingListModel.h"
#import "ADBookDetailViewController.h"

static NSString * const idcell = @"idcell";

@interface ADBookListViewController ()<ADTableViewDelegate>
@property (nonatomic, strong) ADTableViewDataSouce *datasource;
@property (nonatomic, strong) ADRankingListModel *model;
@end

@implementation ADBookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.model = [[ADRankingListModel alloc] init];
    [self.view addSubview:self.tableview];
    [self loadDatas];
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableview.frame = self.view.bounds;
}
- (void)loadDatas{
    WeakSelf
    [ADReaderNetWorking Rank_getRankListId:self.listId complete:^(id responseObject, NSError *error) {
        ADRankingListModel *model = [ADRankingListModel yy_modelWithDictionary:responseObject[@"ranking"]];
        weakSelf.model = model;
        _datasource.items = model.books;
        [weakSelf.tableview reloadData];
    }];
}
- (void)adTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ADListBookModel *book = self.datasource.items[indexPath.row];
    ADBookDetailViewController *info = [[ADBookDetailViewController alloc] init];
    info.bookid = book._id;
    [self.navigationController pushViewController:info animated:YES];
}
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableview.dataSource = self.datasource;
        _tableview.delegate = self.datasource;
        [_tableview registerNib:[UINib nibWithNibName:@"SeachBookListTableViewCell" bundle:nil] forCellReuseIdentifier:idcell];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (ADTableViewDataSouce *)datasource{
    if (!_datasource) {
        _datasource = [[ADTableViewDataSouce alloc] initWithCellIdentifier:idcell ConfigureCellBlock:^(id cell, id item, NSIndexPath *indexpath) {
            SeachBookListTableViewCell *newcell = (SeachBookListTableViewCell *)cell;
            [newcell setCellMainColor:[UIColor whiteColor]];
            newcell.book = item;
            newcell.selectionStyle = UITableViewCellSelectionStyleNone;
        }];
        _datasource.rowHeight = 97;
        _datasource.delegate = self;
        _datasource.items = self.model.books;
    }
    return _datasource;
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
