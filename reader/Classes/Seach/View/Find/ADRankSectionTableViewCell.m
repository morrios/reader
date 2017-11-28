//
//  ADRankSectionTableViewCell.m
//  reader
//
//  Created by beequick on 2017/11/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADRankSectionTableViewCell.h"
#import "ADRankTableViewCell.h"

static NSString *idcell = @"idcell";
static NSString *idHeadcell = @"idHeadcell";

@interface ADRankSectionTableViewCell()
@property (nonatomic, strong) NSArray *titles;

@end

@implementation ADRankSectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"ADRankTableViewCell" bundle:nil] forHeaderFooterViewReuseIdentifier:idHeadcell];
    [self.tableview registerNib:[UINib nibWithNibName:@"ADRankTableViewCell" bundle:nil] forCellReuseIdentifier:idcell];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:idcell];
}

#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSArray * iconName = [@[@"淘小说最热榜 Top100",@"d_cate"] copy];
    ADRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idcell];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ADRankTableViewCell *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:idHeadcell];
    headView.titleL.text = self.titles[section];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSArray *)titles{
    if (!_titles) {
        _titles = [@[@"淘小说最热榜 Top100",@"本周潜力榜",@"读者留存率Top100",@"淘小说完结榜 Top100",@"VIP排行榜",@"别人家的排行榜"] copy];
    }
    return _titles;
}
@end
