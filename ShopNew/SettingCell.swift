//
//  SettingCell.swift
//  ShopNew
//
//  Created by caoting on 15/12/23.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

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
    func createInterface(){
        let lineView = UIView(frame: CGRectMake(20, 43, ScreenWidth, 1))

        lineView.alpha = 0.2
        lineView.backgroundColor = UIColor.blackColor()
        self.contentView.addSubview(lineView)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
