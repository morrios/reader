//
//  ADCoreTextData.h
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface ADCoreTextData : NSObject
@property (assign,nonatomic)CTFrameRef ctFrame;
@property (assign,nonatomic)CGFloat height;
@end
