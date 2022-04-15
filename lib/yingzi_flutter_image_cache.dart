/* 
 * @Author: yz.yujingzhou 
 * @Date: 2022-04-12 10:16:29 
 * @Last Modified by: yz.yujingzhou
 * @Last Modified time: 2022-04-12 10:29:27
 * @Describe: 描述：支持PlatformView图片组件 
 */

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// Flutter支持 PlatformView 图片组件
/// 解决了目前所有Flutter图片缓存控件不能解决冷启动时从磁盘获取图片时延时的问题
/// 适合应用内个别重要区域如首页头像
/// 不适合大规模使用，PlatformView在Flutter滚动列表有浮动的问题，建议使用 [CachedNetworkImage]
/// [width] 图片宽度
/// [height] 图片高度
/// [url] 图片地址
/// [placeholderPath] 支持本地asset图片
/// [fit] 图片适配方式，只支持BoxFit.contain, BoxFit.cover
/// [cacheKey] 缓存标识
/// [isAutoStableCacheKey] 慎用！是否由系统自动以url排除query后的地址作为缓存标识，如果[cacheKey]值不为空则这个参数失效，如果 [cacheKey] 和 [isAutoStableCacheKey]都没传值默认 [url] 为标识
class YZImageCacheView extends StatefulWidget {

  final double? width;
  final double? height;
  final String url;
  final String? placeholderPath;
  final BoxFit? fit;
  final String? cacheKey;
  final bool? isAutoStableCacheKey;
  final PlatformViewHitTestBehavior? hitTestBehavior;
  final Function()? onTap;

  const YZImageCacheView({
    required this.url, 
    this.width, 
    this.height, 
    this.placeholderPath, 
    this.cacheKey,
    this.isAutoStableCacheKey,
    this.fit,
    this.hitTestBehavior,
    this.onTap,
    Key? key}) : super(key: key);

  @override
  State<YZImageCacheView> createState() => _YZImageCacheViewState();
}

class _YZImageCacheViewState extends State<YZImageCacheView> {
  @override
  Widget build(BuildContext context) {

    const String viewType = "com.yingzi.view/yingzi_flutter_image_cache";
    String? fit;
    if (widget.fit == BoxFit.contain) {
      fit = "contain";
    }
    if (widget.fit == BoxFit.cover) {
      fit = "cover";
    }
    Map params = {
      "url" : widget.url, 
      "width": widget.width, 
      "height": widget.height, 
      "placeholderPath": widget.placeholderPath, 
      "fit": fit,
      "cacheKey": widget.cacheKey,
      "isAutoStableCacheKey": widget.isAutoStableCacheKey ?? false
      };
    
    return Container(
      width: widget.width,
      height: widget.height,
      child:Stack( 
        children: [ 
          ClipRRect(
            child: Platform.isIOS ? UiKitView(
            viewType: viewType,
            creationParams: params,
            creationParamsCodec: const StandardMessageCodec(), 
          ): AndroidView(
            viewType: viewType,
            creationParams: params,
            creationParamsCodec: const StandardMessageCodec(),
          )
        ), 
        InkWell(onTap: (){
          if (widget.onTap != null) {
            widget.onTap!();
          } 
        },child: SizedBox(width: widget.width, height: widget.height)) ], ),         
    );
  }
}