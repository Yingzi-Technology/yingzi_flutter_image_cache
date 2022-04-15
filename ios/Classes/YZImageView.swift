//
//  YZImageView.swift
//  yingzi_flutter_image_cache
//
//  Created by 余镜周 on 2022/4/14.
//

import Foundation
import Flutter
import SwiftUI
import Kingfisher

class YZImageViewFactory: NSObject, FlutterPlatformViewFactory {
    var messenger: FlutterBinaryMessenger
    
    init(messenger:FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return YZImageView(frame: frame,viewID: viewId,args: args,messenger: messenger)
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class YZImageView: NSObject, FlutterPlatformView {
    
    let imgView: UIImageView = UIImageView()
    
    init(frame: CGRect,viewID: Int64,args :Any?,messenger :FlutterBinaryMessenger) {
        super.init()
        
        let arguments: Dictionary = args as! Dictionary<String, NSObject>
        
        if (isNotEmpty(arguments["url"])) {
            let url = arguments["url"] as! String;
            
            let width = arguments["width"]
            let height = arguments["height"]
            if (isNotEmpty(width) && isNotEmpty(height)) {
                imgView.frame = CGRect(x: 0, y: 0, width: Double(truncating: width as! NSNumber) , height: Double(truncating: height as! NSNumber));
            }
            
            if (isNotEmpty(arguments["fit"])) {
                let fit = arguments["fit"] as! String;
                if (fit == "contain") {
                    imgView.contentMode = .scaleAspectFit
                } else if (fit == "cover") {
                    imgView.contentMode = .scaleAspectFill
                } else {
                    imgView.contentMode = .scaleAspectFit
                }
            }
            
            var placeholder: UIImage = UIImage()
            if (isNotEmpty(arguments["placeholderPath"])) {
                let placeholderPath = arguments["placeholderPath"] as! String
                let image: UIImage? = self.flutterImageWithName(name: placeholderPath)
                if (image != nil) {
                    placeholder = image!
                }
            }
            
            var cacheKey : String
            
            if (isNotEmpty(arguments["cacheKey"])) {
                
                let userCacheKey = arguments["cacheKey"]
                cacheKey = userCacheKey as! String
                
            } else if (isNotEmpty(arguments["isAutoStableCacheKey"])) {
                
                let isAutoStableCacheKey = (arguments["isAutoStableCacheKey"] as! NSNumber).boolValue
                if (isAutoStableCacheKey && url.contains("?")) {
                    let qIndex = url.firstIndex(of: "?")!
                    cacheKey = String(url[..<qIndex])
                } else {
                    cacheKey = url
                }
                
            } else {
                cacheKey = url
            }
            
            let ires = ImageResource(downloadURL: URL(string: url)!, cacheKey: cacheKey)
            imgView.kf.setImage(with: ires, placeholder: placeholder)
            
        }
        
    }
    
    func view() -> UIView {
        return imgView;
    }
    
    func flutterImageWithName (name: String) -> UIImage? {
        let filename = name.lastPathComponent
        let path = name.stringByDeletingLastPathComponent
        
        var screenScale = UIScreen.main.scale;
        while screenScale > 1 {
            let assetPath = "\(path)/\(screenScale).0x/\(filename)"
            let key = FlutterDartProject.lookupKey(forAsset: assetPath)
            let image = UIImage(named: key, in: Bundle.main, compatibleWith: nil)
            if (image != nil) {
                return image!
            }
            
            screenScale -= 1
        }
        
        let key = FlutterDartProject.lookupKey(forAsset: name)
        return UIImage(named: key, in: Bundle.main, compatibleWith: nil)
    }
    
    func isNotEmpty(_ obj: NSObject?) -> Bool {
        return !(obj == nil || obj is NSNull)
    }

    
}

extension String {

    var ns: NSString {
        return self as NSString
    }

    var pathExtension: String {
        return ns.pathExtension
    }

    var lastPathComponent: String {
        return ns.lastPathComponent
    }

    var stringByDeletingLastPathComponent: String {
        return ns.deletingLastPathComponent
    }

}
