//
//  ADSeachTextFiled.m
//  reader
//
//  Created by beequick on 2017/8/8.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSeachTextFiled.h"
#import "ADSearchTask.h"
@interface ADSeachTextFiled ()


@end

@implementation ADSeachTextFiled

+ (instancetype)seachTextFiled{
    return [[[NSBundle mainBundle] loadNibNamed:@"ADSeachTextFiled" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
    self.textfiled.delegate = self;

}

#pragma mark - delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *str = textField.text;
    if (range.length>0) {
        str = [str substringToIndex:str.length-1];
    }else{
        str = [NSString stringWithFormat:@"%@%@", str, string];
    }

    if (str.length==0) {
        return YES;
    }
    [[ADSearchTask share] requestWithKeyWords:str responseObject:^(id responseObject, NSError *errpr) {
        if (!errpr) {
            if (self.changeBlock) {
                self.changeBlock(responseObject);
            }
            if([self.delegate respondsToSelector:@selector(ADSeachTextFiled:Value:)]) {
                [self.delegate ADSeachTextFiled:self.textfiled Value:responseObject];
            }
        }
        
    }];
    

    return YES;
}


@end
