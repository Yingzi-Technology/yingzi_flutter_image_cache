#import "YingziFlutterImageCachePlugin.h"
#if __has_include(<yingzi_flutter_image_cache/yingzi_flutter_image_cache-Swift.h>)
#import <yingzi_flutter_image_cache/yingzi_flutter_image_cache-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "yingzi_flutter_image_cache-Swift.h"
#endif

@implementation YingziFlutterImageCachePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYingziFlutterImageCachePlugin registerWithRegistrar:registrar];
}
@end
