import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:yingzi_flutter_image_cache/yingzi_flutter_image_cache.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> _images = [];
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var nativeUrl = 'https://img0.baidu.com/it/u=3573430833,889588534&fm=253&fmt=auto&app=138&f=PNG?w=762&h=500';
    var flutterUrl = 'https://img3.redocn.com/20090928/20090928_d722b5a01257f688bab3wBu0kPFdYTPC.jpg';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: (){
                  setState(() {});
                }, child: Text('刷新页面')), 
              Text('下图原生渲染图片'),
              GestureDetector(
                child: YZImageCacheView(
                  width: 120,
                  height: 120,
                  placeholderPath: "lib/res/icon_default_photo.png",
                  url: nativeUrl,  
                  cacheKey: "123",  
                  isAutoStableCacheKey: true,    
                  onTap: () {
                    print('===========>');
                  },
                ),
                onTap: (){
                  print('------------->');
                },
              ),   
              TextButton(
                onPressed: (){
                  _images.add(
                    YZImageCacheView(
                      width: 120,
                      height: 120,
                      url: flutterUrl,
                      placeholderPath: "lib/res/icon_default_photo.png",
                      fit: BoxFit.cover,
                      isAutoStableCacheKey: true,
                    ),
                  );
                  setState(() {});
                }, child: Text('新增图片')),
              Column(
                children: _images,
              )
            ],
          )
        ) ,
      ),
    );
  }
}
