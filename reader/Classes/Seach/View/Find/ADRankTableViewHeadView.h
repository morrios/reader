//
//  ADRankTableViewHeadView.h
//  reader
//
//  Created by beequick on 2017/11/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADRankTableViewHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleL;
+ (instancetype)headView;
@end
