//
//  MyNavigationController.swift
//  ShopNew
//
//  Created by caoting on 15/12/17.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取手势的代理
    let target = self.interactivePopGestureRecognizer?.delegate
        //添加手势 有移动手势就调用代理
     let pan = UIPanGestureRecognizer(target: target, action:Selector( "handleNavigationTransition:"))
         pan.delegate = self;
        //将手势添加到view上
         self.view .addGestureRecognizer(pan)
        // 禁止使用系统自带的滑动手势
        self.interactivePopGestureRecognizer?.enabled = false
        
        
    }
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        //如果不是第一个控制器就返回上一个控制器
        if(self.childViewControllers.count==1){
            return false
        }
        return true
    }
    
    func handleNavigationTransition(pan: UIPanGestureRecognizer){
        self.navigationController?.popViewControllerAnimated(true)
    }
    


}
