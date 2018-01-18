//
//  ADPageViewController.m
//  reader
//
//  Created by beequick on 2017/8/4.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADPageViewController.h"
#import "ADContentViewController.h"
#import "ADChapterContentModel.h"
#import "ADReaderNetWorking.h"
#import "YYModel.h"
#import "ADChapterModel.h"
#import "ADChapterListViewController.h"
#import "ADSherfCache.h"
#import "ADPageMenu.h"
#import "ADMenuLeftView.h"
#import "UIView+AD.h"
#import "ADDownloadSheet.h"
typedef void(^getChapter)(ADChapterContentModel *model);
static CGFloat backViewAlpha = 0.4;
@interface ADPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource,ADPageMenuDelegate,ADMenuBottomDelegate>

@property (nonatomic, strong) UIPageViewController *readViewController;
@property (nonatomic, strong) ADMenuLeftView *leftView;
@property (nonatomic, strong) NSArray *chapters;
@property (nonatomic, strong) ADChapterContentModel *model;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSUInteger chapterIndex;
@property (nonatomic, strong) UIView *tapMenuView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) BOOL isStatusBarHidden;

@property (nonatomic, strong) ADSherfCusModel *cacheBookModel;

@property (nonatomic, strong) ADContentViewController *currentPageController;
@property (nonatomic, strong) ADContentViewController *reducePageController;
@property (nonatomic, strong) id responseObject;
@end

@implementation ADPageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    NSLog(@"viewWillAppear");
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isStatusBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#c4c4c4"];
    [self addChildViewController:self.readViewController];
    [self.view addSubview:self.readViewController.view];
    [self.view addSubview:self.leftView];
    _cacheBookModel = [ADSherfCache QueryHistoryWithBookId:self.bookId];
    _chapterIndex = _cacheBookModel.chapter;
    _index = _cacheBookModel.pageIndex;
    
    [self loadAllChapters];
    [self.readViewController.view addSubview:self.tapMenuView];
    [self.readViewController.view addSubview:self.backView];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden{
    return _isStatusBarHidden;
}
#pragma mark Delegate
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)MenuBottomChapterActionType:(ChapterActionType)actionType{
    if (actionType == ChapterActionTypeNext) {
        _chapterIndex++;
        
    }else if (actionType == ChapterActionTypePre){
        if (_chapterIndex > 0) {
            _chapterIndex--;
        }else{
            [SVProgressHUD showErrorWithStatus:@"当前已是第一章"];return;
        }
    }
    [ADPageMenu share].MenuBottom.CurrentValue = _chapterIndex;
    
    _index = 0;
    WeakSelf
    [self loadChapter:(_chapterIndex) complete:^(ADChapterContentModel *model) {
        StrongSelf
        strongSelf.currentPageController.index = 0;
        strongSelf.currentPageController.model = model;
        [strongSelf.currentPageController reloadData];
    }];
}
/*
TapActionTypeChapters,
TapActionTypeFont,
TapActionTypeDark,
TapActionTypeDownLoad,
TapActionTypeMore
*/
- (void)MenuBottomButtonAction:(TapActionType)actionType{
    switch (actionType) {
        case TapActionTypeChapters:
            NSLog(@"TapActionTypeChapters");
            [self showChapterList];
            break;
        case TapActionTypeFont:
            [[ADPageMenu share] showFontMenu];
            NSLog(@"TapActionTypeFont");
            break;
        case TapActionTypeDark:
            [[ADPageMenu share] showLightView];
            NSLog(@"TapActionTypeDark");
            break;
        case TapActionTypeDownLoad:
            [[ADDownloadSheet share] showWithParesentVC:self jsonRespose:self.responseObject fromIndex:self.chapterIndex];
            NSLog(@"TapActionTypeDownLoad");
            break;
        case TapActionTypeMore:
            NSLog(@"TapActionTypeMore");
            break;

        default:
            break;
    }
}


- (void)MenuBottomValueChange:(NSUInteger)value{
    _chapterIndex = value-1;
    _index = 0;
    WeakSelf
    [self loadChapter:(_chapterIndex) complete:^(ADChapterContentModel *model) {
        StrongSelf
        strongSelf.currentPageController.index = 0;
        strongSelf.currentPageController.model = model;
        [strongSelf.currentPageController reloadData];
    }];
}

