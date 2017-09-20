//
//  ADListBookModel.m
//  reader
//
//  Created by beequick on 2017/8/11.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADListBookModel.h"

@implementation ADListBookModel

- (NSString *)cover{
    if (_cover) {
        NSString *url = [NSString stringWithFormat:@"%@%@",ImageBaseUrl,_cover];
        return url;
    }
    return _cover;
}

@end
