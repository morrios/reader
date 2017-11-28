//
//  ADSeachTextFiled.h
//  reader
//
//  Created by beequick on 2017/8/8.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TextFiledValueChangeBlock)(id value);
@protocol ADSeachTextFiledDelegate <NSObject>

- (void)ADSeachTextFiled:(UITextField *)textfiled Value:(id)value;

@end


@interface ADSeachTextFiled : UIView<UITextFieldDelegate>

+ (instancetype)seachTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (nonatomic, copy) TextFiledValueChangeBlock changeBlock;

@property (nonatomic,weak) id <ADSeachTextFiledDelegate>delegate;


@end
