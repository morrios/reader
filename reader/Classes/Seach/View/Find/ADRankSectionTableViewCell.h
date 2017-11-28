//
//  ADRankSectionTableViewCell.h
//  reader
//
//  Created by beequick on 2017/11/15.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADRankSectionTableViewCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *datas;

@end
