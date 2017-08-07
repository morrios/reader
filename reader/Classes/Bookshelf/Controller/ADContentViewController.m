//
//  ADContentViewController.m
//  reader
//
//  Created by beequick on 2017/8/4.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADContentViewController.h"
#import "ADCoreText.h"

@interface ADContentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (nonatomic, strong) ADDisplayView *disPlayView;
@end

@implementation ADContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentLable.text = [NSString stringWithFormat:@"%d", self.index];
//    [self.view addSubview:self.disPlayView];
    
    
    //创建画布
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    ADDisplayView *dispaleView = [[ADDisplayView alloc] initWithFrame:CGRectMake(kYReaderLeftSpace, kYReaderTopSpace, screenSize.width-kYReaderRightSpace-kYReaderLeftSpace, screenSize.height-kYReaderTopSpace-kYReaderBottomSpace)];
    [self.view addSubview:dispaleView];
    
    //设置配置信息
    ADCTFrameParserConfig *config = [[ADCTFrameParserConfig alloc] init];
    config.textColor = [UIColor blackColor];
    config.width = dispaleView.width;
    config.lineSpace = 5;
    config.fontSize  = 16;
    
    
    //设置内容
    if (self.content != nil) {
        ADCoreTextData *data = [ADCTFrameParser parseContent:self.content config:config];
        dispaleView.data = data;
        dispaleView.height = data.height;
        dispaleView.backgroundColor = [UIColor clearColor];
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
