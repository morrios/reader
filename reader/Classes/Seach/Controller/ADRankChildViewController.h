//
//  ADRankChildViewController.h
//  reader
//
//  Created by beequick on 2017/11/16.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADRanking.h"

typedef NS_ENUM(NSUInteger, RankChildType) {
    RankChildTypeRanking,
    RankChildTypeCategate
};
@interface ADRankChildViewController : UIViewController

@property (nonatomic, strong) ADStoreRanking *model;
@property (nonatomic, assign) RankChildType type;

@end
