//
//  ADMenuFontView.m
//  reader
//
//  Created by beequick on 2017/9/21.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADMenuFontView.h"
#import "ADReaderSetting.h"
#import "Masonry.h"
#import "ADFontViewController.h"
#import "UIView+AD.h"

static CGFloat const singleViewHieght = 32;
@interface ADMenuFontView()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *fontSizeView;
@property (weak, nonatomic) IBOutlet UIView *fontTTFView;
@property (weak, nonatomic) IBOutlet UIView *linespaceView;
@property (weak, nonatomic) IBOutlet UIView *themeVIew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secButtonConstraint;

@end
@implementation ADMenuFontView

+ (instancetype)fontView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ADMenuFontView" owner:nil options:nil] lastObject];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
    
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    [self configUI];
}
#pragma mark - method

- (IBAction)setFontSmaller:(id)sender {
    [ADReaderSetting shareInstance].setting.fontSize--;
}
- (IBAction)setFontBiger:(id)sender {
    [ADReaderSetting shareInstance].setting.fontSize++;
}
- (IBAction)lineSpaceFirst:(id)sender {
    [ADReaderSetting shareInstance].setting.lineSpace = 6;
}
- (IBAction)lineSpaceSecond:(id)sender {
    [ADReaderSetting shareInstance].setting.lineSpace = 15;
}
- (IBAction)lineSpaceThird:(id)sender {
    [ADReaderSetting shareInstance].setting.lineSpace = 20;
}
- (IBAction)lineSpaceNone:(id)sender {
    [ADReaderSetting shareInstance].setting.lineSpace = 10;
}
- (IBAction)lineSpaceFree:(id)sender {
    
}

- (IBAction)unsimplifiedAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        button.layer.borderColor = [UIColor colorWithHexString:@"#808080"].CGColor;
    }else{
    
        button.layer.borderColor = [UIColor colorWithHexString:@"#FD8B25"].CGColor;
    }
    button.selected = !button.selected;
    [ADReaderSetting shareInstance].setting.unsimplified = ![ADReaderSetting shareInstance].setting.unsimplified;

}
- (IBAction)moreTypeface:(id)sender {
    
    ADFontViewController *fontVC = [[ADFontViewController alloc] initWithNibName:@"ADFontViewController" bundle:nil];
    [[self presentViewController].navigationController pushViewController:fontVC animated:YES];
}
- (IBAction)colorSelectFirst:(id)sender {
    [ADReaderSetting shareInstance].setting.backViewColor = [UIColor colorWithHexString:@"#D8D9DA"];
}
- (IBAction)colorSelectSecond:(id)sender {
    [ADReaderSetting shareInstance].setting.backViewColor = [UIColor colorWithHexString:@"#B5B09D"];

}
- (IBAction)colorSelectThird:(id)sender {
    [ADReaderSetting shareInstance].setting.backViewColor = [UIColor colorWithHexString:@"#BCE7CB"];

}
- (IBAction)colorSelectLast:(id)sender {
    [ADReaderSetting shareInstance].setting.backViewColor = [UIColor colorWithHexString:@"#393E43"];
}
- (IBAction)colorSelectMore:(id)sender {

}

#pragma mark - setter && getter
- (void)configUI{
    CGFloat rate = kScreenWidth/675.0;
    self.buttonConstraint.constant = rate*20;
    self.secButtonConstraint.constant = rate*20;
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = [ADReaderSetting shareInstance].setting.alphaValue;
}
- (void)configFontSizeView{
    [self initialLable:@"字号" superView:self.fontSizeView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"小" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.fontSizeView addSubview:button];
    button.layer.cornerRadius = singleViewHieght*0.5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithHexString:@"#808080"].CGColor;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.fontSizeView);
        make.right.equalTo(self.fontSizeView).offset(-15);
        make.width.mas_equalTo(100);
    }];
    

    
}
- (void)configfFontTTFView{}
- (void)configlLinespaceView{}
- (void)configThemeVIew{}

- (void)initialLable:(NSString *)text superView:(UIView *)superView{
    UILabel *lable = [[UILabel alloc] init];
    lable.text = text;
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = [UIColor whiteColor];
    [superView addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.left.equalTo(superView).offset(15);
    }];
}

@end
