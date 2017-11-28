//
//  ADBookListViewController.h
//  reader
//
//  Created by beequick on 2017/11/16.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADRankChildViewController.h"

@interface ADBookListViewController : UIViewController

@property (nonatomic, copy) NSString *listId;
@property (nonatomic, assign) RankChildType type;
@property (nonatomic, strong) UITableView *tableview;

@end
