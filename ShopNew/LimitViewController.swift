//
//  LimitViewController.swift
//  ShopNew
//
//  Created by caoting on 15/12/21.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit
typealias MyBlock = (Int) -> ()
class LimitViewController: ZhuiViewController {

    var  block:MyBlock = {a  in }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "限免"
        // 添加滑动手势
        self.addGestures()
    }
    func addGestures(){
        let swipe = UISwipeGestureRecognizer(target: self, action: Selector("swipe:"))
            swipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipe)
      
    }
    func swipe(swipe:UISwipeGestureRecognizer){
        self.block(1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
