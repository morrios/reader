//
//  ADMenuBottom.h
//  reader
//
//  Created by beequick on 2017/9/19.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ChapterActionType) {
    ChapterActionTypePre,
    ChapterActionTypeNext
};
typedef NS_ENUM(NSUInteger,TapActionType) {
    TapActionTypeChapters,
    TapActionTypeFont,
    TapActionTypeDark,
    TapActionTypeDownLoad,
    TapActionTypeMore
};
@protocol ADMenuBottomDelegate <NSObject>

- (void)MenuBottomChapterActionType:(ChapterActionType)actionType;
- (void)MenuBottomValueChange:(NSUInteger)value;
- (void)MenuBottomButtonAction:(TapActionType)actionType;

@end
@interface ADMenuBottom : UIView

+ (instancetype)mainView;

@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet UIView *aboveView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastChapterLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextChapterTrailing;

@property (nonatomic, assign) NSUInteger MaxValue;
@property (nonatomic, assign) NSUInteger MinValue;
@property (nonatomic, assign) NSUInteger CurrentValue;
@property (nonatomic, weak) id<ADMenuBottomDelegate> bottomDelegate;



@end
