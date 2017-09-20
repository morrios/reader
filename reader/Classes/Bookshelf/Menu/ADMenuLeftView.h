//
//  ADMenuLeftView.h
//  reader
//
//  Created by beequick on 2017/9/20.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADChapterModel.h"

typedef void (^ADChapterListSelect)(NSUInteger chapterIndex,ADChapterModel *model);

@interface ADMenuLeftView : UIView
@property (nonatomic, strong) NSString *bookName;
@property (nonatomic, strong) NSArray *chapters;
@property (nonatomic, assign) NSUInteger chapterIndex;
@property (nonatomic, copy) ADChapterListSelect listSelect;

+ (instancetype)leftView;
@end
