package com.yingzi.yingzi_flutter_image_cache;

import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.graphics.drawable.BitmapDrawable;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;

//import com.squareup.picasso.Picasso;
//import com.squareup.picasso.RequestCreator;

import com.bumptech.glide.Glide;
import com.bumptech.glide.RequestBuilder;
import com.bumptech.glide.load.model.GlideUrl;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import io.flutter.FlutterInjector;
import io.flutter.embedding.engine.loader.FlutterLoader;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class YZImageView implements PlatformView {
    private final ImageView imageView;

    YZImageView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params, Context activity, FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
        this.imageView = new ImageView(activity);
        if (params == null) return;
        String url = params.get("url").toString();
        if (url != null && url != "") {
            Object widthObj = params.get("width");
            int width = 0;
            if (widthObj != null) {
                width = Double.valueOf(widthObj.toString()).intValue();
            }
            Object heightObj = params.get("height");
            int height = 0;
            if (heightObj != null) {
                height = Double.valueOf(heightObj.toString()).intValue();
            }

            String cacheKey = null;
            if (params.get("cacheKey") != null) {
                cacheKey = params.get("cacheKey").toString();
            } else if (params.get("isAutoStableCacheKey") != null) {
                boolean isAutoStableCacheKey = ((Boolean) params.get("isAutoStableCacheKey")).booleanValue();
                if (isAutoStableCacheKey) {
                    cacheKey = getUrlHostAndPath(url);
                } else {
                    cacheKey = url;
                }
            } else {
                cacheKey = url;
            }

            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(dpToPx(context, width), dpToPx(context, height));
            this.imageView.setLayoutParams(layoutParams);
            RequestBuilder rcreator = Glide.with(context)
                    .load(new YZGlideUrlWithCacheKey(url, cacheKey));
//            RequestCreator rcreator = Picasso.get()
//                    .load(url)
//                    .stableKey(cacheKey)
//                    .resize(width, height);

            Object fitObj = params.get("fit");
            if (fitObj != null) {
                String fit = fitObj.toString();
                if (fit.equals("contain")) {
                    rcreator.centerInside();
                } else if (fit.equals("cover")) {
                    rcreator.centerCrop();
                } else {
                    rcreator.centerInside();
                }
            }

            String placeholderPath = params.get("placeholderPath").toString();
            if (placeholderPath != null && placeholderPath != "") {
                AssetManager assetManager = flutterPluginBinding.getApplicationContext().getAssets();
                FlutterLoader loader = FlutterInjector.instance().flutterLoader();
                String key = loader.getLookupKeyForAsset(placeholderPath);
                try {
                    AssetFileDescriptor fd = assetManager.openFd(key);
                    InputStream inputStream = fd.createInputStream();
                    BitmapDrawable bitmapDrawable = new BitmapDrawable(context.getResources(), inputStream);
                    rcreator.placeholder(bitmapDrawable);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            rcreator.into(this.imageView);

        }
    }

    /**
     * 获得url的协议+域+路径（即url路径问号左侧的内容）
     * @param url url地址
     * @return url的协议+域+路径
     */
    String getUrlHostAndPath(String url){
        if (url.contains("?")) {
            return url.substring(0, url.indexOf("?"));
        }
        return url;
    }

    int dpToPx(Context context, int dp) {
        float density = context.getResources()
                .getDisplayMetrics()
                .density;
        return Math.round((float) dp * density);
    }

    @Override
    public View getView() {
        return this.imageView;
    }

    @Override
    public void dispose() {

    }
}

class YZGlideUrlWithCacheKey extends GlideUrl {

    private String cacheKey;

    public YZGlideUrlWithCacheKey(String url, String cacheKey) {
        super(url);
        this.cacheKey = cacheKey;
    }

    @Override
    public String getCacheKey() {
        return cacheKey != null ? cacheKey : super.getCacheKey();
    }

}
