//
//  CateModel.swift
//  ShopNew
//
//  Created by caoting on 15/12/25.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class CateModel: NSObject {

    var categoryId:String?
    var picUrl:String?
    var categoryCname:String?
    var limited:String?
    var free:String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        //防止崩溃
    }
}
