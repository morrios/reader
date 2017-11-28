//
//  ADBookshelfViewController.m
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADBookshelfViewController.h"
#import "ADPageViewController.h"
#import "ADSeachViewController.h"
#import "ADTableViewDataSouce.h"
#import "NSString+AD.h"
#import "ADShelfTableViewCell.h"
#import "ADReaderNetWorking.h"
#import "ADSherfModel.h"
#import "YYModel.h"
#import "UIImageView+WebCache.h"
#import "ADSherfCache.h"
#import "ADSearchThemeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ADCacheManger.h"

static NSString *const idcell = @"idcell";

@interface ADBookshelfViewController ()<ADTableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) ADTableViewDataSouce *ShelfDataSouce;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ADBookshelfViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self queryBookList];

    NSLog(@"viewWillAppear");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"书架";
    self.view.backgroundColor = [UIColor lightGrayColor];
    CGSize rightSize = CGSizeMake(50, 42);
    [self setNavRightButtonwithImg:@"bs_search_free" selImg:@"bs_search_selected_free" size:rightSize title:nil action:@selector(seachBookList)];
    [self.view addSubview:self.tableview];
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames )
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames )
        {
            if ([fontName containsString:@"FZ"]) {
                printf( "\tFont: %s \n", [fontName UTF8String] );
            }
        }
    }
}


- (void)seachBookList{
    ADSeachViewController *seach = [[ADSeachViewController alloc] init];
    ADSearchThemeViewController *search = [ADSearchThemeViewController new];
    [self.navigationController pushViewController:search animated:YES];
}
- (void)queryBookList{
    self.datas = [ADSherfCache query];
    self.ShelfDataSouce.items = self.datas;
    [self.tableview reloadData];
    
//    WeakSelf
//    [ADReaderNetWorking Home_getReadBookInfo:self.datas complete:^(id responseObject, NSError *error) {
//        StrongSelf
//        NSArray *arrT = [NSArray yy_modelArrayWithClass:[ADSherfModel class] json:responseObject];
//        NSLog(@"%@", arrT.firstObject);
//        strongSelf.ShelfDataSouce.items = strongSelf.datas;
//        [strongSelf.tableview reloadData];
//    }];
}

#pragma mark - ADTableViewDelegate
- (void)adTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ADPageViewController *pageVc = [[ADPageViewController alloc] init];
    ADBookInfo *model = self.datas[indexPath.row];
    pageVc.bookId = model._id;
    pageVc.bookName = model.title;
//    UIViewController *vc = [[ADrawerManager instance] installCenterViewController:pageVc leftView:[UIView new]];
    [self.navigationController pushViewController:pageVc animated:YES];
}
- (void)deleteCell:(id)item indexpath:(NSIndexPath *)indexpath{
    
}
#pragma mark - setter & getter
- (UITableView *)tableview{
    if (!_tableview) {
        WeakSelf
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        TableViewCellConfigureBlock ConfigureBlock = ^(ADShelfTableViewCell *cell, ADSherfCusModel * item,NSIndexPath *indexpath){
            if ([cell isKindOfClass:[ADShelfTableViewCell class]]) {
                cell.bookNameL.text = item.title;
                [cell.cover sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:[UIImage imageNamed:@"default_book_cover"]];
                cell.desLable.text = item.lastChapter;
            }
        };
        _ShelfDataSouce = [[ADTableViewDataSouce alloc] initWithCellIdentifier:idcell ConfigureCellBlock:ConfigureBlock];
        _ShelfDataSouce.rowHeight = 70.0f;
        _ShelfDataSouce.delegate = self;
        _ShelfDataSouce.editEnable = YES;
        _ShelfDataSouce.cellDeleteBlock = ^(id item, NSIndexPath *indexpath) {
            StrongSelf
            /*
             [_dataMArr removeObjectAtIndex:indexPath.row];
             [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
             [_tableView reloadData];
             */
        };
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.dataSource = _ShelfDataSouce;
        _tableview.delegate = _ShelfDataSouce;
        _tableview.tableHeaderView = [self getHeadView];
        [_tableview registerNib:[UINib nibWithNibName:@"ADShelfTableViewCell" bundle:nil] forCellReuseIdentifier:idcell];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
    }
    return _tableview;
}
- (UIView *)getHeadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 22)];
    return view;
}

@end
