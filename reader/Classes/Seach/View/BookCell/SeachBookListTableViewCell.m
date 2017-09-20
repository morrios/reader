//
//  SeachBookListTableViewCell.m
//  reader
//
//  Created by beequick on 2017/8/11.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "SeachBookListTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation SeachBookListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIColor *desColor = [UIColor colorWithHexString:@"#969696"];
    UIColor *mainColor = [UIColor colorWithHexString:@"#323232"];
    UIColor *readColor = [UIColor colorWithHexString:@"#646464"];
    UIFont *mainFont = [UIFont boldSystemFontOfSize:16];
    UIFont *desfont = [UIFont systemFontOfSize:13];
    
    UIColor *backgroundColor = [UIColor colorWithHexString:@"#F5F1EC"];
    self.backgroundColor = backgroundColor;
    self.detaiView.backgroundColor = backgroundColor;
    self.bookNameL.textColor = mainColor;
    self.authorL.textColor = desColor;
    self.describeL.textColor = desColor;
    self.readerNumL.textColor = readColor;
    
    self.bookNameL.font = mainFont;
    self.authorL.font = desfont;
    self.describeL.font = desfont;
    self.readerNumL.font = desfont;
    
}

- (void)setBook:(ADListBookModel *)book{
    _book = book;
    self.bookNameL.text = book.title;
    self.authorL.text = [NSString stringWithFormat:@"%@ | %@",book.author, book.cat];
    self.describeL.text = book.shortIntro;
    NSString *readStr = [NSString stringWithFormat:@"%ld 人在追",book.latelyFollower];
    if (book.retentionRatio > 0) {
        readStr = [NSString stringWithFormat:@"%@ | %.2f%%读者留存",readStr, book.retentionRatio];
    }
    self.readerNumL.text = readStr;
    NSString *url = [NSString stringWithFormat:@"%@%@",ImageBaseUrl,book.cover];
    NSLog(@"%@",url);
    [self.bookCoverView sd_setImageWithURL:[NSURL URLWithString:book.cover] placeholderImage:[UIImage imageNamed:@"default_book_cover"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
