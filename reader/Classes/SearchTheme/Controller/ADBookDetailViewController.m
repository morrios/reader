//
//  ADBookDetailViewController.m
//  reader
//
//  Created by beequick on 2017/10/26.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADBookDetailViewController.h"
#import "ADReaderNetWorking.h"
#import "YYModel.h"
#import "ADBookInfo.h"
#import "UIImageView+WebCache.h"
#import "YYCategories.h"
#import "iOSPalette.h"
#import "ADSherfCache.h"
#import "ADPageViewController.h"

@interface ADBookDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *topBackImageView;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookNameL;
@property (weak, nonatomic) IBOutlet UILabel *authorL;
@property (weak, nonatomic) IBOutlet UILabel *lastChapterL;
@property (weak, nonatomic) IBOutlet UILabel *crateDateL;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *readButton;


@property (weak, nonatomic) IBOutlet UIView *NumView;
@property (weak, nonatomic) IBOutlet UILabel *bookCountL;
@property (weak, nonatomic) IBOutlet UILabel *readNumL;
@property (weak, nonatomic) IBOutlet UILabel *stayRateL;
@property (weak, nonatomic) IBOutlet UILabel *countDayL;
//简介
@property (weak, nonatomic) IBOutlet UIView *desView;
@property (weak, nonatomic) IBOutlet UILabel *desLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desViewHeightConstraint;
@property (nonatomic, strong) ADBookInfo *model;


@end

@implementation ADBookDetailViewController
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
    // Do any additional setup after loading the view from its nib.
    [self setUpViews];
    [self loadDatas];
    
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLayoutSubviews{
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame = self.topBackImageView.bounds;
    [self.topBackImageView addSubview:effectView];
}
- (void)setUpViews{
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    [self.likeBtn setImage:[UIImage imageNamed:@"bookInfo_markSelected"] forState:UIControlStateSelected];
    self.topView.backgroundColor = [UIColor clearColor];
    self.likeBtn.backgroundColor = [UIColor whiteColor];
    self.likeBtn.layer.cornerRadius = 15;
    self.likeBtn.layer.masksToBounds = YES;
    self.readButton.layer.cornerRadius = 15;
    self.readButton.layer.masksToBounds = YES;
    
    self.topBackImageView.image = [UIImage imageWithColor:[UIColor whiteColor]];
    
    
    //设置阴影
    UIColor *backColor = [UIColor colorWithHexString:@"#A7A7A7"];
    [self setShadow:self.likeBtn color:backColor];
    [self setShadow:self.readButton color:backColor];
    [self setShadow:self.NumView color:backColor];
    [self setShadow:self.desView color:backColor];
    
    
}
- (void)setShadow:(UIView *)view color:(UIColor *)color{
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = 0.3f;
    view.layer.shadowRadius = 4.f;
    view.layer.shadowOffset = CGSizeMake(4,4);
    view.layer.shadowOffset = CGSizeMake(0,0);
}
- (void)loadDatas{
    WeakSelf
    [ADReaderNetWorking seach_GetBookInfoWithId:self.bookid complete:^(id responseObject, NSError *error) {
        ADBookInfo *bookInfo = [ADBookInfo yy_modelWithDictionary:responseObject];
        if (bookInfo) {
            StrongSelf
            [strongSelf updateUI:bookInfo];
        }
    }];
}
- (IBAction)addToBookshelf:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        [ADSherfCache removeBook:self.model];
        [SVProgressHUD showSuccessWithStatus:@"移除书籍成功"];
    }else{
        [ADSherfCache addBook:self.model];
        [SVProgressHUD showSuccessWithStatus:@"添加书籍成功"];
    }
}
- (IBAction)readBook:(id)sender {
    ADPageViewController *pageVc = [[ADPageViewController alloc] init];
    ADBookInfo *model = self.model;
    pageVc.bookId = model._id;
    pageVc.bookName = model.title;
    //    UIViewController *vc = [[ADrawerManager instance] installCenterViewController:pageVc leftView:[UIView new]];
    [self.navigationController pushViewController:pageVc animated:YES];
}

- (void)getALlPiex:(UIImage *)image{
    [image getPaletteImageColorWithMode:ALL_MODE_PALETTE withCallBack:^(PaletteColorModel *recommendColor, NSDictionary *allModeColorDic,NSError *error) {
        if (!recommendColor){//失败
            return;
        }
        if(error!=nil){
            return;
        }
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        
        UIColor *firstColor = [UIColor whiteColor];
        UIColor *secondColor = [UIColor colorWithHexString:@"#303745"];

        PaletteColorModel *model = allModeColorDic[@"light_muted"];
        firstColor = [UIColor colorWithHexString:model.imageColorString];
        model = allModeColorDic[@"vibrant"];
        secondColor = [UIColor colorWithHexString:model.imageColorString];
        
        
        gradientLayer.colors = @[(__bridge id)firstColor.CGColor, (__bridge id)secondColor.CGColor];//这里颜色渐变
        gradientLayer.locations = @[@0.2, @1.0];//颜色位置
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0.0, 1.0);
        gradientLayer.frame = CGRectMake(0, 0, kScreenWidth, 300);

        NSLog(@"%@", allModeColorDic);
    }];
}

- (void)updateUI:(ADBookInfo *)info{
    self.model = info;
    WeakSelf
    [self.coverImageView  sd_setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:[UIImage imageNamed:@"default_book_cover"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakSelf.topBackImageView.image = [image imageByBlurDark];
//        [weakSelf getALlPiex:image];
    }];
    self.bookNameL.text = info.title;
    self.authorL.text = [NSString stringWithFormat:@"%@ | %@", info.author, info.minorCate];
    self.bookCountL.text = [NSString stringWithFormat:@"%d万",(int)info.wordCount/10000];
    self.readNumL.text = [NSString stringWithFormat:@"%ld", info.latelyFollower];
    self.stayRateL.text = [NSString stringWithFormat:@"%@%%", info.retentionRatio];
    self.countDayL.text = info.serializeWordCount;
    self.lastChapterL.text = info.lastChapter;
    self.crateDateL.text = [info.updated substringToIndex:10];
    [self.bookNameL sizeToFit];
    [self.authorL sizeToFit];
    [self.lastChapterL sizeToFit];
    [self.crateDateL sizeToFit];
    self.desLable.text = info.longIntro;
    UIFont *font = [UIFont systemFontOfSize:12];
    CGFloat width = kScreenWidth - 15*2;
    CGFloat height = [info.longIntro heightForFont:font width:width];
    self.desViewHeightConstraint.constant = height+45+10;
    self.likeBtn.selected = [ADSherfCache queryWithBookId:info._id];

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
