//
//  ADContentViewController.m
//  reader
//
//  Created by beequick on 2017/8/4.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADContentViewController.h"
#import "ADDisplayView.h"
#import "ADBookMenu.h"
#import "ADSherfCache.h"
#import "YYModel.h"


@interface ADContentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *pageNumLable;

@property (nonatomic, strong) ADDisplayView *disPlayView;

@end

@implementation ADContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _disPlayView = [[ADDisplayView alloc] initWithFrame:CGRectMake(kYReaderLeftSpace, kYReaderTopSpace, kScreenWidth - kYReaderLeftSpace - kYReaderRightSpace, kScreenHeight - kYReaderTopSpace - kYReaderBottomSpace)];
    _disPlayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_disPlayView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData];
    
}


- (void)reloadData{
    NSString * str = [NSString stringWithFormat:@"第%ld/%ld页", (long)(_index + 1), (long)_model.pageArray.count];
    self.pageNumLable.text = str;
    
    self.contentLable.text = [NSString stringWithFormat:@"%@", _model.title];
    _disPlayView.content = [_model getStringWith:_index];
    NSLog(@"reload data%ld",self.index);
    
    [ADSherfCache UpdateHistoryWithBookId:self.model.bookId chapter:self.model.chapterNum pageIndex:_index];
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
