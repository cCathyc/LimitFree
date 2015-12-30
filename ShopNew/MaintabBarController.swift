//
//  MaintabBarController.swift
//  ShopNew
//
//  Created by caoting on 15/12/18.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class MaintabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createSubViewControllers()
        self.setTabBarItems()

    }
    
    func createSubViewControllers(){
        let limitVC = LimitViewController()
       
        limitVC.urlStr = "http://1000phone.net:8088/app/iAppFree/api/limited.php?"
        let limit = UINavigationController(rootViewController: limitVC)
        
          let saleVC = SaleViewController()
        saleVC.urlStr = "http://1000phone.net:8088/app/iAppFree/api/reduce.php?"
        let sale = UINavigationController(rootViewController: saleVC)
        
        let freeVC = FreeViewController()
        freeVC.urlStr = "http://1000phone.net:8088/app/iAppFree/api/free.php?"
        let free = UINavigationController(rootViewController: freeVC)
        
        let subjectVC = SubjectViewController()
        
        let subject = UINavigationController(rootViewController: subjectVC)
        
        let hotVC = HotViewController()
        hotVC.urlStr = "http://1000phone.net:8088/app/iAppFree/api/hot.php?"
        let hot = UINavigationController(rootViewController: hotVC)
   
        self.viewControllers = [limit, sale, free, subject, hot]
    }
    func setTabBarItems(){
        /// 文字数组
        let titleArr = ["限免","降价","免费","专题","热榜"]
        /// 普通图片名数组
        let normalImgArr = ["tabbar_limitfree","tabbar_reduceprice","tabbar_appfree","tabbar_subject","tabbar_account"]
        /// 被选中图片名数组
        let selectImgArr = ["tabbar_limitfree_press","tabbar_reduceprice_press","tabbar_appfree_press","tabbar_subject_press","tabbar_account_press"]
        //循环设置tabBarItem的文字,图片
        for index in 0..<5 {
            let vc = (self.viewControllers as? [UINavigationController])![index]
            vc.tabBarItem = UITabBarItem(title: titleArr[index], image: UIImage(named: normalImgArr[index]), selectedImage: UIImage(named: selectImgArr[index])?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        }
        
        //设置tabBar的背景图片
        self.tabBar.backgroundImage = UIImage(named: "tabbar_bg")
        //UITabBarItem.appearance()拿到最高权限,设置所有tabBarItem的属性
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState: UIControlState.Selected)
        //设置导航栏的字体属性
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(20)]    }
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
