# yingzi_flutter_image_cache

> 非常简单易用的Flutter图片控件。
> 将当前Android和iOS上最流行的两大图片库（Glide/KingFisher）封装成Flutter插件，在Flutter上提供接近原生的加载图片效果。

- 目前所有Flutter图片缓存控件如[CachedNetworkImage]不能解决每次应用冷启动时从磁盘获取图片延时的问题
- 适合：个别重要区域或比较固定位置的图片，如首页头像
- 不适合：大规模使用，图片库采用Flutter PlatformView进行封装，在Flutter滚动列表有浮动的问题，建议使用官方推荐的 [CachedNetworkImage]

## How to use

```
dependencies:
  yingzi_flutter_image_cache:
    git:
      url: https://github.com/Yingzi-Technology/yingzi_flutter_image_cache.git
      ref: 1.0.0
```

```
YZImageCacheView(
    width: 120,
    height: 120,
    placeholderPath: "lib/res/icon_default_photo.png",
    url: "https://img0.baidu.com/it/u=3573430833,889588534&fm=253&fmt=auto&app=138&f=PNG?w=762&h=500",  
)
```

## Parameters description
- [width] 图片宽度
- [height] 图片高度
- [url] 图片地址
- [placeholderPath] 支持本地asset图片
- [fit] 图片适配方式，只支持BoxFit.contain, BoxFit.cover
- [cacheKey] 缓存标识
- [isAutoStableCacheKey] 一般不用！是否由系统自动以url排除query后的地址作为缓存标识，如果[cacheKey]值不为空则这个参数失效，如果 [cacheKey] 和 [isAutoStableCacheKey]都没传值默认 [url] 为标识