- (void)showMenu{
    [ADPageMenu share].delegate = self;
    [ADPageMenu share].MenuBottom.bottomDelegate = self;
    [ADPageMenu share].MenuBottom.MaxValue = self.chapters.count;
    [ADPageMenu share].MenuBottom.CurrentValue = self.chapterIndex;
    WeakSelf
    [ADPageMenu showMenuWithView:self.view show:^{
        StrongSelf
        strongSelf.isStatusBarHidden = NO;
        [strongSelf setNeedsStatusBarAppearanceUpdate];
    } dismiss:^{
        StrongSelf
        strongSelf.isStatusBarHidden = YES;
        [strongSelf setNeedsStatusBarAppearanceUpdate];
    }];
   
    
}

- (void)loadContentPageVc:(ADContentViewController *)pageViewController AtChapter:(NSUInteger)chapter AtPageIndex:(NSUInteger)pageIndex{
    WeakSelf
    [SVProgressHUD show];
    [self loadChapter:chapter complete:^(ADChapterContentModel *model) {
        StrongSelf
        [SVProgressHUD dismiss];
        pageViewController.model = strongSelf.model;
        pageViewController.index = pageIndex;
        [pageViewController reloadData];
    }];
}

- (void)loadAllChapters{
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    WeakSelf
    [ADReaderNetWorking book_getAllChapters:self.bookId complete:^(id responseObject, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            return ;
        }
        [SVProgressHUD dismiss];
        
        StrongSelf
        strongSelf.responseObject = responseObject;
        NSArray * chapters = [NSArray yy_modelArrayWithClass:[ADChapterModel class] json:responseObject[@"mixToc"][@"chapters"]];
        strongSelf.chapters = [chapters copy];
        strongSelf.leftView.chapters = [chapters copy];
        strongSelf.leftView.chapterIndex = strongSelf.chapterIndex;
        [strongSelf loadContentPageVc:strongSelf.currentPageController AtChapter:strongSelf.chapterIndex AtPageIndex:_index];
//        [[ADCacheManger share] loadFrom:0 After:10 Chapters:responseObject];
        
    }];
    
}



