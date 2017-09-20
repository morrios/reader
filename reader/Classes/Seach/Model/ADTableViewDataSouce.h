//
//  ADTableViewDataSouce.h
//  reader
//
//  Created by beequick on 2017/8/11.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^TableViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexpath);
typedef void (^TableViewCellDidSelectedBlock)(id item, NSIndexPath *indexpath);
//cellForRowAtIndexPath
typedef UITableViewCell* (^TableViewCellForRowBlock)(NSIndexPath *indexpath);

@protocol ADTableViewDelegate <NSObject>
@optional
- (UITableViewCell *)adTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)adTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)adScrollViewDidScroll:(UIScrollView *)scrollview;
@end

@interface ADTableViewDataSouce : NSObject<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
 ConfigureCellBlock:(TableViewCellConfigureBlock)ConfigureCellBlock;

- (id)initWithCellIdentifier:(NSString *)aCellIdentifier
          ConfigureCellBlock:(TableViewCellConfigureBlock)ConfigureCellBlock;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) TableViewCellConfigureBlock ConfigureCellBlock;
@property (nonatomic, copy) TableViewCellDidSelectedBlock cellSelectBlock;
@property (nonatomic, copy) TableViewCellForRowBlock cellForRowBlock;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, weak) id<ADTableViewDelegate> delegate;

@end
