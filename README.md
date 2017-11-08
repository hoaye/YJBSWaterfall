# YJBSWaterfall
## 简单的实现几个代理方法和基本参数配置就可以快速实现完美瀑布流

### 使用方法

#### 一、基本参数的设置

```objc
    // collectionView 的创建 设置代理并遵守 <YJWaterfallViewLayoutDataSource>
    YJWaterfallViewLayout * collectionLayout = [[YJWaterfallViewLayout alloc] init];
    collectionLayout.dataSource = self;
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionLayout];
```

```objc
/** 要实现多少列瀑布流， 可以动态返回  */
- (NSInteger)waterFallColumnNumberInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout;

/** 瀑布流列间距的设置， 可动态返回 */
- (CGFloat)waterFallColumnMarginInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout;

/** 瀑布流的行间距的设置， 可动态返回  */
- (CGFloat)waterFallRowMarginInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout;

/** 瀑布流外边距的设置， 可动态返回  */
- (UIEdgeInsets)waterFallEdgeInsetsInWaterFallLayout:(YJWaterfallViewLayout *)waterFallLayout;
```

#### 二、返回要显示的瀑布流每块的大小
```objc
/** 必须实现的代理 Return 每个Item的Size */
- (CGSize)waterFallLayout:(YJWaterfallViewLayout *)waterFallLayout sizeOfItemAtIndex:(NSUInteger)index;
```

### 效果是这个样子的

4列   |   3列  | 2列 | 1列 | 点击回调
-------|-----|-----|----|-----
<img src="https://ws2.sinaimg.cn/large/006tNc79ly1flaqpve393j30ku112b29.jpg" width="200"> | <img src="https://ws1.sinaimg.cn/large/006tNc79ly1flaqw7y6b2j30ku1124qp.jpg" width="200"> | <img src="https://ws4.sinaimg.cn/large/006tNc79ly1flaqwmk0ryj30ku1127pt.jpg" width="200"> | <img src="https://ws3.sinaimg.cn/large/006tNc79ly1flaqwyfx0zj30ku1121ke.jpg" width="200"> | <img src="https://ws1.sinaimg.cn/large/006tNc79ly1flaqxc1dc2j30ku1124i5.jpg" width="200">