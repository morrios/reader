//
//  ADDownloadSheet.m
//  reader
//
//  Created by beequick on 2017/11/2.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADDownloadSheet.h"
#import "ADCacheManger.h"

@interface ADDownloadSheet()
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) NSInteger fromIndex;
@end

@implementation ADDownloadSheet

+ (instancetype)share{
    static ADDownloadSheet *sheet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sheet = [[self alloc] init];
    });
    return sheet;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.datas = [[NSArray alloc] init];
    }
    return self;
}

- (void)showWithParesentVC:(UIViewController *)controller jsonRespose:(id)jsonRespose fromIndex:(NSInteger)fromIndex{
    self.datas = jsonRespose[@"mixToc"][@"chapters"];
    self.fromIndex = fromIndex;
    [self.alertController dismissViewControllerAnimated:YES completion:nil];
    [controller presentViewController:self.alertController animated:YES completion:nil];
}

- (void)alertActionType:(int)type{
    switch (type) {
        case 1:
            [[ADCacheManger share] loadChatpersFrom:self.fromIndex After:50 chatpers:self.datas];
            break;
        case 2:
            [[ADCacheManger share] loadAllChaptersFrom:self.fromIndex chatpers:self.datas];
            break;
        case 3:
            [[ADCacheManger share] loadAllChapters:self.datas];
            break;
            
        default:
            break;
    }
    
}
- (UIAlertController *)alertController{
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:nil message:@"缓存多少章节" preferredStyle: UIAlertControllerStyleActionSheet];
        UIAlertAction *actionFirst = [UIAlertAction actionWithTitle:@"后面50章" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertActionType:1];
        }];
        UIAlertAction *actionSecond = [UIAlertAction actionWithTitle:@"后面全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertActionType:2];
        }];
        UIAlertAction *actionThird = [UIAlertAction actionWithTitle:@"全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertActionType:3];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [_alertController addAction:actionFirst];
        [_alertController addAction:actionSecond];
        [_alertController addAction:actionThird];
        [_alertController addAction:cancelAction];
        
    }
    return _alertController;
    
}


@end
