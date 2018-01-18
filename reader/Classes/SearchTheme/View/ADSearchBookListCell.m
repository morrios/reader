//
//  ADSearchBookListCell.m
//  reader
//
//  Created by beequick on 2017/10/25.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADSearchBookListCell.h"
#import "UIImageView+WebCache.h"

@interface ADSearchBookListCell()

@property (weak, nonatomic) IBOutlet UIImageView *bookCoverView;
@property (weak, nonatomic) IBOutlet UILabel *bookNameL;
@property (weak, nonatomic) IBOutlet UILabel *authorL;
@property (weak, nonatomic) IBOutlet UILabel *describeL;
@property (weak, nonatomic) IBOutlet UILabel *readerNumL;
@property (weak, nonatomic) IBOutlet UILabel *bookKindL;
@property (weak, nonatomic) IBOutlet UILabel *lastChapterL;

@end
@implementation ADSearchBookListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIColor *mainColor = [UIColor colorWithHexString:@"#807F89"];
    UIColor *secColor = [UIColor colorWithHexString:@"#A4A3B0"];

    self.bookNameL.textColor = mainColor;
    self.lastChapterL.textColor = mainColor;
    self.authorL.textColor = secColor;
    self.bookKindL.textColor = secColor;
    self.describeL.textColor = secColor;
    self.readerNumL.textColor = [UIColor c3];
    
    self.bookNameL.font = mainFont();
    self.lastChapterL.font = mainFont();
    self.lastChapterL.font = secFont();
    self.describeL.font = desFont();
    self.bookKindL.font = desFont();
}

static inline UIFont* mainFont(){
    return [UIFont systemFontOfSize:14];
}
static inline UIFont* secFont(){
    return [UIFont systemFontOfSize:13];
}
static inline UIFont* desFont(){
    return [UIFont systemFontOfSize:12];
}
- (void)setBook:(ADListBookModel *)book{
    _book = book;
    [self configBookModel:book];
}
- (void)configBookModel:(ADListBookModel *)book{
    self.bookNameL.text = book.title;
    self.authorL.text = book.author;
    self.bookKindL.text = book.cat;
    self.describeL.text = book.shortIntro;
    self.lastChapterL.text = book.lastChapter;
    NSString *readStr = [NSString stringWithFormat:@"%ld 人追",book.latelyFollower];
    if (book.retentionRatio > 0) {
        readStr = [NSString stringWithFormat:@"%@ | %.2f%%留存",readStr, book.retentionRatio];
    }
    self.readerNumL.text = readStr;
    [self.bookNameL sizeToFit];
    [self.lastChapterL sizeToFit];
    [self.authorL sizeToFit];
    [self.bookKindL sizeToFit];
    [self.describeL sizeToFit];
    [self.bookCoverView sd_setImageWithURL:[NSURL URLWithString:book.cover] placeholderImage:[UIImage imageNamed:@"default_book_cover"]];
}

- (CGFloat)transformRect:(ADListBookModel *)model{
    CGFloat padding = 20;
    CGFloat height = [model.description heightForFont:desFont() width:(kScreenWidth - padding*2)];
    CGFloat desY = 90;
    CGFloat desBottomPadding = 50;
    CGFloat cellHeight = height+desY+desBottomPadding;
    return cellHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
