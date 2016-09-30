//
//  ViewController.m
//  YJBSWaterfall
//
//  Created by YJHou on 16/4/16.
//  Copyright © 2016年 ismonkey.com. All rights reserved.
//

#import "ViewController.h"
#import "YJWaterfallViewLayout.h"
#import "YJWaterFalCell.h"
#import "MJExtension.h"

static NSString * const collectCellID = @"cellID";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, YJWaterfallViewLayoutDataSource>

@property (nonatomic, weak) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;


@end

@implementation ViewController

-(NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createMainView];
    
    NSArray * shops = [YJWaterFallModel mj_objectArrayWithFilename:@"ShopData.plist"];
    [self.dataSource addObjectsFromArray:shops];
    
    [self.collectionView reloadData];

}


- (void)createMainView{
    YJWaterfallViewLayout * collectionLayout = [[YJWaterfallViewLayout alloc] init];
    collectionLayout.dataSource = self;
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerClass:[YJWaterFalCell class] forCellWithReuseIdentifier:collectCellID];
}

#pragma mark --
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YJWaterFalCell * collectCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectCellID forIndexPath:indexPath];
    collectCell.contentView.backgroundColor = [UIColor colorWithRed:(arc4random() % 255 / 255.0) green:(arc4random() % 255 / 255.0) blue:(arc4random() % 255 / 255.0) alpha:1];
    
    YJWaterFallModel * model = self.dataSource[indexPath.item];
    [collectCell modelToRefashCollectViewCellModel:model];
    
    return collectCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * indexStr = [NSString stringWithFormat:@"选中了第%ld个", indexPath.item];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"YJ瀑布流" message:indexStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark --
- (CGSize)waterFallLayout:(YJWaterfallViewLayout *)waterFallLayout sizeOfItemAtIndex:(NSUInteger)index{
    YJWaterFallModel * model = self.dataSource[index];
    return CGSizeMake(model.w, model.h);
}

- (NSInteger)waterFallColumnNumberInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout{
    
    
    return 4;
}

- (CGFloat)waterFallColumnMarginInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout{
    return 5;
}

-(CGFloat)waterFallRowMarginInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout{
    return 5;
}

- (UIEdgeInsets)waterFallEdgeInsetsInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
