//
//  ADSeachDelegate.h
//  reader
//
//  Created by beequick on 2017/8/10.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ADCollectionviewDidSelect)(id value);

@interface ADSeachDelegate : NSObject<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

- (id)initWithItems:(NSArray *)items;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) ADCollectionviewDidSelect selectBlock;

@end
