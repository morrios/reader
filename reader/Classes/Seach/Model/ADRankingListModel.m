#import "ADRankingListModel.h"
@implementation ADRankingListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"books" : [ADListBookModel class] };
}
@end


