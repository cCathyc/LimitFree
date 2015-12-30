//
//  SubjectModel.swift
//  ShopNew
//
//  Created by caoting on 15/12/22.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class SubjectModel: NSObject {
    var applications = NSMutableArray()
    var title:String?
    var img:String?
    var desc_img:String?
    var desc:String?
    var ratingOverall:String?
    var cellHeight:CGFloat?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
