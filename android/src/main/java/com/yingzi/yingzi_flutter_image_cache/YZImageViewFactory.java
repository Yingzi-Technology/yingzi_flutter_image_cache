package com.yingzi.yingzi_flutter_image_cache;

import android.content.Context;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class YZImageViewFactory extends PlatformViewFactory {

    private final BinaryMessenger messenger;
    private Context activity;
    FlutterPlugin.FlutterPluginBinding flutterPluginBinding;

    public YZImageViewFactory(BinaryMessenger messenger, Context activity, FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
        super(StandardMessageCodec.INSTANCE);

        this.messenger = messenger;
        this.activity = activity;
        this.flutterPluginBinding = flutterPluginBinding;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;
        return new YZImageView(context, messenger, viewId, params, activity, flutterPluginBinding);
    }
}
