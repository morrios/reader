//
//  ADChapterListViewController.m
//  reader
//
//  Created by beequick on 2017/8/17.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADChapterListViewController.h"
#import "ADTableViewDataSouce.h"
#import "ADChapterTableViewCell.h"

static NSString *const idcell = @"idcell";

@interface ADChapterListViewController ()<ADTableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomVIew;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIButton *scrollTopButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ADTableViewDataSouce *dataSource;
@end

@implementation ADChapterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}
- (void)configUI{
    self.dataSource = [[ADTableViewDataSouce alloc] initWithItems:self.chapters cellIdentifier:idcell ConfigureCellBlock:^(ADChapterTableViewCell *cell, ADChapterModel *item, NSIndexPath *indexpath) {
        cell.model = item;
        cell.index = indexpath.row;
    }];
    self.dataSource.rowHeight = 40;
    self.dataSource.delegate = self;
    self.titleName.text = self.bookName;
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ADChapterTableViewCell" bundle:nil] forCellReuseIdentifier:idcell];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.chapterIndex) {
        [self scrollToIndex:self.chapterIndex];
    }
}
- (void)scrollsToBottom
{
    [self scrollToIndexPath:[NSIndexPath indexPathForRow:(self.chapters.count-1) inSection:0] atPosition:UITableViewScrollPositionBottom];
}
- (void)scrollToIndex:(NSUInteger)index
{
    [self scrollToIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atPosition:UITableViewScrollPositionTop];
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath atPosition:(UITableViewScrollPosition)position
{
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:position animated:NO];//这里一定要设置为NO，动画可能会影响到scrollerView，导致增加数据源之后，tableView到处乱跳
}


- (void)adTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.listSelect(indexPath.row, self.chapters[indexPath.row]);
    [self dismiss];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissButtonOnClick:(id)sender {
    [self dismiss];
}
- (IBAction)scrollAction:(id)sender {
    [self scrollsToBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"ADChapterListViewController dealloc");
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
