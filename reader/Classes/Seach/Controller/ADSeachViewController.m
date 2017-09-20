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

static NSString *const idCollectionViewCell = @"idCollectionViewCell";
static NSString *const idHistroyTableviewCell = @"idHistroyTableviewCell";
static NSString *const idSeachListTableviewCell = @"idSeachListTableviewCell";
static NSString *const idBookListTableviewCell = @"idBookListTableviewCell";

@interface ADSeachViewController ()<ADTableViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) ADSeachTextFiled *seachTextFiled;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *historyTableview;
@property (nonatomic, strong) UITableView *seachListTableView;

@property (nonatomic, strong) NSMutableArray *hotwordDatas;
@property (nonatomic, strong) NSMutableArray *historyDatas;
@property (nonatomic, strong) NSArray *colorArr;

@property (nonatomic, strong) ADSeachDataSouce *seachDatasouce;
@property (nonatomic, strong) ADSeachDelegate *delegateFlowlayout;
@property (nonatomic, strong) ADTableViewDataSouce *historyDataSouce;
@property (nonatomic, strong) ADTableViewDataSouce *seachListDataSouce;

@end

@implementation ADSeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索";
    [self setColorArray];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.seachTextFiled];
    [self.scrollview addSubview:self.collectionView];
    [self.scrollview addSubview:self.historyTableview];
    [self.view addSubview:self.seachListTableView];
    
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
        strongSelf.seachDatasouce.items = words;
        strongSelf.delegateFlowlayout.items = words;
        [strongSelf.collectionView reloadData];
        
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
    NSArray *arrT = [NSArray yy_modelArrayWithClass:[ADListBookModel class] json:responseObject[@"books"]];
    self.seachListDataSouce.cellIdentifier = idBookListTableviewCell;
    self.seachListDataSouce.items = arrT;
    self.seachListDataSouce.rowHeight = 97;
    [self.seachListTableView reloadData];
}

#pragma mark - ADTableViewDelegate
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

- (void)adScrollViewDidScroll:(UIScrollView *)scrollview{
    [self.view endEditing:YES];
}

#pragma mark - setter && getter
- (UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollview.top = 50;
    }
    return _scrollview;
}

- (ADSeachTextFiled *)seachTextFiled{
    if (!_seachTextFiled) {
        _seachTextFiled = [ADSeachTextFiled seachTextFiled];
        WeakSelf
        _seachTextFiled.changeBlock = ^(id responseObject, NSError *errpr) {
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
                strongSelf.seachListTableView.backgroundColor = [UIColor colorWithHexString:@"#F5F1EC"];

            }else{
                strongSelf.seachListTableView.hidden = YES;
            }
            
        };
        _seachTextFiled.frame = CGRectMake(0, 64, kScreenWidth, 50);
    }
    return _seachTextFiled;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) collectionViewLayout:flowLayout];
        
        CollectionViewCellConfigureBlock block = ^(ADSeachTagCell *cell, NSString *name, NSIndexPath *indexpath){
            cell.keyword = name;
            NSInteger index = indexpath.row % 6;
            cell.backgroundColor = self.colorArr[index];
        };
        self.seachDatasouce = [[ADSeachDataSouce alloc] initWithItems:self.hotwordDatas cellIdentifier:idCollectionViewCell configureCellBlock:block];
        _collectionView.dataSource = _seachDatasouce;
        
        self.delegateFlowlayout = [[ADSeachDelegate alloc] initWithItems:self.hotwordDatas];
        _collectionView.delegate = self.delegateFlowlayout;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"ADSeachTagCell" bundle:nil] forCellWithReuseIdentifier:idCollectionViewCell];
        
    }
    return _collectionView;
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

- (void)setColorArray{
    UIColor *color1 = [UIColor colorWithHexString:@"#92C6EE"];
    UIColor *color2 = [UIColor colorWithHexString:@"#BE6CCE"];
    UIColor *color3 = [UIColor colorWithHexString:@"#F4BB82"];
    UIColor *color4 = [UIColor colorWithHexString:@"#93CED4"];
    UIColor *color5 = [UIColor colorWithHexString:@"#6BCBB7"];
    UIColor *color6 = [UIColor colorWithHexString:@"#E58F90"];
    if (!_colorArr) {
        _colorArr = [NSArray arrayWithObjects:color1,color2,color3,color4,color5,color6, nil];
    }
}

@end
