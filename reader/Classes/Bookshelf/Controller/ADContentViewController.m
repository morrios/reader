//
//  ADContentViewController.m
//  reader
//
//  Created by beequick on 2017/8/4.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADContentViewController.h"
#import "ADDisplayView.h"
#import "ADSherfCache.h"
#import "YYModel.h"
#import "ADReaderSetting.h"

static CGFloat const titleFontSize = 12;
@interface ADContentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *pageNumLable;

@property (nonatomic, strong) ADDisplayView *disPlayView;

@end

@implementation ADContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _disPlayView = [[ADDisplayView alloc] initWithFrame:CGRectMake(kYReaderLeftSpace, kYReaderTopSpace, kScreenWidth - kYReaderLeftSpace - kYReaderRightSpace, kScreenHeight - kYReaderTopSpace - kYReaderBottomSpace)];
    _disPlayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_disPlayView];
    self.contentLable.text = @"";
    self.pageNumLable.text = @"";
    self.view.backgroundColor = [ADReaderSetting shareInstance].setting.backViewColor;
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[ADReaderSetting shareInstance].setting addObserver:self forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:nil];
    [[ADReaderSetting shareInstance].setting addObserver:self forKeyPath:@"lineSpace" options:NSKeyValueObservingOptionNew context:nil];
    [[ADReaderSetting shareInstance].setting addObserver:self forKeyPath:@"fontName" options:NSKeyValueObservingOptionNew context:nil];
    [[ADReaderSetting shareInstance].setting addObserver:self forKeyPath:@"backViewColor" options:NSKeyValueObservingOptionNew context:nil];
    [[ADReaderSetting shareInstance].setting addObserver:self forKeyPath:@"unsimplified" options:NSKeyValueObservingOptionNew context:nil];
    [self contviewClean];
    [self reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ADReaderSetting shareInstance].setting removeObserver:self forKeyPath:@"fontSize"];
    [[ADReaderSetting shareInstance].setting removeObserver:self forKeyPath:@"lineSpace"];
    [[ADReaderSetting shareInstance].setting removeObserver:self forKeyPath:@"fontName"];
    [[ADReaderSetting shareInstance].setting removeObserver:self forKeyPath:@"backViewColor"];
    [[ADReaderSetting shareInstance].setting removeObserver:self forKeyPath:@"unsimplified"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"backViewColor"]) {
        self.view.backgroundColor = [ADReaderSetting shareInstance].setting.backViewColor;
    }else{
        [self reloadData];
    }
}
- (void)contviewClean{
    _disPlayView.content = nil;
    
}
- (void)reloadData{
    _contentLable.font = [UIFont fontWithName:[ADReaderSetting shareInstance].setting.fontName size:titleFontSize];
    _pageNumLable.font      = [UIFont fontWithName:[ADReaderSetting shareInstance].setting.fontName size:titleFontSize];
    [_model updateContentPaging];
    NSString * str = [NSString stringWithFormat:@"第%ld/%ld页", (long)(_index + 1), (long)_model.pageArray.count];
    self.pageNumLable.text = str;
    
    self.contentLable.text = [NSString stringWithFormat:@"%@", _model.title];
    if (_index>=_model.pageCount) {
        _index = (_model.pageCount-1);
    }
    _disPlayView.content = [_model getStringWith:_index];
    NSLog(@"reload data%ld",self.index);
    
    [ADSherfCache UpdateHistoryWithBookId:self.model.bookId chapter:self.model.chapterNum pageIndex:_index];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{

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
