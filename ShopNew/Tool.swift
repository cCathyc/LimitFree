//
//  Tool.swift
//  ShopNew
//
//  Created by caoting on 15/12/18.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit
import SDWebImage

let userDefault = NSUserDefaults.standardUserDefaults()
func setObject(obj:AnyObject?,forKey:String) {
    userDefault.setObject(obj, forKey: forKey)
    userDefault.synchronize()
}
let kMAIN_SIZE = UIScreen.mainScreen().bounds
let ScreenWidth = UIScreen.mainScreen().bounds.width
let ScreenHeight = UIScreen.mainScreen().bounds.height
/// 当前版本号
let currentVersion:String? = {
    let infoDict = NSBundle.mainBundle().infoDictionary
    //取出当前应用版本号
    let currentVersion = infoDict![(kCFBundleVersionKey as? String)!] as? String
    return currentVersion
    }()
/// 保存的版本号
let saveVersion = NSUserDefaults.standardUserDefaults().objectForKey("version") as? String

/// standardUserDefaults


func calculateCacheSize() -> String{
    var cacheSize = SDImageCache.sharedImageCache().getSize()
    if (cacheSize < 1024) {
        return "\(cacheSize)B"
    } else if (cacheSize < 1024 * 1024) {
        return "\(cacheSize/1024)KB"
    } else if (cacheSize < 1024 * 1024 * 1024) {
        return "\(cacheSize/1024/1024)MB"
    }
    return "\(cacheSize)B"
}
class Tool: NSObject {
// NSUserDefaults 存值
   class func setBool(value:Bool,key:String){
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func setObject(value:AnyObject,key:String){
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()


    }
// NSuserDefaults 取值
//   class func ObjectForKey(key:String)->AnyObject{
// 
//      return  NSUserDefaults.standardUserDefaults().objectForKey(key)!
//    }
   class func setBoolForKey(key:String)->Bool{
        return  NSUserDefaults.standardUserDefaults().objectIsForcedForKey(key)
    }
    

   class func calculateHeightWithText(text:String,size:CGSize,font:UIFont)->CGFloat{
        return text.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:[ NSFontAttributeName:font], context: nil).height
    }
}
