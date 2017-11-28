//
//  ADReaderSetting.h
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ADBookPageModel;

@interface ADReaderSetting : NSObject

@property (nonatomic, strong)NSDictionary *readerAttributes;
@property (nonatomic, strong)ADBookPageModel *setting;

+ (ADReaderSetting *)shareInstance;

@end

@interface ADBookPageModel : NSObject <NSCoding>
@property (nonatomic, assign)CGFloat fontSize;
//行距
@property (nonatomic, assign)CGFloat lineSpace;
//字体颜色
@property (nonatomic, strong)UIColor *textColor;
//字体
@property (nonatomic, copy)NSString *fontName;
//字体
@property (nonatomic, strong)UIFont *font;
//背景色
@property (nonatomic, strong)UIColor *backViewColor;
//背景色
@property (nonatomic, assign)CGFloat alphaValue;
//繁体
@property (nonatomic, assign)BOOL unsimplified;
@end
