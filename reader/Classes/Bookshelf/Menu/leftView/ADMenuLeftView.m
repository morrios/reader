//
//  ADMenuLeftView.m
//  reader
//
//  Created by beequick on 2017/9/20.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADMenuLeftView.h"
#import "ADTableViewDataSouce.h"
#import "ADMenuLeftCell.h"

static NSString *const idcell = @"idcell";

@interface ADMenuLeftView ()<ADTableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *bookNameL;
@property (nonatomic, strong) ADTableViewDataSouce *dataSource;

@end

@implementation ADMenuLeftView

+ (instancetype)leftView{
    return [[NSBundle mainBundle] loadNibNamed:@"ADMenuLeftView" owner:nil options:nil].lastObject;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self configUI];
}
- (void)configUI{
    WeakSelf
    self.dataSource = [[ADTableViewDataSouce alloc] initWithItems:self.chapters cellIdentifier:idcell ConfigureCellBlock:^(ADMenuLeftCell *cell, ADChapterModel *item, NSIndexPath *indexpath) {
        StrongSelf
        cell.model = item;
        cell.selectIndex = strongSelf.chapterIndex;
        cell.index = indexpath.row;
    }];
    self.dataSource.rowHeight = 49;
    self.dataSource.delegate = self;
    self.tableview.dataSource = self.dataSource;
    self.tableview.delegate = self.dataSource;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"ADMenuLeftCell" bundle:nil] forCellReuseIdentifier:idcell];
}

- (void)adTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.listSelect(indexPath.row, self.chapters[indexPath.row]);
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}
- (void)setChapters:(NSArray *)chapters{
    _chapters = chapters;
    self.dataSource.items = chapters;
    [self.tableview reloadData];
    if (_chapterIndex) {
        [self scrollToIndex:_chapterIndex];
    }
}

- (void)setChapterIndex:(NSUInteger)chapterIndex{
    _chapterIndex = chapterIndex;
    if (_chapters) {
        [self.tableview reloadData];
        [self scrollToIndex:_chapterIndex];
    }
}
- (void)setBookName:(NSString *)bookName{
    _bookName = bookName;
    self.bookNameL.text = bookName;
}
- (void)scrollToIndex:(NSUInteger)index
{
    [self scrollToIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atPosition:UITableViewScrollPositionMiddle];
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath atPosition:(UITableViewScrollPosition)position
{
    [self.tableview scrollToRowAtIndexPath:indexPath atScrollPosition:position animated:NO];//这里一定要设置为NO，动画可能会影响到scrollerView，导致增加数据源之后，tableView到处乱跳
}


@end
