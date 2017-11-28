//
//  NSObject+ADUnity.m
//  reader
//
//  Created by beequick on 2017/8/22.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "NSObject+ADUnity.h"
#import <objc/runtime.h>
static const char * PropertysKey = "all_property_key";

@implementation NSObject (ADUnity)
-(NSSet<NSString *> *)properties{
    NSSet *cache = objc_getAssociatedObject(self, PropertysKey);
    if (cache) {
        return cache;
    }
    NSMutableSet *set = [NSMutableSet new];
    Class c = [self class];
    do {
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(c, &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            [set addObject:[NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding]];
        }
        free(properties);
        c = class_getSuperclass(c);
    } while (c != [NSObject class]);
    objc_setAssociatedObject(self, PropertysKey, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return set;
}

- (void)EasyInitCoder:(NSCoder *)aDecoder{
    NSLog(@"%@",[self properties]);
}




@end
