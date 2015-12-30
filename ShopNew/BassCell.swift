//
//  BassCell.swift
//  ShopNew
//
//  Created by caoting on 15/12/21.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit
import SDWebImage
/// standardUserDefaults

class BassCell: UITableViewCell {
    var iconIV:UIImageView!
    var titleLabel:UILabel!
    var timeLabel:UILabel!
    var starIV:UIButton!
    var shareLabel:UILabel!
    var priceLabel:UILabel!
    var cateLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 添加cell的子控件
        self.addSubviews()
    }
    func addSubviews(){
        self.backgroundColor = UIColor.grayColor()
         // 图标
        iconIV = BassCell .createImageViewWithFrame(CGRectMake(10, 10, 60, 60))
        self.contentView.addSubview(iconIV)

      
//        // 标题
        titleLabel = BassCell .createLabelWithFrame(CGRectMake(CGRectGetMaxX(iconIV.frame) + 10, 10 - 5, 200, 25), text: "这是标题", font: UIFont.systemFontOfSize(18.0), superView: self.contentView)
//        // 时间
        timeLabel = BassCell .createLabelWithFrame(CGRectMake(80, CGRectGetMaxY(titleLabel.frame) + 0, 200, 15), text: "0000-00-00 00:00:00", font: UIFont.systemFontOfSize(13.0), superView: self.contentView)

//        // 星级
        starIV = UIButton(type: UIButtonType.Custom)
        starIV.frame = CGRectMake(80, CGRectGetMaxY(timeLabel.frame), 65, 23)
        starIV.setBackgroundImage(UIImage(named:"StarsBackground" ), forState: UIControlState.Normal)
        starIV.setImage(UIImage(named:"StarsForeground" ), forState: UIControlState.Normal)
        self.contentView.addSubview(starIV)
       
//        // 分享下载收藏
        shareLabel = BassCell .createLabelWithFrame(CGRectMake(80, CGRectGetMaxY(timeLabel.frame) + 15, 200, 15), text: "分享:0 收藏:0 下载:0", font: UIFont.systemFontOfSize(10.0), superView: self.contentView)

//        
//        // 价格
        priceLabel = BassCell .createLabelWithFrame(CGRectMake(250, 20, 100, 20), text: "$0", font: UIFont.systemFontOfSize(13.0), superView: self.contentView)

//        
//        // 分类
        cateLabel = BassCell .createLabelWithFrame(CGRectMake(250, 49, 100, 20), text: "Game", font: UIFont.systemFontOfSize(13.0), superView: self.contentView)

    }
    func CellWithModel(model:BassModel){
   
        iconIV.sd_setImageWithURL(NSURL(string: model.iconUrl!), placeholderImage: UIImage(named: "appproduct_appdefault"))

        titleLabel.text = model.name
        timeLabel.text = model.expireDatetime
        let value = (model.starCurrent as! NSString).doubleValue
        starIV.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, CGFloat(65 * (5 - value)) / 5)
        starIV.imageView!.clipsToBounds = true
        starIV.imageView!.contentMode = UIViewContentMode.Left
        shareLabel.text = "分享\(model.shares!)次 收藏:\(model.favorites!)次 下载:\(model.downloads!)次"

        priceLabel.text = "价格:$\(model.currentPrice!)"
        cateLabel.text = model.categoryName

    }
    
    class func createImageViewWithFrame(frame:CGRect)->UIImageView{
    let iv = UIImageView(frame: frame)
    iv.backgroundColor = UIColor.lightGrayColor()
    iv.layer.cornerRadius = 10.0
    iv.layer.masksToBounds = true
        return iv;
    }
    
   class func createLabelWithFrame(frame:CGRect,text:String,font:UIFont,superView:UIView)->UILabel{
        let titleLabel = UILabel(frame: frame)

      titleLabel.text = text
    titleLabel.textColor = UIColor.blackColor()
    titleLabel.font = font
    titleLabel.textAlignment = NSTextAlignment.Left
    superView.addSubview(titleLabel)
    return titleLabel;
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
