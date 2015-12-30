//
//  SubjectCell.swift
//  ShopNew
//
//  Created by caoting on 15/12/22.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit
import SDWebImage
class SubjectCell: UITableViewCell {
    var titleLabel:UILabel?
    var bigIV:UIImageView?
    var smallIV:UIImageView?
    var descLabel:UILabel?
    var model:SubjectModel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 添加cell的子控件
        self.addSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviews(){
        titleLabel = BassCell.createLabelWithFrame(CGRectMake(10, 10, 200, 20), text: "这是标题", font: UIFont.systemFontOfSize(15.0), superView: self.contentView)
        let bigIVW:CGFloat = ScreenWidth * 0.5 - 10
        bigIV = UIImageView(frame: CGRectMake(10, CGRectGetMaxY(titleLabel!.frame) + 10, bigIVW, bigIVW * 1.5))
        self.contentView.addSubview(bigIV!)
        smallIV = UIImageView(frame: CGRectMake(10, CGRectGetMaxY(bigIV!.frame) + 10, 50, 50))
        smallIV?.backgroundColor = UIColor.lightGrayColor()
        self.contentView.addSubview(smallIV!)
        descLabel = BassCell.createLabelWithFrame(CGRectMake(CGRectGetMaxX(smallIV!.frame) + 5, CGRectGetMaxY(bigIV!.frame) + 10, ScreenWidth - 75, 50), text: "哈哈哈", font: UIFont.systemFontOfSize(14.0), superView: self.contentView)
        descLabel?.numberOfLines = 0

    }
   func CellWithModel(model:SubjectModel){
    self.model = model
    titleLabel?.text = model.title
    bigIV?.sd_setImageWithURL(NSURL(string: model.img!))
    smallIV?.sd_setImageWithURL(NSURL(string: model.desc_img!))
    descLabel?.text = model.desc
    let descLabelHeight = Tool.calculateHeightWithText(model.desc!, size: CGSizeMake(ScreenWidth - 75, 20000), font: UIFont.systemFontOfSize(14.0))
    var frame = descLabel?.frame
    frame?.size.height = descLabelHeight
    descLabel?.frame = frame!
    
    let smallLabelMaxY = CGRectGetMaxY(smallIV!.frame) + 10
    let descLabelMaxY = CGRectGetMaxY(descLabel!.frame) + 10
    model.cellHeight = max(smallLabelMaxY, descLabelMaxY)
    self.createAppView()

    }
    func createAppView(){
        for  view in self.contentView.subviews{
            if view.tag == 100{
                view.removeFromSuperview()
            }
        }
        let appCount = self.model.applications.count
        var i:Int
        for ( i = 0;i<appCount;i++){
            let view = AppView.appViewWith(CGRectMake(CGRectGetMaxX(bigIV!.frame) + 5, CGRectGetMaxY(titleLabel!.frame) + 10 + CGFloat(i * (50 + 3)), bigIV!.frame.size.width - 5, 50), dict: model.applications[i] as! NSDictionary)
            view.tag = 100
            self.contentView.addSubview(view)
            
        }


    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