- (void)loadChapter:(NSUInteger)chapterIndex complete:(getChapter)complete{
    WeakSelf
    self.leftView.chapterIndex = _chapterIndex;
    ADChapterModel *chapter = self.chapters[chapterIndex];
    NSString *title =chapter.title;
    [ADPageMenu share].MenuBottom.userInteractionEnabled = NO;
    [ADReaderNetWorking book_getBookContentLink:chapter.link bookId:self.bookId complete:^(id responseObject, NSError *error) {
        [ADPageMenu share].MenuBottom.userInteractionEnabled = YES;
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            return ;
        }
        [SVProgressHUD dismiss];
        StrongSelf
        ADChapterContentModel *model = [ADChapterContentModel yy_modelWithDictionary:responseObject[@"chapter"]];
        strongSelf.model = model;
        strongSelf.model.title = title;
        strongSelf.model.chapterNum = chapterIndex;
        strongSelf.model.bookId = strongSelf.bookId;
        complete(model);
//        [strongSelf addChildViewController:strongSelf.readViewController];
//        [strongSelf.view addSubview:strongSelf.readViewController.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ADContentViewController *)viewControllerAtIndex:(NSInteger)index{
    ADContentViewController *page = [[ADContentViewController alloc] init];
    page.index = index;
    page.model = self.model;
    return page;
}
#pragma mark - transform
- (void)resetLeftView {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.leftView.transform = CGAffineTransformIdentity;
        self.readViewController.view.transform = CGAffineTransformIdentity;
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        self.leftView.hidden = YES;
        self.backView.hidden = YES;
    }];
}
- (void)showChapterList {
    self.leftView.hidden = NO;
    self.backView.hidden = NO;
    [[ADPageMenu share]dismissWithAnimate:NO];
    self.backView.alpha = backViewAlpha;

    [UIView animateWithDuration:0.2 animations:^{
        self.leftView.tx = leftViewWidth();
        self.readViewController.view.tx = leftViewWidth();
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - delegate && datasource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (_index == 0) {//第一页
        if (self.chapterIndex==0) {
            return nil;
        }
        _chapterIndex--;
        ADContentViewController *page = [self viewControllerAtIndex:_index];
        [self loadChapter:(_chapterIndex) complete:^(ADChapterContentModel *model) {
            page.index = model.pageCount-1;
            page.model = model;
            _index = model.pageCount-1;
            [page reloadData];
        }];
        return page;
    }
    _index --;
    ADContentViewController *page = [self viewControllerAtIndex:_index];
    self.currentPageController = page;
    return page;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    self.currentPageController = (ADContentViewController *)viewController;

    if (_index == NSNotFound) {
        return nil;
    }
    
    _index++;
    ADContentViewController *page = [self viewControllerAtIndex:_index];
    if (_index<self.model.pageCount) {
        page.model = self.model;
        page.index = _index;
    }else{
        _index = 0;
        _chapterIndex++;
        page.index = 0;
        [self loadChapter:(_chapterIndex) complete:^(ADChapterContentModel *model) {
            page.model = model;
            [page reloadData];

        }];
    }
    NSLog(@"next controller = %@", viewController);
    self.currentPageController = page;
    return page;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
//    NSLog(@"delegate pageViewController = %@",pageViewController.viewControllers);
//    NSLog(@"delegate previousViewControllers = %@",previousViewControllers);

}

- (UIPageViewController *)readViewController{
    if (!_readViewController) {
        //    初始化pageController
        /*
         UIPageViewControllerSpineLocationMin 单页显示
         
         UIPageViewControllerSpineLocationMid 双页显示
         */
        _readViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionSpineLocationKey:@0,UIPageViewControllerOptionInterPageSpacingKey:@0}];
        _readViewController.dataSource = self;
        _readViewController.delegate = self;
        
        ADContentViewController *page_fir = [self viewControllerAtIndex:0];
//        _readViewController.doubleSided = YES;
        
        _index = 0;
        self.currentPageController = page_fir;
        NSArray *array = [NSArray arrayWithObjects:page_fir, nil];
        [_readViewController setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
            NSLog(@"s");
        }];
        _readViewController.view.frame = self.view.bounds;
        NSLog(@"gestureRecognizers = %@", _readViewController.gestureRecognizers);
    }
    return _readViewController;
}

- (ADContentViewController *)currentPageController{
    if (!_currentPageController) {
        _currentPageController = [[ADContentViewController alloc] init];
    }
    return _currentPageController;
}

- (ADContentViewController *)reducePageController{
    if (!_reducePageController) {
        _reducePageController = [[ADContentViewController alloc] init];
    }
    return _reducePageController;
}

- (UIView *)tapMenuView{
    if (!_tapMenuView) {
        CGFloat leftSpace = 120;
        _tapMenuView =  [[UIView alloc] initWithFrame:CGRectMake(leftSpace, 100, kScreenWidth - leftSpace*2, kScreenHeight - 300)] ;
        _tapMenuView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu)];
        [_tapMenuView addGestureRecognizer:tap];
        _tapMenuView.centerX = self.view.width*0.5;
        _tapMenuView.centerY = self.view.height*0.5;
        
    }
    return _tapMenuView;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.35;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetLeftView)];
        [_backView addGestureRecognizer:tap];
        _backView.hidden = YES;
    }
    return _backView;
}

- (ADMenuLeftView *)leftView{
    if (!_leftView) {
        _leftView = [ADMenuLeftView leftView];
        _leftView.frame = CGRectMake(-leftViewWidth(), 0, leftViewWidth(), kScreenHeight);
        _leftView.hidden = YES;
        _leftView.bookName = self.bookName;
        WeakSelf
        _leftView.listSelect = ^(NSUInteger chapterIndex, ADChapterModel *model) {
            StrongSelf
            [strongSelf resetLeftView];
            if (chapterIndex != strongSelf.chapterIndex) {
                strongSelf.chapterIndex = chapterIndex;
                strongSelf.index = 0;
                [strongSelf loadContentPageVc:strongSelf.currentPageController AtChapter:chapterIndex AtPageIndex:0];
            }
        };
    }
    return _leftView;
}
static inline CGFloat leftViewWidth() {
    return kScreenWidth-72;
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
