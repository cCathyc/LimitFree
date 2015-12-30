//
//  CateCell.swift
//  ShopNew
//
//  Created by caoting on 15/12/25.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class CateCell: UITableViewCell {
    var iconView:UIImageView?
    var nameLabel:UILabel!
    var detailLabel:UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 添加cell的子控件
        self.createInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func CellWithModel(model:CateModel){
        iconView?.setImageWithURL(NSURL(string: model.picUrl!), placeholderImage: UIImage(named: "appproduct_appdefault"))
 
        
        nameLabel.text = model.categoryCname
        
        detailLabel.text = "限免应用:\(model.limited!) 免费应用:\(model.free!)"
            

    }
    func createInterface(){
        iconView = BassCell.createImageViewWithFrame(CGRectMake(10, 10, 60, 60))
        
        self.contentView.addSubview(iconView!)
        nameLabel = BassCell.createLabelWithFrame(CGRectMake(80, 20, 200, 15), text: "这是标题", font: UIFont.systemFontOfSize(18.0), superView: self.contentView)
        detailLabel = BassCell.createLabelWithFrame(CGRectMake(80, 50, 250, 15), text: "这是描述", font: UIFont.systemFontOfSize(14.0), superView: self.contentView)
      
    }
}
