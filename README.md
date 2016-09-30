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
##### 4列
![1](http://i4.piimg.com/e1223813d25460b9.png)
##### 3列
![2](http://i4.piimg.com/45250ac674e2765d.png)
##### 2列
![3](http://i4.piimg.com/a28a667f44e12515.png)
##### 2列
![4](http://i4.piimg.com/fd6817d1463c7f9c.png)
##### 点击了某一个
![5](http://i4.piimg.com/16cded0f67bacbc5.png)
