//
//  DetailView.swift
//  ShopNew
//
//  Created by caoting on 15/12/25.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class DetailView: UIView {
    var scrollBackView:UIScrollView! // 背景滚动视图
    var  detailModel:DetailModel!
    var isLong:Bool!
    var nearAppBackIV:UIImageView!
    var iconIV:UIImageView!
    
    
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func detailViewWith(Model:DetailModel,isLong:Bool){
       self.detailModel = Model
        self.isLong = isLong
        self.frame = CGRectMake(0, 0, ScreenWidth, isLong ? (ScreenHeight) : (ScreenHeight - 49))
       
        
        self.addSubviews()
        
    }
    func addSubviews() {
        // 计算descriptionLabel文本的高度
        let textHeight = Tool.calculateHeightWithText(detailModel.description_long!, size: CGSizeMake(ScreenWidth - 40, 20000), font: UIFont.systemFontOfSize(15.0))
      
       
        // 初始化背景scrollView
        scrollBackView = UIScrollView(frame: CGRectMake(0, 0, ScreenWidth, self.bounds.size.height))
        scrollBackView.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(scrollBackView)
        
        
        // 初始化详情背景图片                                                     
//        原74
        let detailBackIV = UIImageView(frame: CGRectMake(10, 74, ScreenWidth - 20, textHeight + 199 + 27))
        detailBackIV.userInteractionEnabled = true
        let image = UIImage(named: "appdetail_background")
        image?.stretchableImageWithLeftCapWidth(10, topCapHeight: 10)
        detailBackIV.image = image
        scrollBackView.addSubview(detailBackIV)
     
        // 添加detailBackIV的子视图
        let iconIV = BassCell.createImageViewWithFrame(CGRectMake(10, 15, 60, 60))
        iconIV.sd_setImageWithURL(NSURL(string: detailModel.iconUrl!))
        detailBackIV.addSubview(iconIV)
        self.iconIV = iconIV
      
        // 标题
        let titleLabel = BassCell.createLabelWithFrame(CGRectMake(CGRectGetMaxX(iconIV.frame) + 10, 10, 200, 25), text: detailModel.name!, font:UIFont.systemFontOfSize(18.0) , superView: detailBackIV)
        // 价格
        let priceLabel = BassCell.createLabelWithFrame(CGRectMake(CGRectGetMaxX(iconIV.frame) + 10, CGRectGetMaxY(titleLabel.frame) + 2, 200, 20), text:"价格:\(detailModel.name!) 元" , font:UIFont.systemFontOfSize(13.0) , superView: detailBackIV)
        // 类别
         let cateLabel = BassCell.createLabelWithFrame(CGRectMake(CGRectGetMaxX(iconIV.frame) + 10, CGRectGetMaxY(priceLabel.frame) + 2, 200, 15), text:"类别:\(detailModel.categoryName!) " , font:UIFont.systemFontOfSize(13.0) , superView: detailBackIV)

        
        // 星级
        let starLabel = BassCell.createLabelWithFrame(CGRectMake(ScreenWidth - 120, CGRectGetMaxY(priceLabel.frame) + 2, 80, 15), text: "星级:\(detailModel.starCurrent!)", font: UIFont.systemFontOfSize(13.0), superView: detailBackIV)
        cateLabel.textColor = UIColor.blackColor()
        starLabel.textColor = UIColor.blackColor()
     
        // 三个按钮
        let starLabelMaxY = CGRectGetMaxY(starLabel.frame)
        let w = detailBackIV.bounds.size.width / 3
        

        // 分享
        let shareBtn = self.createButtonWith(CGRectMake(0, starLabelMaxY + 10, w, 30), text: "分享", textColor: UIColor.blackColor(), bgImg: UIImage(named: "Detail_btn_left")!, target: self, action: Selector("shareBtnClicked"), superView: detailBackIV)

//        // 收藏
        self.createButtonWith(CGRectMake(w, starLabelMaxY + 10, w, 30), text: "收藏", textColor: UIColor.blackColor(), bgImg: UIImage(named: "Detail_btn_middle")!, target: self, action: Selector("favoriteBtnClicked:"), superView: detailBackIV)

//        // 下载
        self.createButtonWith(CGRectMake(w * 2, starLabelMaxY + 10, w, 30), text: "下载", textColor: UIColor.blackColor(), bgImg: UIImage(named: "Detail_btn_right")!, target: self, action: Selector("downloadBtnClick"), superView: detailBackIV)
      
        // 滑动介绍图片
        let photoSV = UIScrollView(frame: CGRectMake(10, CGRectGetMaxY(shareBtn.frame) + 2, detailBackIV.bounds.size.width - 20, 90))

        photoSV.alwaysBounceHorizontal = true // 总是水平可以滑动
        for var i = 0; i < detailModel.photos!.count;++i {
            let iv = UIImageView(frame: CGRectMake(CGFloat(5 + i * (60 + 5)), 0, 60, 90))
            
            iv.tag = i
            iv.userInteractionEnabled = true
            iv.sd_setImageWithURL(NSURL(string: detailModel.photos![i]["smallUrl"] as!String))
           photoSV.addSubview(iv)
            let click = UITapGestureRecognizer(target: self, action: Selector("imageDidClick:"))
            iv.addGestureRecognizer(click)

        }
        photoSV.contentSize = CGSizeMake(60 * CGFloat(detailModel.photos!.count) + 5 * CGFloat(detailModel.photos!.count + 1), 0)
        detailBackIV.addSubview(photoSV)

        
        
        // 介绍文本
        let descriptionLabel = BassCell.createLabelWithFrame(CGRectMake(10, CGRectGetMaxY(photoSV.frame) + 10, detailBackIV.bounds.size.width - 20, textHeight), text: detailModel.description_long!, font: UIFont.systemFontOfSize(15.0), superView: detailBackIV)
        descriptionLabel.numberOfLines = 0
       
        
        
        // 附近的APPd背景视图
        nearAppBackIV = UIImageView(frame: CGRectMake(10, CGRectGetMaxY(detailBackIV.frame) + 10, ScreenWidth - 20, 100))
        let im = UIImage(named: "appdetail_recommend")
        im?.stretchableImageWithLeftCapWidth(10, topCapHeight: 10)
        nearAppBackIV.image = im
        nearAppBackIV.userInteractionEnabled = true
         scrollBackView.addSubview(nearAppBackIV)
        scrollBackView.contentSize = CGSizeMake(0, CGRectGetMaxY(detailBackIV.frame) + 15 + 110 )


    }
    func createButtonWith(frame:CGRect,text:String,textColor:UIColor,bgImg:UIImage, target:AnyObject,action:Selector,superView:UIView)->UIButton{
        let shareBtn = UIButton(frame: frame)
        shareBtn.setTitle(text, forState: UIControlState.Normal)
        shareBtn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        shareBtn.setTitleColor(textColor, forState: UIControlState.Normal)
        shareBtn.setBackgroundImage(bgImg, forState: UIControlState.Normal)
        superView.addSubview(shareBtn)
        return shareBtn
    }
    func addNearAppIcon(nearAppArr:NSArray){
        let sv = UIScrollView(frame: CGRectMake(5, 20, ScreenWidth - 30, 70))
        nearAppBackIV.addSubview(sv)
      
        // 循环添加附近App的图片
        for (var i = 0; i < nearAppArr.count; ++i) {
            let iv = BassCell.createImageViewWithFrame(CGRectMake(CGFloat(5 + i * (60 + 5)), 5, 60, 60))
            
            iv.userInteractionEnabled = true
            let detaile = nearAppArr[i] as! DetailModel
            iv.sd_setImageWithURL(NSURL(string: detaile.iconUrl!))
            sv.addSubview(iv)
           
            iv.tag = detaile.applicationId! as! Int
            let tap = UITapGestureRecognizer(target: self, action: Selector("jumpToNewDetailController:"))
            iv.addGestureRecognizer(tap)
            
        }
        sv.alwaysBounceHorizontal = true
        sv.contentSize = CGSizeMake(CGFloat(nearAppArr.count * 60 + 5 * (nearAppArr.count + 1)), 0)

    }
    func jumpToNewDetailController(tap:UITapGestureRecognizer){
        
    }
    
//    - (void)jumpToNewDetailController:(UITapGestureRecognizer *)tap {
//    _nearAppBlock(tap.view.tag);
//    }
//    
//    // 详情图片的点击事件
    func imageDidClick(tap:UITapGestureRecognizer){
        
    }
//    - (void)imageDidClick:(UITapGestureRecognizer *)tap {
//    self.photoBlock(tap.view.tag);
//    }
//    
//    // 收藏按钮的点击事件
    func favoriteBtnClicked(btn:UIButton){
        if btn.titleLabel?.text == "收藏" {
            btn.titleLabel?.text = "取消收藏"
        }else{
            btn.titleLabel?.text = "收藏"
        }
    }

    func shareBtnClicked(){
        
    }
    func downloadBtnClick(){
        UIApplication.sharedApplication().openURL(NSURL(string: detailModel.itunesUrl!)!)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
 