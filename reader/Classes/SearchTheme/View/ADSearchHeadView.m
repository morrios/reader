//
//  ADSearchHeadView.m
//  reader
//
//  Created by beequick on 2017/10/24.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSearchHeadView.h"
#import "ADSearchTask.h"
#import "UIView+AD.h"
@interface ADSearchHeadView()
@property (nonatomic, assign) BOOL isSearchTag;

@end

@implementation ADSearchHeadView

+ (instancetype)searchHeadView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ADSearchHeadView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.inputF.delegate = self;
    self.inputF.tintColor = [UIColor whiteColor];
    self.isSearchTag = YES;
    [self itemsChanges:NO];

}
- (IBAction)backAction:(id)sender {
    [[self presentViewController].navigationController popViewControllerAnimated:YES];
}
- (void)itemsChanges:(BOOL)change{
    if (change) {
        [self.bottomCancleButton setImage:[UIImage imageNamed:@"search_cancle"] forState:UIControlStateNormal];
    }else{
        [self.bottomCancleButton setImage:[UIImage imageNamed:@"search_Icon"] forState:UIControlStateNormal];
    }
}
- (IBAction)canleAction:(id)sender {
    if (self.isSearchTag) {
        
        [self loadKeyWords:self.inputF.text];
    }else{
        if (self.cancleBlock) {
            [self itemsChanges:NO];
            self.cancleBlock();
        }
    }
    _isSearchTag = !_isSearchTag;
}
#pragma mark - delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *str = textField.text;
    if (range.length>0) {
        str = [str substringToIndex:str.length-1];
    }else{
        str = [NSString stringWithFormat:@"%@%@", str, string];
    }
    
    [self loadKeyWords:str];

    return YES;
}

- (void)loadKeyWords:(NSString *)str{
    if (str.length==0) {
        if (self.changeBlock) {
            NSMutableDictionary *responseObject = [NSMutableDictionary dictionaryWithObject:@[] forKey:@"keywords"];
            self.changeBlock(responseObject);
        }
        return;
    }
    [SVProgressHUD showWithStatus:@"搜索..."];
    
    [[ADSearchTask share] requestWithKeyWords:str responseObject:^(id responseObject, NSError *errpr) {
        [SVProgressHUD dismiss];
        if (!errpr) {
            if (self.changeBlock) {
                self.changeBlock(responseObject);
            }
            
        }
        
    }];
}

@end
