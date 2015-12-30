//
//  SearchCell.swift
//  ShopNew
//
//  Created by caoting on 15/12/25.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    var iconIV:UIImageView?
    var titleLabel:UILabel!
    var timeLabel:UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 添加cell的子控件
        self.createInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func CellWithModel(model:BassModel){

        
        iconIV?.setImageWithURL(NSURL(string: model.iconUrl!), placeholderImage: UIImage(named: "appproduct_appdefault"))
        
        
        titleLabel.text = model.name
        
        timeLabel.text = model.expireDatetime
    }
    
    func createInterface(){
         iconIV = BassCell.createImageViewWithFrame(CGRectMake(10, 5, 50, 50))
            self.contentView.addSubview(iconIV!)

        
        titleLabel = BassCell.createLabelWithFrame(CGRectMake(CGRectGetMaxX(iconIV!.frame) + 10, 5, 200, 25), text: "这是标题", font: UIFont.systemFontOfSize(15.0), superView: self.contentView)
        
        
        timeLabel = BassCell.createLabelWithFrame(CGRectMake(CGRectGetMaxX(iconIV!.frame) + 10, CGRectGetMaxY(titleLabel!.frame), 200, 25), text: "0000-00-00 00:00:00", font: UIFont.systemFontOfSize(12.0), superView: self.contentView)
   
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
