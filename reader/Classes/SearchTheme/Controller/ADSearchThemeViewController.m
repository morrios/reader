//
//  ADSearchThemeViewController.m
//  reader
//
//  Created by beequick on 2017/10/24.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSearchThemeViewController.h"
#import "ADBookDetailViewController.h"
#import "ADSearchHeadView.h"
#import "ADTableViewDataSouce.h"
#import "ADSeachThemeListTableViewCell.h"
#import "ADSearchBookListCell.h"
#import "ADSearchTask.h"
#import "ADThemeConfig.h"
#import "ADReaderNetWorking.h"
#import "ADListBookModel.h"
#import "YYModel.h"



static NSString *const idSearchListCell = @"idSearchListCell";
static NSString *const idSearchBookListCell = @"idSearchBookListCell";

@interface ADSearchThemeViewController ()<ADTableViewDelegate,ADSearchTaskDelegate>
@property (nonatomic, strong) UITableView *seachListTableView;
@property (nonatomic, strong) ADTableViewDataSouce *seachListDataSouce;
@property (nonatomic, strong) NSMutableArray *keyWords;
@property (nonatomic, strong) NSMutableArray *books;
@property (nonatomic, strong) ADSearchHeadView *searchHeadView;
@property (nonatomic, strong) ADSearchTask *searchTask;
@end

@implementation ADSearchThemeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchTask = [[ADSearchTask alloc] init];
    self.searchTask.delegate = self;
    [self.view addSubview:self.seachListTableView];
    if (@available(iOS 11.0, *)) {
        self.seachListTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)headView{
    
}
#pragma mark - delegate
- (void)adTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_seachListDataSouce.cellIdentifier isEqualToString:idSearchListCell]) {
        NSString *word = self.seachListDataSouce.items[indexPath.row];
        WeakSelf
        tableView.userInteractionEnabled = NO;
        [SVProgressHUD showWithStatus:@"搜索..."];
        [ADReaderNetWorking seach_GetBookList:word complete:^(id responseObject, NSError *error) {
            tableView.userInteractionEnabled = YES;
            [SVProgressHUD dismiss];
            if (error) {
                return ;
            }
            StrongSelf
            [strongSelf.view endEditing:YES];
            [strongSelf loadBookDesList:responseObject];
            
        }];
    }else if ([_seachListDataSouce.cellIdentifier isEqualToString:idSearchBookListCell]){
        ADBookDetailViewController *detail = [ADBookDetailViewController new];
        ADListBookModel *model = _seachListDataSouce.items[indexPath.row];
        detail.bookid = model._id;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
- (CGFloat)adTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_seachListDataSouce.cellIdentifier isEqualToString:idSearchBookListCell]) {
        return [self.books[indexPath.row] floatValue];
    }else{
        return 44;
    }
}
#pragma mark - method
- (void)loadBookDesList:(id)responseObject{
    NSArray *arrT = [NSArray yy_modelArrayWithClass:[ADListBookModel class] json:responseObject[@"books"]];
    _seachListDataSouce.cellIdentifier = idSearchBookListCell;
    _seachListDataSouce.items = [arrT copy];
    [self countBookCellHeight:arrT];
    _seachListTableView.hidden = NO;
    _seachListTableView.backgroundColor = [UIColor whiteColor];
    [_seachListTableView reloadData];
}

- (void)countBookCellHeight:(NSArray *)arrt{
    [self.books removeAllObjects];
    for (ADListBookModel *model in arrt) {
        CGFloat height = [self transformRect:model];
        [self.books addObject:[NSNumber numberWithFloat:height]];
    }
}

