#import <Foundation/Foundation.h>
#import "ADListBookModel.h"

@interface  ADRankingListModel : NSObject
@property(nonatomic,strong)NSString *_id;
@property(nonatomic,strong)NSString *updated;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *tag;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,assign)NSInteger __v;
@property(nonatomic,strong)NSString *monthRank;
@property(nonatomic,strong)NSString *totalRank;
@property(nonatomic,strong)NSString *shortTitle;
@property(nonatomic,strong)NSString *created;
@property(nonatomic,assign)BOOL isSub;
@property(nonatomic,assign)BOOL collapse;
@property(nonatomic,assign)BOOL new;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,assign)NSInteger priority;
@property(nonatomic,strong)NSArray<ADListBookModel *> *books;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,assign)NSInteger total;
@end


