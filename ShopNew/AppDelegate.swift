//
//  AppDelegate.swift
//  ShopNew
//
//  Created by caoting on 15/12/17.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var scrollView:UIScrollView?
    var window: UIWindow?
    var VC=MaintabBarController()
 
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //        window?.rootViewController =
        //判断当前版本是否是新版本
        if (currentVersion != saveVersion) {//如果是第一次进入新版本,进入介绍界面
            //保存当前版本号到沙盒
            setObject(currentVersion, forKey: "version")
            gotoScrollView()
        } else {//否则,直接进入TabBarController
            gotoTabBarController()
        }
        window?.makeKeyAndVisible()
        
              self.window?.rootViewController = VC


        
        return true
    }
    /**
    进入介绍页面
    */
    func gotoScrollView() {
        scrollView = UIScrollView(frame: CGRectMake(0, 0, ScreenWidth,ScreenHeight))
        scrollView?.backgroundColor = UIColor.whiteColor()
        scrollView!.pagingEnabled = true
        
        for index in 0...3 {
            var iv = UIImageView(frame: CGRectMake(ScreenWidth * CGFloat(index), 0,ScreenWidth, ScreenHeight))
            iv.userInteractionEnabled = true
            iv.image = UIImage(named: "\(index+1).jpg")
            scrollView!.addSubview(iv)
            if (3 == index) {
                let btn = UIButton(frame: CGRectMake(ScreenWidth/2 - 40, ScreenHeight - 100, 80, 40))
                btn.backgroundColor = UIColor.orangeColor()
                btn.setTitle("进入应用", forState: UIControlState.Normal)
                btn.addTarget(self, action: "gotoTabBarController", forControlEvents: UIControlEvents.TouchUpInside)
                iv.addSubview(btn)
            }
        }
        scrollView!.contentSize = CGSizeMake(ScreenWidth * 4, 0)
        VC.view.addSubview(scrollView!)
       
    }
    
    /**
    进入主界面
    */
    func gotoTabBarController() {
        //移除scrollView
        if (self.scrollView != nil) {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.scrollView!.transform = CGAffineTransformMakeScale(1.5, 1.5)
                self.scrollView!.alpha = 0.5
                }) { (bool:Bool) -> Void in
                    self.scrollView!.removeFromSuperview()
            }
        }
  
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

