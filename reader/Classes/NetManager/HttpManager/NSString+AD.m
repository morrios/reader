//
//  NSString+AD.m
//  reader
//
//  Created by beequick on 2017/8/14.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "NSString+AD.h"

@implementation NSString (AD)
-(NSString *)reverseString{
    
    NSString *mapPath=[[NSBundle mainBundle] pathForResource:@"reverse" ofType:nil];
    NSDictionary *map=[NSDictionary dictionaryWithContentsOfFile:mapPath];
    NSMutableString *resultString=[NSMutableString stringWithString:[self copy]];
    
    for (NSInteger i=0; i<resultString.length; i++){
        
        unichar c=[resultString characterAtIndex:i];
        NSString *key=[NSString stringWithFormat:@"%C",c];
        NSString *value=[map objectForKey:key];
        if(value){
            
            [resultString deleteCharactersInRange:NSMakeRange(i, 1)];
            [resultString insertString:value atIndex:i];
        }
    }
    return resultString;
}
- (NSString *)AD_stringByURLEncode {
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        /**
         AFNetworking/AFURLRequestSerialization.m
         
         Returns a percent-escaped string following RFC 3986 for a query string key or value.
         RFC 3986 states that the following characters are "reserved" characters.
         - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
         - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
         In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
         query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
         should be percent-escaped in the query string.
         - parameter string: The string to be percent-escaped.
         - returns: The percent-escaped string.
         */
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@?/"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < self.length) {
            NSUInteger length = MIN(self.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            // To avoid breaking up character sequences such as 👴🏻👮🏽
            range = [self rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [self substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)AD_stringByURLDecode {
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
#pragma clang diagnostic pop
    }
}

- (NSDictionary *)AA_UrlStringToDict{
    //获取问号的位置，问号后是参数列表
    NSString *urlString = [self AD_stringByURLDecode];
    NSRange range = [urlString rangeOfString:@"?"];
    //获取参数列表
    NSString *propertys = [urlString substringFromIndex:(int)(range.location+1)];
    //进行字符串的拆分，通过&来拆分，把每个参数分开
    NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
    //把subArray转换为字典
    //tempDic中存放一个URL中转换的键值对
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    if(subArray.count>1){
        
        for (int j = 0 ; j < subArray.count; j++)
        {
            //在通过=拆分键和值
            NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
            //给字典加入元素
            [tempDic setObject:dicArray[1] forKey:dicArray[0]];
        }
        
    }
    return tempDic;
}

@end
