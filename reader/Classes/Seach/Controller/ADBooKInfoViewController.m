//
//  ADBooKInfoViewController.m
//  reader
//
//  Created by beequick on 2017/8/11.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADBooKInfoViewController.h"
#import "ADReaderNetWorking.h"
#import "UIImageView+WebCache.h"
#import "YYModel.h"
#import "ADBookInfo.h"
#import "ADPageViewController.h"
#import "ADSherfCache.h"

@interface ADBooKInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bookCoverView;
@property (weak, nonatomic) IBOutlet UILabel *bookNameL;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorL;
@property (weak, nonatomic) IBOutlet UILabel *isfinishedL;

@property (weak, nonatomic) IBOutlet UIButton *addShelfButton;
@property (weak, nonatomic) IBOutlet UIButton *readButton;

@property (weak, nonatomic) IBOutlet UILabel *latelyFollowerAboveL;
@property (weak, nonatomic) IBOutlet UILabel *latelyFollowerDownL;
@property (weak, nonatomic) IBOutlet UILabel *retentionRatioAboveL;
@property (weak, nonatomic) IBOutlet UILabel *retentionRatioDownL;
@property (weak, nonatomic) IBOutlet UILabel *serializeWordCountAboveL;
@property (weak, nonatomic) IBOutlet UILabel *serializeWordCountDownL;

@property (weak, nonatomic) IBOutlet UILabel *longIntroLable;

@property (nonatomic, strong) ADBookInfo *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightContraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidthContraints;

@end

@implementation ADBooKInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setViewsConfig];
    [self loadDatas];
}

- (void)setViewsConfig{
//    UIFont *font1 = [UIFont systemFontOfSize:16];
//    UIFont *font2 = [UIFont systemFontOfSize:12];
//    
//    UIColor *color1 = [UIColor colorWithHexString:@"#282B35"];
//    UIColor *color2 = [UIColor colorWithHexString:@"#646464"];
    
    UIColor *buttonDrak = [UIColor colorWithHexString:@"#594757"];
    
    self.viewHeightContraints.constant = kScreenHeight;
    self.viewWidthContraints.constant = kScreenWidth;
    
    [self.addShelfButton setTitle:@"+ 追更新" forState:UIControlStateNormal];
    [self.addShelfButton setTitle:@"- 不追了" forState:UIControlStateSelected];
    [self.addShelfButton setTitleColor:buttonDrak forState:UIControlStateNormal];
    [self.addShelfButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.addShelfButton.layer.cornerRadius = 4;
    self.addShelfButton.layer.masksToBounds = YES;
    self.addShelfButton.backgroundColor = [UIColor whiteColor];
    
    self.readButton.backgroundColor = buttonDrak;
    [self.readButton setTitle:@"开始阅读" forState:UIControlStateNormal];
    [self.readButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.readButton.layer.cornerRadius = 4;
    self.readButton.layer.masksToBounds = YES;
    
}

- (void)AddShelfButtonSelect:(BOOL)select{
    UIColor *buttonDrak = [UIColor colorWithHexString:@"#594757"];
    
    if (select) {
        self.addShelfButton.backgroundColor = [UIColor colorWithHexString:@"#AAAAAA"];
        self.addShelfButton.layer.borderColor = [UIColor colorWithHexString:@"#AAAAAA"].CGColor;
    }else{
        self.addShelfButton.layer.borderWidth = 1.0f;
        self.addShelfButton.layer.borderColor = buttonDrak.CGColor;
        self.addShelfButton.backgroundColor = [UIColor whiteColor];
    }
    
}


- (void)loadDatas{
    WeakSelf
    [ADReaderNetWorking seach_GetBookInfoWithId:self.bookid complete:^(id responseObject, NSError *error) {
        ADBookInfo *bookInfo = [ADBookInfo yy_modelWithDictionary:responseObject];
        if (bookInfo) {
            StrongSelf
            [strongSelf UpdateUI:bookInfo];
        }
    }];
}

- (void)UpdateUI:(ADBookInfo *)model{
    self.model = model;
    [self.bookCoverView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"default_book_cover"]];
    self.bookNameL.text = model.title;
    
    NSString *author = [NSString stringWithFormat:@"%@ | %@ | %d万", model.author, model.minorCate, (int)model.wordCount/10000];
    UIColor *authodAttedColor = [UIColor colorWithHexString:@"#B73628"];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:author];
    NSRange range = NSMakeRange(0, model.author.length);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:authodAttedColor range:range];
    self.bookAuthorL.attributedText = attributedStr;
    
    self.isfinishedL.text = model._gg ? @"已完结" : @"连载";
    self.latelyFollowerDownL.text = model.followerCount;
    self.retentionRatioDownL.text = [NSString stringWithFormat:@"%@%%", model.retentionRatio];
    self.serializeWordCountDownL.text = model.serializeWordCount;
    
    self.longIntroLable.text = model.longIntro;
    
    BOOL exit = [ADSherfCache queryWithBookId:model._id];
    self.addShelfButton.selected = exit;
    [self AddShelfButtonSelect:exit];
}

#pragma mark - methods
- (IBAction)addToSherf:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        [ADSherfCache removeBook:self.model];
        [self showCustomDialog:@"已取消追更"];

    }else{
        [ADSherfCache addBook:self.model];
        [self showCustomDialog:@"已添加成功"];
    }
    [self AddShelfButtonSelect:sender.selected];
}
- (IBAction)goRead:(id)sender {
    if (self.model) {
        ADPageViewController *pageVc = [[ADPageViewController alloc] init];
        pageVc.bookId = self.model._id;
        [self.navigationController pushViewController:pageVc animated:YES];
    }
    
}
- (void)showCustomDialog:(NSString *)text{
    
    __block MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    
    HUD.label.text = text;
    
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [HUD showAnimated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD removeFromSuperview];
        HUD = nil;
    });
    
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
