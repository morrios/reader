//
//  ADDownloadSheet.h
//  reader
//
//  Created by beequick on 2017/11/2.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADDownloadSheet : NSObject
+ (instancetype)share;
- (void)showWithParesentVC:(UIViewController *)controller jsonRespose:(id)jsonRespose fromIndex:(NSInteger)fromIndex;
@end
