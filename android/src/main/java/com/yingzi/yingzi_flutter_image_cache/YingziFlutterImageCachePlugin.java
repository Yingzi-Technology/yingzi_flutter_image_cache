package com.yingzi.yingzi_flutter_image_cache;

import androidx.annotation.NonNull;
import android.content.Context;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** YingziFlutterImageCachePlugin */
public class YingziFlutterImageCachePlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  public static Context activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "yingzi_flutter_image_cache");
    channel.setMethodCallHandler(this);

    activity = flutterPluginBinding.getApplicationContext();
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory("com.yingzi.view/yingzi_flutter_image_cache", new YZImageViewFactory(flutterPluginBinding.getBinaryMessenger(), activity, flutterPluginBinding));
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
