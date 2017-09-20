//
//  ADChapterListViewController.h
//  reader
//
//  Created by beequick on 2017/8/17.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADChapterModel.h"


typedef void (^ADChapterListSelect)(NSUInteger chapterIndex,ADChapterModel *model);

@interface ADChapterListViewController : UIViewController

@property (nonatomic, strong) NSString *bookName;
@property (nonatomic, strong) NSArray *chapters;
@property (nonatomic, assign) NSUInteger chapterIndex;
@property (nonatomic, copy) ADChapterListSelect listSelect;


@end
