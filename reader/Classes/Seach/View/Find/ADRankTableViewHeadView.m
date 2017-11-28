//
//  ADRankTableViewHeadView.m
//  reader
//
//  Created by beequick on 2017/11/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADRankTableViewHeadView.h"

@implementation ADRankTableViewHeadView

+ (instancetype)headView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ADRankTableViewHeadView" owner:nil options:nil] lastObject];
}
@end
