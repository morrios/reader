//
//  ADCache.h
//  ImageBrowser
//
//  Created by 杜林伟 on 16/9/28.
//  Copyright © 2016年 adu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ADCache : NSObject

+ (_Nonnull instancetype)share;
- (void)saveObject:(nonnull id)object forKey:(nonnull id)key;
- (_Nonnull id)readObject:(nonnull id)key;

- (void)RemoveAllCacheObject;
- (void)CleanDisk;
@end

@interface NSString (ADCache)

-(NSString *)md5HexDigest;


@end

