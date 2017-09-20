//
//  SeachBookListTableViewCell.h
//  reader
//
//  Created by beequick on 2017/8/11.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADListBookModel.h"

@interface SeachBookListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookCoverView;
@property (weak, nonatomic) IBOutlet UILabel *bookNameL;
@property (weak, nonatomic) IBOutlet UILabel *authorL;
@property (weak, nonatomic) IBOutlet UILabel *describeL;
@property (weak, nonatomic) IBOutlet UILabel *readerNumL;
@property (weak, nonatomic) IBOutlet UIView *detaiView;

@property (nonatomic, strong) ADListBookModel *book;

@end
