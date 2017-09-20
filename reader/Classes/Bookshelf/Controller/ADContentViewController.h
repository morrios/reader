//
//  ADContentViewController.h
//  reader
//
//  Created by beequick on 2017/8/4.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADChapterContentModel.h"

@interface ADContentViewController : UIViewController

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) ADChapterContentModel *model;
- (void)reloadData;
@end
