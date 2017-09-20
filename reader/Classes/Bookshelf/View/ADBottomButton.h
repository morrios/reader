//
//  ADBottomButton.h
//  reader
//
//  Created by beequick on 2017/8/17.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADBottomButton : UIView

@property (copy, nonatomic) void(^tapAction)(NSInteger);
+ (instancetype)bottonWith:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag;
@end
