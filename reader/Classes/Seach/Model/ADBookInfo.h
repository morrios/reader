#import <Foundation/Foundation.h>

@interface  ADBookInfo : NSObject
@property(nonatomic,strong)NSString *_id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *longIntro;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *creater;
@property(nonatomic,strong)NSString *majorCate;
@property(nonatomic,strong)NSString *minorCate;
@property(nonatomic,assign)NSInteger sizetype;
@property(nonatomic,strong)NSString *superscript;
@property(nonatomic,assign)NSInteger currency;
@property(nonatomic,strong)NSString *contentType;
@property(nonatomic,assign)BOOL _le;
@property(nonatomic,assign)BOOL allowMonthly;
@property(nonatomic,assign)BOOL allowVoucher;
@property(nonatomic,assign)BOOL allowBeanVoucher;
@property(nonatomic,assign)BOOL hasCp;
@property(nonatomic,assign)NSInteger postCount;
@property(nonatomic,assign)NSInteger latelyFollower;
@property(nonatomic,assign)NSString *followerCount;
@property(nonatomic,assign)NSInteger wordCount;
@property(nonatomic,assign)NSString * serializeWordCount;
@property(nonatomic,strong)NSString *retentionRatio;
@property(nonatomic,strong)NSString *updated;
@property(nonatomic,assign)BOOL isSerial;
@property(nonatomic,assign)NSInteger chaptersCount;
@property(nonatomic,strong)NSString *lastChapter;
@property(nonatomic,strong)NSArray<NSString *> *gender;
@property(nonatomic,strong)NSArray<NSString *> *tags;
@property(nonatomic,strong)NSString *cat;
@property(nonatomic,assign)BOOL donate;
@property(nonatomic,strong)NSString *copyright;
@property(nonatomic,assign)BOOL _gg;
@property(nonatomic,strong)NSString *discount;

@end
