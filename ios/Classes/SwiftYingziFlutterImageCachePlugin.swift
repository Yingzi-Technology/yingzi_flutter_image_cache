import Flutter
import UIKit

public class SwiftYingziFlutterImageCachePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "yingzi_flutter_image_cache", binaryMessenger: registrar.messenger())
    let instance = SwiftYingziFlutterImageCachePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
      let factory = YZImageViewFactory(messenger: registrar.messenger())
      registrar.register(factory, withId: "com.yingzi.view/yingzi_flutter_image_cache")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
