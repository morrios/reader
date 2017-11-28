//
//  ADSearchHeadView.h
//  reader
//
//  Created by beequick on 2017/10/24.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TextFiledValueChangeBlock)(id value);
typedef void (^CancleActionBlock)();

@interface ADSearchHeadView : UIView <UITextFieldDelegate>
+ (instancetype)searchHeadView;
@property (weak, nonatomic) IBOutlet UITextField *inputF;
@property (weak, nonatomic) IBOutlet UIButton *bottomCancleButton;
@property (nonatomic, copy) TextFiledValueChangeBlock changeBlock;
@property (nonatomic, copy) CancleActionBlock cancleBlock;
- (void)itemsChanges:(BOOL)change;

@end
