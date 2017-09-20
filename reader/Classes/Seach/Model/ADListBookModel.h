//
//  ADListBookModel.h
//  reader
//
//  Created by beequick on 2017/8/11.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADListBookModel : NSObject

@property(nonatomic,strong)NSString *_id;
@property(nonatomic,assign)BOOL hasCp;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *cat;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *site;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *shortIntro;
@property(nonatomic,strong)NSString *lastChapter;
@property(nonatomic,assign)CGFloat retentionRatio;
@property(nonatomic,assign)NSInteger banned;
@property(nonatomic,assign)NSInteger latelyFollower;
@property(nonatomic,assign)NSInteger wordCount;
@property(nonatomic,strong)NSString *contentType;
@property(nonatomic,strong)NSString *superscript;
@property(nonatomic,assign)NSInteger sizetype;

@end
