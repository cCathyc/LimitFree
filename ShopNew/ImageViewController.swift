//
//  ImageViewController.swift
//  ShopNew
//
//  Created by caoting on 15/12/28.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController,UIScrollViewDelegate {

    var num:Int?
    var  photos = NSArray()
    var  lastPage:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        let sv = UIScrollView(frame: CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64))

        sv.showsHorizontalScrollIndicator = false
        sv.pagingEnabled = true
        sv.delegate = self
        
        for (var i = 0; i < self.photos.count; ++i) {
            let imgView = UIImageView(frame: CGRectMake((CGFloat(i) * ScreenWidth), -64, ScreenWidth, ScreenHeight - 64))
            imgView.userInteractionEnabled = true
            let  dict  =  photos[i] as! NSDictionary
            imgView.sd_setImageWithURL(NSURL(string: dict["originalUrl"] as! String))
            imgView.contentMode = UIViewContentMode.ScaleAspectFit
            sv.addSubview(imgView)
            if num == i {
                sv.contentOffset = CGPointMake(CGFloat(i) * ScreenWidth, 0)
                self.title = "\(num!+1)/\(photos.count)"
            }
            let rotation = UIRotationGestureRecognizer(target: self, action:Selector("rotation:"))
            imgView.addGestureRecognizer(rotation)
            let pinch = UIPinchGestureRecognizer(target: self, action:Selector("pinch:"))
            imgView.addGestureRecognizer(pinch)
            imgView.tag = i
            
        
        }
        sv.contentSize = CGSizeMake(CGFloat(photos.count) * ScreenWidth, 0)
        self.view.addSubview(sv)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollW = scrollView.frame.size.width
        let page = (Int((scrollView.contentOffset.x + scrollW * 0.5)/scrollW))
        if lastPage != page{
            self.title = "\(num!+1)/\(photos.count)"
            lastPage = page
        }
        
    }
    func rotation(rotation:UIRotationGestureRecognizer){
        if (rotation.state == UIGestureRecognizerState.Changed) {
            let angle = rotation.rotation
            rotation.view!.transform = CGAffineTransformRotate(rotation.view!.transform, angle)
            rotation.rotation = 0
        }
    }

    func pinch(pinch:UIPinchGestureRecognizer){
        if (pinch.state == UIGestureRecognizerState.Changed) {
          
            pinch.view!.transform = CGAffineTransformScale(pinch.view!.transform, pinch.scale , pinch.scale )
            pinch.scale = 1
        }

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
