#import <Foundation/Foundation.h>
@class ADStoreRanking;
@interface  ADRanking : NSObject
@property(nonatomic,strong)NSMutableArray<ADStoreRanking *> *female;
@property(nonatomic,strong)NSMutableArray<ADStoreRanking *> *male;
@property(nonatomic,assign)BOOL ok;
-(instancetype)initWithDictionary:(NSDictionary*)dic;
@end
@interface ADStoreRanking : NSObject
@property(nonatomic,strong)NSString *_id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,assign)BOOL collapse;
@property(nonatomic,strong)NSString *monthRank;
@property(nonatomic,strong)NSString *totalRank;
@property(nonatomic,strong)NSString *shortTitle;
-(instancetype)initWithDictionary:(NSDictionary*)dic;
@end
