//
//  ADCategoryViewController.m
//  reader
//
//  Created by beequick on 2017/9/28.
//  Copyright © 2017年 beequick. All rights reserved.
//

#import "ADCategoryViewController.h"
#import "ADCategoryCell.h"
#import "ADCategoryHeadView.h"
#import "ADReaderNetWorking.h"
#import "ADCategoryModel.h"
#import "YYModel.h"

static NSString *const rmale = @"male";
static NSString *const rfemale = @"female";
static NSString *const rpicture = @"picture";
static NSString *const rpress = @"press";

static NSString *idcell = @"idcell";
static NSString *idHeadView= @"idHeadView";

@interface ADCategoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collection;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSMutableDictionary *datas;
@end

@implementation ADCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collection = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
    self.collection.dataSource = self;
    self.collection.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.keys = [@[@"male", @"female", @"picture", @"press"] copy];
    [self.collection registerNib:[UINib nibWithNibName:@"ADCategoryHeadView" bundle:nil]
      forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
             withReuseIdentifier:idHeadView];
    [self.collection registerNib:[UINib nibWithNibName:@"ADCategoryCell" bundle:nil]
      forCellWithReuseIdentifier:idcell];
    
    [self loadDatas];
}
#pragma mark - loadDatas
- (void)loadDatas{
    [SVProgressHUD showWithStatus:@"加载中"];
    [ADReaderNetWorking Search_getAllCategory:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            return ;
        }

        NSArray *male = [NSArray yy_modelArrayWithClass:[ADCategoryModel class] json:responseObject[rmale]];
        NSArray *female = [NSArray yy_modelArrayWithClass:[ADCategoryModel class] json:responseObject[rfemale]];
        NSArray *picture = [NSArray yy_modelArrayWithClass:[ADCategoryModel class] json:responseObject[rpicture]];
        NSArray *press = [NSArray yy_modelArrayWithClass:[ADCategoryModel class] json:responseObject[rpress]];
        [self.datas setObject:male forKey:rmale];
        [self.datas setObject:female forKey:rfemale];
        [self.datas setObject:picture forKey:rpicture];
        [self.datas setObject:press forKey:rpress];
        [self.collection reloadData];
    }];
}
#pragma mark - datasource && delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datas.allKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = self.datas[self.keys[section]];
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ADCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idcell forIndexPath:indexPath];
    NSArray *array = self.datas[self.keys[indexPath.section]];
    cell.model = array[indexPath.row];
    if (array.count%3 != 0) {
        if (indexPath.row>(array.count-4)) {
            [cell addLine:lineTypeBottom];
        }
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ADCategoryHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:idHeadView forIndexPath:indexPath];
    view.nameL.text = self.titles[indexPath.section];
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 56);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int num = 3;
    CGFloat space = 0;
    CGFloat width = (kScreenWidth-(num+1)*space)/3.0;
    return CGSizeMake(width, 66);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    (CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (NSArray *)titles{
    if (!_titles) {
        _titles = [@[@"男生",@"女生",@"图文",@"出版"] copy];
    }
    return _titles;
}
- (NSMutableDictionary *)datas{
    if (!_datas) {
        _datas = [NSMutableDictionary dictionary];
    }
    return _datas;
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
