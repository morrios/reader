//
//  ADCache.m
//  ImageBrowser
//
//  Created by 杜林伟 on 16/9/28.
//  Copyright © 2016年 adu. All rights reserved.
//

#import "ADCache.h"
#import <CommonCrypto/CommonDigest.h>


@interface ADCache ()<NSCacheDelegate>
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, copy) NSString *diskCachePath;
@property (nonatomic, strong) dispatch_queue_t i_cacheQueue;
@property (nonatomic, strong) NSFileManager *fileManager;
@end

@implementation ADCache
+ (instancetype)share{
    static ADCache *ADcache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!ADcache) {
            ADcache = [ADCache new];
        }
    });
    return ADcache;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSString * library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [NSString stringWithFormat:@"%@/Caches/ADCache/com.adu.ADWebCache.default",library];
        self.diskCachePath = path;
        self.i_cacheQueue = dispatch_queue_create("com.adu.ADWebCache", DISPATCH_QUEUE_SERIAL);
        NSLog(@"path = %@", self.diskCachePath);
    }
    return self;
}

- (void)saveObject:(id)object forKey:(id)key{
    [self saveInFile:object key:key];
    NSAssert([key isKindOfClass:[NSString class]], @"key must be string");
    if ([key isKindOfClass:[NSString class]]) {
        [self.cache setObject:object forKey:[key md5HexDigest]];
    }
}


- (id)readObject:(nonnull id)key{
    
    //first from cache
   id object = [self.cache objectForKey:[key md5HexDigest]];
    if (object) {
        return  object;
    }
    //second from disk
    id diskObject = [self imageFromDisk:key];
    if (diskObject) {
        NSInteger cost = ADCacheCostForImage(diskObject);
        [self.cache setObject:diskObject forKey:[key md5HexDigest] cost:cost];
    }
    return diskObject;
}

- (id)imageFromDisk:(NSString *)key{
    NSData *diskImageData = [self diskObjectForKey:[key md5HexDigest]];
    return [UIImage imageWithData:diskImageData];
}

- (NSData *)diskObjectForKey:(NSString *)key{
    NSString *diskImagepath = [self.diskCachePath stringByAppendingPathComponent:key];
    NSData *data = [NSData dataWithContentsOfFile:diskImagepath];
    if (data) {
        return data;
    }
    //SD中有文件扩展的情况...后期加入
    return nil;
}
FOUNDATION_STATIC_INLINE NSUInteger ADCacheCostForImage(UIImage *image) {
    return image.size.height * image.size.width * image.scale * image.scale;
}
#pragma mark - 清除缓存
- (void)RemoveAllCacheObject{
    [self.cache removeAllObjects];
}

- (void)CleanDisk{
    dispatch_async(self.i_cacheQueue, ^{
        [self.fileManager removeItemAtPath:self.diskCachePath error:nil];
        [self.fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    });
}


#pragma mark - fileCache
- (void)saveInFile:(UIImage *)object key:(NSString *)key{
    [self storeInDisk:object Key:key];
   
}

- (void)storeInDisk:(UIImage *)image Key:(NSString *)key{
    
    dispatch_async(self.i_cacheQueue, ^{
//        NSLog(@"%@",[NSThread currentThread]);
        if (![self.fileManager fileExistsAtPath:self.diskCachePath]) {
            [_fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        //is image PNG or JPG
        int alphaInfo = CGImageGetAlphaInfo(image.CGImage);
        BOOL hasAlpha = !(alphaInfo == kCGImageAlphaNone ||
                          alphaInfo == kCGImageAlphaLast ||
                          alphaInfo == kCGImageAlphaFirst);
        BOOL isPNG = hasAlpha;
        NSData *data;
        if (isPNG) {
            data = UIImagePNGRepresentation(image);
        }else{
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        
        NSString *filePath = [self defaultCachePathForKey:key];
        [_fileManager createFileAtPath:filePath contents:data attributes:nil];
    });
    
}

- (NSString *)defaultCachePathForKey:(NSString *)key {
    NSString *fileName = [[key pathExtension] isEqualToString:@""] ? @"":[NSString stringWithFormat:@"%@.%@",[key md5HexDigest],[key pathExtension]];
    return [self.diskCachePath stringByAppendingPathComponent:fileName];

}
#pragma mark - setter && getter
- (NSCache *)cache{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.totalCostLimit = 10;
        _cache.delegate = self;
    }
    return _cache;
}

- (NSFileManager *)fileManager{
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}


@end

@implementation NSString (ADCache)
#pragma mark - 加密
-(NSString *)md5HexDigest

{
    
    const char *original_str = [self UTF8String];
    
    unsigned char result[CC_MD5_BLOCK_BYTES/2];
    
    CC_MD5(original_str, strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
        
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
    
}
@end
