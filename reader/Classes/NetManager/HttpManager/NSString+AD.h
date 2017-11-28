//
//  NSString+AD.h
//  reader
//
//  Created by beequick on 2017/8/14.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AD)
- (NSString *)AD_stringByURLEncode ;
- (NSString *)AD_stringByURLDecode ;
- (NSString *)reverseString;
- (NSDictionary *)AA_UrlStringToDict;
@end
