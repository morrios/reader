//
//  ADReaderSetting.h
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADReaderSetting : NSObject
//配置属性
@property (nonatomic ,assign)CGFloat width;
@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)CGFloat lineSpace;
@property (nonatomic, strong)UIColor *textColor;
@property (nonatomic, strong)UIFont *font;

@property (nonatomic, strong)NSDictionary *readerAttributes;



+ (instancetype)shareInstance;

@end
