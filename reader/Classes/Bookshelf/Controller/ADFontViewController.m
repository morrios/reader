//
//  ADFontViewController.m
//  reader
//
//  Created by beequick on 2017/9/27.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADFontViewController.h"
#import "ADTableViewDataSouce.h"
#import "ADFontTableViewCell.h"
#import "ADReaderSetting.h"

@interface ADFontViewController ()<ADTableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) ADTableViewDataSouce *kDatasource;
@property (strong, nonatomic) NSArray *ttf;

@end

@implementation ADFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *idcell =@"idcell";
    self.title = @"正文字体";
    NSArray *items = @[@"默认",@"方正兰亭黑 GB18030",@"方正兰亭黑简体",@"方正兰亭刊宋_GBK",@"方正书宋GBK"];

    TableViewCellConfigureBlock ConfigureBlock = ^(ADFontTableViewCell *cell, NSString *item,NSIndexPath *indexpath){
        cell.fontNameL.text = item;
        CGFloat fontsize = 13;
        UIFont *font = [UIFont systemFontOfSize:fontsize];
        if (indexpath.row>0) {
            font = [UIFont fontWithName:self.ttf[indexpath.row] size:fontsize];
        }
        cell.fontNameL.font = font;
    };
    self.kDatasource = [[ADTableViewDataSouce alloc] initWithCellIdentifier:idcell ConfigureCellBlock:ConfigureBlock];
    self.kDatasource.items = items;
    self.kDatasource.delegate = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.dataSource = self.kDatasource;
    self.tableview.delegate = self.kDatasource;
    [self.tableview registerNib:[UINib nibWithNibName:@"ADFontTableViewCell" bundle:nil] forCellReuseIdentifier:idcell];
    
}
- (void)adTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    [ADReaderSetting shareInstance].setting.fontName = self.ttf[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSArray *)ttf{
    if (!_ttf) {
        _ttf = @[aSystemFontName,@"FZLTH--GB1-4",@"FZLTHJW--GB1-0",@"FZLTKSK--GBK1-0",@"FZSSK--GBK1-0"];
    }
    return _ttf;
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
