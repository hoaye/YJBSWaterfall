//
//  YJWaterfallViewLayout.h
//  YJBSWaterfall
//
//  Created by YJHou on 16/4/16.
//  Copyright © 2016年 ismonkey.com. All rights reserved.
//  YJBS 瀑布流Layout

#import <UIKit/UIKit.h>

@class YJWaterfallViewLayout;

@protocol YJWaterfallViewLayoutDataSource <NSObject>

@required

/** 必须实现的代理 Return 每个Item的Size */
- (CGSize)waterFallLayout:(YJWaterfallViewLayout *)waterFallLayout sizeOfItemAtIndex:(NSUInteger)index;

@optional
/** 瀑布流的列数  */
- (NSInteger)waterFallColumnNumberInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout;
/** 瀑布流的列宽 */
- (CGFloat)waterFallColumnMarginInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout;
/** 瀑布流的行宽  */
- (CGFloat)waterFallRowMarginInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout;
/** 瀑布流 Item 边界的设置  */
- (UIEdgeInsets)waterFallEdgeInsetsInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout;

@end

@interface YJWaterfallViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<YJWaterfallViewLayoutDataSource> dataSource;

@end
