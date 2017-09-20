//
//  ADBottomButton.m
//  reader
//
//  Created by beequick on 2017/8/17.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADBottomButton.h"
#define YRGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface ADBottomButton ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ADBottomButton

+ (instancetype)bottonWith:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag {
    ADBottomButton *btn = [[self alloc] init];
    btn.userInteractionEnabled = YES;
    CGFloat width = kScreenWidth/5;
    btn.frame = CGRectMake(tag * width, 0, width, 54);
    btn.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.height/2, width, btn.height/2)];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleLabel.textColor = YRGBColor(180, 180, 180);
    btn.titleLabel.text = title;
    
    UIImage *img = [UIImage imageNamed:imageName];
    btn.imageView = [[UIImageView alloc] initWithImage:img];
    btn.imageView.center = CGPointMake(width/2, (btn.height-img.size.height)/2);
    
    btn.backgroundColor = YRGBColor(40, 40, 40);
    btn.tag = 200 + tag;
    [btn addSubview:btn.imageView];
    [btn addSubview:btn.titleLabel];
    [btn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:btn action:@selector(buttonAction)]];
    return btn;
}

- (void)buttonAction {
    NSLog(@"%s  %zi",__func__,self.tag);
    if (self.tapAction) {
        self.tapAction(self.tag);
    }
}

@end