- (CGFloat)transformRect:(ADListBookModel *)model{
    CGFloat padding = 20;
    CGFloat height = [model.shortIntro heightForFont:[UIFont systemFontOfSize:12] width:(kScreenWidth - padding*2)];
    CGFloat desY = 90;
    CGFloat desBottomPadding = 40;
    CGFloat cellHeight = height+desY+desBottomPadding;
    return cellHeight;
}
#pragma mark - setter && getter
- (UITableView *)seachListTableView{
    if (!_seachListTableView) {
        CGRect frame =  CGRectMake(0, self.searchHeadView.bottom, kScreenWidth, kScreenHeight - self.searchHeadView.height);
        _seachListTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        TableViewCellConfigureBlock ConfigureBlock = ^(UITableViewCell *cell, id item, NSIndexPath *indexpath){
            if ([cell.reuseIdentifier isEqualToString:idSearchListCell]) {
                NSLog(@"ADSeachThemeListTableViewCell");
                ADSeachThemeListTableViewCell *celln = (ADSeachThemeListTableViewCell *)cell;
                celln.bookNameL.text = item;
            }else{
                NSLog(@"ADSearchBookListCell");
                ADSearchBookListCell *celln = (ADSearchBookListCell *)cell;
                celln.book = item;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        };
        _seachListTableView.backgroundColor = [[ADThemeConfig share] c1];
        _seachListDataSouce = [[ADTableViewDataSouce alloc] initWithCellIdentifier:idSearchListCell ConfigureCellBlock:ConfigureBlock];
        _seachListDataSouce.items = self.keyWords;
        _seachListDataSouce.delegate = self;
        _seachListDataSouce.rowHeight = 44;
        
        _seachListTableView.dataSource = _seachListDataSouce;
        _seachListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _seachListTableView.delegate = _seachListDataSouce;
        [_seachListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:idSearchListCell];
        [_seachListTableView registerNib:[UINib nibWithNibName:@"ADSeachThemeListTableViewCell" bundle:nil] forCellReuseIdentifier:idSearchListCell];
        [_seachListTableView registerNib:[UINib nibWithNibName:@"ADSearchBookListCell" bundle:nil] forCellReuseIdentifier:idSearchBookListCell];
        _seachListTableView.bounces = NO;
        _seachListTableView.hidden = YES;
//        _seachListTableView.tableHeaderView = self.searchHeadView;
    }
    return _seachListTableView;
}

- (ADSearchHeadView *)searchHeadView{
    if (!_searchHeadView) {
        _searchHeadView = [ADSearchHeadView searchHeadView];
        _searchHeadView.frame = CGRectMake(0, 0, kScreenWidth, 167);
        [self.view addSubview:_searchHeadView];
        WeakSelf
        _searchHeadView.changeBlock = ^(id value) {
            StrongSelf
            NSArray *items = value[@"keywords"];
            [strongSelf.keyWords removeAllObjects];
            [strongSelf.keyWords addObjectsFromArray:items];
            strongSelf.seachListDataSouce.items = items;
            strongSelf.seachListDataSouce.cellIdentifier = idSearchListCell;
            strongSelf.seachListDataSouce.rowHeight = 44;
            if (items.count>0) {
                strongSelf.seachListTableView.hidden = NO;
                strongSelf.seachListTableView.backgroundColor = [[ADThemeConfig share] c1];
                [strongSelf.searchHeadView itemsChanges:YES];
                [strongSelf.searchHeadView itemsChanges:YES];
            }else{
                [strongSelf.searchHeadView itemsChanges:NO];
                strongSelf.seachListTableView.hidden = YES;
                [strongSelf.searchHeadView itemsChanges:NO];
            }
            [strongSelf.seachListTableView reloadData];
        };
        _searchHeadView.cancleBlock = ^{
            StrongSelf
            [strongSelf.keyWords removeAllObjects];
            strongSelf.seachListDataSouce.items = strongSelf.keyWords;
            [strongSelf.searchHeadView itemsChanges:NO];
            strongSelf.seachListTableView.hidden = YES;
            [strongSelf.seachListTableView reloadData];
        };
    }
    return _searchHeadView;
}
- (NSMutableArray *)keyWords{
    if (!_keyWords) {
        _keyWords = [NSMutableArray array];
    }
    return _keyWords;
}
- (NSMutableArray *)books{
    if (!_books) {
        _books = [NSMutableArray array];
    }
    return _books;
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
