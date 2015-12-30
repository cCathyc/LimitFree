//
//  AppView.swift
//  ShopNew
//
//  Created by caoting on 15/12/22.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class AppView: UIView {

    override  init(frame: CGRect) {
       super.init(frame: frame)
        
    }
    class func appViewWith(frame:CGRect,dict:NSDictionary)->UIView

 {
   let view =  AppView(frame: frame)
    
    view.createViews(dict)
    return view
    
    }
     func createViews(views:NSDictionary) {
        let iconIV = UIImageView(frame: CGRectMake(0, 1, 48, 48))
        iconIV.layer.cornerRadius = 24.0
        iconIV.layer.masksToBounds = true
        iconIV.sd_setImageWithURL(NSURL(string: views["iconUrl"] as! String))
        self.addSubview(iconIV)
        
        let titleLabel = BassCell.createLabelWithFrame(CGRectMake(50, 1, 100, 15), text: views["name"] as!String, font: UIFont.systemFontOfSize(10.0), superView: self)
        
        let commentLabel = BassCell.createLabelWithFrame(CGRectMake(50, 16, 100, 15), text: views["ratingOverall"] as! String, font: UIFont.systemFontOfSize(10.0), superView: self)
        let str = "下载"
        let str1 = views["downloads"] as! String
        let downLabel = BassCell.createLabelWithFrame(CGRectMake(ScreenWidth / 2 - 80, 16, 80, 15), text: str+str1, font: UIFont.systemFontOfSize(10.0), superView: self)
        let iv = UIImageView(image: UIImage(named: "StarsForeground"))
        iv.contentMode = UIViewContentMode.BottomLeft
        iv.clipsToBounds = true
        let str2 = views["starOverall"] as!NSString
        let a:CGFloat = CGFloat(str2.doubleValue)
        iv.frame = CGRectMake(50, CGRectGetMaxY(downLabel.frame), 65/5*a, 23)
        self.addSubview(iv)



    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
