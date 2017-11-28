//
//  ADSeachViewController.m
//  reader
//
//  Created by beequick on 2017/8/8.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSeachViewController.h"
#import "ADSeachTextFiled.h"
#import "ADSeachDataSouce.h"
#import "ADTableViewDataSouce.h"
#import "ADHistroyTableViewCell.h"
#import "ADListBookModel.h"
#import "ADSeachTagCell.h"
#import "ADSeachDelegate.h"
#import "ADReaderNetWorking.h"
#import "Masonry.h"
#import "SeachBookListTableViewCell.h"
#import "YYModel.h"
#import "ADBooKInfoViewController.h"
#import "ADRecommendCell.h"
#import "ADSearchTask.h"

static NSString *const idHistroyTableviewCell = @"idHistroyTableviewCell";
static NSString *const idSeachListTableviewCell = @"idSeachListTableviewCell";
static NSString *const idSeachCollectionCell = @"idSeachCollectionCell";
static NSString *const idBookListTableviewCell = @"idBookListTableviewCell";

@interface ADSeachViewController ()<UITableViewDelegate,UITableViewDataSource,ADTableViewDelegate,ADSearchTaskDelegate>
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) ADSeachTextFiled *seachTextFiled;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *historyTableview;//d
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *seachListTableView;

@property (nonatomic, strong) NSMutableArray *hotwordDatas;
@property (nonatomic, strong) NSMutableArray *historyDatas;

@property (nonatomic, strong) ADSeachDataSouce *seachDatasouce;//d

@property (nonatomic, strong) ADSeachDelegate *delegateFlowlayout;
@property (nonatomic, strong) ADTableViewDataSouce *historyDataSouce;//d
@property (nonatomic, strong) ADTableViewDataSouce *dataSouce;
@property (nonatomic, strong) ADTableViewDataSouce *seachListDataSouce;
@property (nonatomic, strong) ADSearchTask *searchTask;

@end

@implementation ADSeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索";
    [self.view addSubview:self.seachTextFiled];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.seachListTableView];
    self.searchTask = [[ADSearchTask alloc] init];
    self.searchTask.delegate = self;
    [self reloadDatas];
    [self.seachListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.seachTextFiled.mas_bottom);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadDatas{
    [self reloadHotWords];
}

- (void)reloadHotWords{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD show];
    WeakSelf
    [ADReaderNetWorking seach_KeyWords:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            return;
        }
        NSArray *words = responseObject[@"hotWords"];
        StrongSelf
        [strongSelf.hotwordDatas removeAllObjects];
        [strongSelf.hotwordDatas addObjectsFromArray:words];
        [strongSelf.tableView reloadData];
        
    }];
}

#pragma mark -method

- (void)clearCell:(UITableViewCell*)cell{
    cell.detailTextLabel.text = nil;
    cell.textLabel.text = nil;
    if (cell.imageView.image) {
        cell.imageView.image = [UIImage new];
    }
}
- (void)loadBookDesList:(id)responseObject{
    self.seachListTableView.backgroundColor = [UIColor colorWithHexString:@"#F5F1EC"];
    self.seachListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    NSArray *arrT = [NSArray yy_modelArrayWithClass:[ADListBookModel class] json:responseObject[@"books"]];
    self.seachListDataSouce.cellIdentifier = idBookListTableviewCell;
    self.seachListDataSouce.items = arrT;
    self.seachListDataSouce.rowHeight = 97;
    [self.seachListTableView reloadData];
}

#pragma mark - ADTableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        CGFloat height = 60;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, kScreenWidth, height-20)];
        lable.text = @"搜索历史";
        [view addSubview:lable];
        lable.font = [UIFont boldSystemFontOfSize:15];
        
        return view;
    }
    return nil;
}
-(void)adTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.seachListDataSouce.cellIdentifier isEqualToString:idSeachListTableviewCell]) {
        NSString *word = self.seachListDataSouce.items[indexPath.row];
        WeakSelf
        [ADReaderNetWorking seach_GetBookList:word complete:^(id responseObject, NSError *error) {
            if (error) {
                return ;
            }
            StrongSelf
            [strongSelf.view endEditing:YES];
            [strongSelf loadBookDesList:responseObject];
            
        }];
    }else if ([self.seachListDataSouce.cellIdentifier isEqualToString:idBookListTableviewCell]){
        ADListBookModel *model = self.seachListDataSouce.items[indexPath.row];
        ADBooKInfoViewController *bookInfo = [[ADBooKInfoViewController alloc] init];
        bookInfo.bookid = model._id;
        [self.navigationController pushViewController:bookInfo animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 64;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ADRecommendCell *cell = (ADRecommendCell *)[tableView dequeueReusableCellWithIdentifier:idSeachCollectionCell];
        cell.seachDatasouce.items = [self.hotwordDatas copy];
        cell.delegateFlowlayout.items = [self.hotwordDatas copy];
        cell.delegateFlowlayout.selectBlock = ^(id value) {
            [self SearchTaskValue:@"" responseObject:value];
        };
        [cell.collectionView reloadData];
        return cell;
    }else{
        ADHistroyTableViewCell *cell = (ADHistroyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idHistroyTableviewCell];
        cell.nameLable.text = @"ss";
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.seachListDataSouce.cellIdentifier isEqualToString:idSeachListTableviewCell]) {
        NSString *word = self.seachListDataSouce.items[indexPath.row];
        WeakSelf
        [ADReaderNetWorking seach_GetBookList:word complete:^(id responseObject, NSError *error) {
            if (error) {
                return ;
            }
            StrongSelf
            [strongSelf.view endEditing:YES];
            [strongSelf loadBookDesList:responseObject];
            
        }];
    }else if ([self.seachListDataSouce.cellIdentifier isEqualToString:idBookListTableviewCell]){
        ADListBookModel *model = self.seachListDataSouce.items[indexPath.row];
        ADBooKInfoViewController *bookInfo = [[ADBooKInfoViewController alloc] init];
        bookInfo.bookid = model._id;
        [self.navigationController pushViewController:bookInfo animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }
    return 44;
}

