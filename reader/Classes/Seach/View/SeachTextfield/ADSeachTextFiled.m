//
//  ADSeachTextFiled.m
//  reader
//
//  Created by beequick on 2017/8/8.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSeachTextFiled.h"
#import "AFNetworking.h"

@interface ADSeachTextFiled ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *arrayOfTasks;

@end

@implementation ADSeachTextFiled

+ (instancetype)seachTextFiled{
    return [[[NSBundle mainBundle] loadNibNamed:@"ADSeachTextFiled" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
    self.textfiled.delegate = self;
    self.manager = [[AFHTTPSessionManager alloc] init];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.arrayOfTasks = [NSMutableArray array];
}

#pragma mark - delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *str = textField.text;
    if (range.length>0) {
        str = [str substringToIndex:str.length-1];
    }else{
        str = [NSString stringWithFormat:@"%@%@", str, string];
    }

    if (str.length==0) {
        return YES;
    }
    [self.arrayOfTasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask *taskObj, NSUInteger idx, BOOL *stop) {
        [taskObj cancel];
    }];
    
    /// empty the arraOfTasks
    [self.arrayOfTasks removeAllObjects];
    
    NSString *urlString = @"http://api.zhuishushenqi.com/book/auto-complete";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:str forKey:@"query"];
    /// init new task
    WeakSelf
    NSURLSessionDataTask *task = [self.manager GET:urlString parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        StrongSelf
        if (strongSelf.changeBlock) {
            strongSelf.changeBlock(responseObject, nil);
        }
        
        if ([strongSelf.delegate respondsToSelector:@selector(TextFiled:Value:responseObject:)]) {
            [strongSelf.delegate TextFiled:textField Value:str responseObject:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        StrongSelf
        strongSelf.changeBlock(nil, error);
    }];
    
    [self.arrayOfTasks addObject:task];

    return YES;
}


@end
