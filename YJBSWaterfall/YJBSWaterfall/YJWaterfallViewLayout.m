//
//  YJWaterfallViewLayout.m
//  YJBSWaterfall
//
//  Created by YJHou on 16/4/16.
//  Copyright © 2016年 ismonkey.com. All rights reserved.
//

#import "YJWaterfallViewLayout.h"

static NSInteger    const YJColumnDefaultCount = 3;                // column Default is 3
static CGFloat      const YJRowMarginDefault = 5;                // rowMargin Default is 5
static CGFloat      const YJColumnMarginDefault = 5;             // columnMargin Default is 5
static UIEdgeInsets const YJEdgeInsetsDefault = {5, 5, 5, 5}; // EdgeInsets Default is 5

@interface YJWaterfallViewLayout ()

@property (nonatomic, strong) NSMutableArray * attributeDataSource; // 存放每个 Cell 的属性
@property (nonatomic, strong) NSMutableArray * eachColumnHeights;   // 存放每一列的高度
@property (nonatomic, assign) CGFloat          lastContentHeight;   // 保存最后内容的高度

- (NSInteger)columnCount;
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation YJWaterfallViewLayout

#pragma mark -- 获取配置视图显示的参数
- (NSInteger)columnCount{
    if ([self.dataSource respondsToSelector:@selector(waterFallColumnNumberInWaterFallLayout:)] && ([self.dataSource waterFallColumnNumberInWaterFallLayout:self] >0)) {
        return [self.dataSource waterFallColumnNumberInWaterFallLayout:self];
    }else{
    return YJColumnDefaultCount;
    }
}

-(CGFloat)rowMargin{
    if ([self.dataSource respondsToSelector:@selector(waterFallRowMarginInWaterFallLayout:)]) {
        return [self.dataSource waterFallRowMarginInWaterFallLayout:self];
    }else{
    return YJRowMarginDefault;
    }
}

- (CGFloat)columnMargin{
    if ([self.dataSource respondsToSelector:@selector(waterFallColumnMarginInWaterFallLayout:)]) {
        return [self.dataSource waterFallColumnMarginInWaterFallLayout:self];
    }else{
    return YJColumnMarginDefault;
    }
}

-(UIEdgeInsets)edgeInsets{
    if ([self.dataSource respondsToSelector:@selector(waterFallEdgeInsetsInWaterFallLayout:)]) {
        return [self.dataSource waterFallEdgeInsetsInWaterFallLayout:self];
    }else{
    return YJEdgeInsetsDefault;
    }
}

- (CGSize)imgSizeWithIndex:(NSInteger)index{
    CGSize imgSize = [self.dataSource waterFallLayout:self sizeOfItemAtIndex:index];
    if (imgSize.height > 0) {
        return imgSize;
    }else{
        return CGSizeZero;
    }
}

- (NSMutableArray *)attributeDataSource{

    if (_attributeDataSource == nil) {
        _attributeDataSource = [NSMutableArray array];
    }
    return _attributeDataSource;
}

- (NSMutableArray *)eachColumnHeights{

    if (_eachColumnHeights == nil) {
        _eachColumnHeights = [NSMutableArray array];
    }
    return _eachColumnHeights;
}

#pragma mark -- 重写方法实现自瀑布流
-(void)prepareLayout{
    [super prepareLayout];
    
    self.lastContentHeight = 0;
    
    [self.eachColumnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.eachColumnHeights addObject:@(self.edgeInsets.top)];
    }
    
    [self.attributeDataSource removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributeDataSource addObject:attrs];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // 宽
    CGFloat width = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    // 高
    CGSize itemSize = [self imgSizeWithIndex:indexPath.item];
    CGFloat height = width * itemSize.height / itemSize.width;
    
    NSInteger minShortColumn = 0;
    CGFloat minColumnHeight = [self.eachColumnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.eachColumnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            minShortColumn = i;
        }
    }
    
    // X & Y
    CGFloat x = self.edgeInsets.left + minShortColumn * (width + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, width, height);
    
    self.eachColumnHeights[minShortColumn] = @(CGRectGetMaxY(attrs.frame));
    
    CGFloat newColumnHeight = [self.eachColumnHeights[minShortColumn] doubleValue];
    if (self.lastContentHeight < newColumnHeight) {
        self.lastContentHeight = newColumnHeight;
    }
    return attrs;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributeDataSource;
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(0, self.lastContentHeight + self.edgeInsets.bottom);
}

@end