- (void)adScrollViewDidScroll:(UIScrollView *)scrollview{
    [self.view endEditing:YES];
}
#pragma mark - session task
- (void)SearchTaskValue:(id)value responseObject:(id)object{
    NSArray *items = object[@"keywords"];
    if (items.count>0) {
        if (self.seachListTableView.hidden) {
            self.seachListTableView.hidden = NO;
        }
        self.seachListDataSouce.items = object[@"keywords"];
        self.seachListDataSouce.cellIdentifier = idSeachListTableviewCell;
        self.seachListDataSouce.rowHeight = 44;
        [self.seachListTableView reloadData];
    }else{
        self.seachListTableView.hidden = YES;
    }
}

#pragma mark - setter && getter
- (UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollview.top = 50;
    }
    return _scrollview;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.seachTextFiled.bottom, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"ADHistroyTableViewCell" bundle:nil] forCellReuseIdentifier:idHistroyTableviewCell];
        [_tableView registerNib:[UINib nibWithNibName:@"ADRecommendCell" bundle:nil] forCellReuseIdentifier:idSeachCollectionCell];
    }
    return _tableView;
}
- (ADSeachTextFiled *)seachTextFiled{
    if (!_seachTextFiled) {
        _seachTextFiled = [ADSeachTextFiled seachTextFiled];
        WeakSelf
        _seachTextFiled.changeBlock = ^(id responseObject) {
            StrongSelf
            NSArray *items = responseObject[@"keywords"];
            if (items.count>0) {
                if (strongSelf.seachListTableView.hidden) {
                    strongSelf.seachListTableView.hidden = NO;
                }
                strongSelf.seachListDataSouce.items = responseObject[@"keywords"];
                strongSelf.seachListDataSouce.cellIdentifier = idSeachListTableviewCell;
                strongSelf.seachListDataSouce.rowHeight = 44;
                [strongSelf.seachListTableView reloadData];

            }else{
                strongSelf.seachListTableView.hidden = YES;
            }
            
        };
        _seachTextFiled.frame = CGRectMake(0, ADNavBarHeight, kScreenWidth, 50);
    }
    return _seachTextFiled;
}
- (UITableView *)historyTableview{
    if (!_historyTableview) {
        _historyTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.collectionView.bottom, kScreenWidth, 300) style:UITableViewStylePlain];
        TableViewCellConfigureBlock ConfigureBlock = ^(ADHistroyTableViewCell *cell, NSString *item,NSIndexPath *indexpath){
            if ([cell isKindOfClass:[ADHistroyTableViewCell class]]) {
                cell.nameLable.text = item;
            }
            
        };
        self.historyDataSouce = [[ADTableViewDataSouce alloc] initWithCellIdentifier:idHistroyTableviewCell ConfigureCellBlock:ConfigureBlock];
        _historyTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _historyTableview.dataSource = _historyDataSouce;
        _historyTableview.delegate = _historyDataSouce;
        [_historyTableview registerNib:[UINib nibWithNibName:@"ADHistroyTableViewCell" bundle:nil] forCellReuseIdentifier:idHistroyTableviewCell];
    }
    return _historyTableview;
}

- (UITableView *)seachListTableView{
    if (!_seachListTableView) {
        _seachListTableView = [[UITableView alloc] init];
        WeakSelf
        TableViewCellConfigureBlock ConfigureBlock = ^(UITableViewCell *cell, id item, NSIndexPath *indexpath){
            if ([cell.reuseIdentifier isEqualToString:idBookListTableviewCell]) {
                StrongSelf
                [strongSelf clearCell:cell];
                SeachBookListTableViewCell *bookCell = (SeachBookListTableViewCell *)cell;
                bookCell.book = item;
            }else{
                cell.textLabel.text = item;
            }
        };
        _seachListDataSouce = [[ADTableViewDataSouce alloc] initWithCellIdentifier:idSeachListTableviewCell ConfigureCellBlock:ConfigureBlock];
        _seachListDataSouce.delegate = self;
        _seachListDataSouce.rowHeight = 44;
        _seachListTableView.dataSource = _seachListDataSouce;
//        _seachListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _seachListTableView.delegate = _seachListDataSouce;
        [_seachListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:idSeachListTableviewCell];
        [_seachListTableView registerNib:[UINib nibWithNibName:@"SeachBookListTableViewCell" bundle:nil] forCellReuseIdentifier:idBookListTableviewCell];
        _seachListTableView.hidden = YES;
    }
    return _seachListTableView;
}

- (NSMutableArray *)hotwordDatas{
    if (!_hotwordDatas) {
        _hotwordDatas = [NSMutableArray array];
    }
    return _hotwordDatas;
}

- (NSMutableArray *)historyDatas{
    if (!_historyDatas) {
        _historyDatas = [NSMutableArray array];
    }
    return _historyDatas;
}



@end
