#import "ADBookInfo.h"
@implementation ADBookInfo
- (NSString *)updated{
    if (_updated) {
        
    }
    return _updated;
}

- (NSString *)cover{
    if (_cover) {
        NSString *url = [NSString stringWithFormat:@"%@%@",ImageBaseUrl,_cover];
        return url;
    }
    return _cover;
}


@end
