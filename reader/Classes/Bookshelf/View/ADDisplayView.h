//
//  ADDisplayView.h
//  reader
//
//  Created by beequick on 2017/8/7.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface ADDisplayView : UIView

@property(copy,nonatomic)NSString *content;
@property (assign, nonatomic) CTFrameRef contentFrame;

@end
