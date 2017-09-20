//
//  ADChapterModel.m
//  reader
//
//  Created by beequick on 2017/8/17.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADChapterModel.h"
#import "NSString+AD.h"

@implementation ADChapterModel

- (NSString *)link{
    if (_link) {
        return [NSString stringWithFormat:@"%@%@",ChapterBaseUrl, [_link AD_stringByURLEncode]];
    }
    return _link;
}

@end
