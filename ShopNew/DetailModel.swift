//
//  DetailModel.swift
//  ShopNew
//
//  Created by caoting on 15/12/25.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class DetailModel: NSObject {
    var applicationId:String? // 应用id
    var iconUrl:String? // 图片路径
    var name:String?  // 图片名字
    var currentPrice:String? // 价格
    var categoryName:String? // 分类名
    var starCurrent:String? // 星级
    var description_long:String?  // 描述
    var itunesUrl:String? // itunes路径
    var photos:NSArray? // 滑动图片数组
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        //防止崩溃
    }
}
