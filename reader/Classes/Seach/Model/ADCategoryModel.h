//
//  ADCategoryModel.h
//  reader
//
//  Created by beequick on 2017/9/29.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADCategoryModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,assign)NSInteger bookCount;
@property(nonatomic,assign)NSInteger monthlyCount;

@end
