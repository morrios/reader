#import "ADRanking.h"
#import "NSArray+AD.h"

@implementation ADRanking
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _female = [dic[@"female"] map:^id(id obj, int index) {
            return [[ADStoreRanking alloc]initWithDictionary:obj];
        }];
        _male = [dic[@"male"] map:^id(id obj, int index) {
            return [[ADStoreRanking alloc]initWithDictionary:obj];
        }];
        _ok = [dic[@"ok"]boolValue];
    }
    return self;
}
@end
@implementation ADStoreRanking
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        __id = dic[@"_id"];
        _title = dic[@"title"];
        _cover = dic[@"cover"];
        _collapse = [dic[@"collapse"]boolValue];
        _monthRank = dic[@"monthRank"];
        _totalRank = dic[@"totalRank"];
        _shortTitle = dic[@"shortTitle"];
    }
    return self;
}

- (NSString *)cover{
    if (_cover) {
        NSString *url = [NSString stringWithFormat:@"%@%@",ImageBaseUrl,_cover];
        return url;
    }
    return _cover;
}

@end
