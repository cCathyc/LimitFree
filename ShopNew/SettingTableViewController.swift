//
//  SettingTableViewController.swift
//  ShopNew
//
//  Created by caoting on 15/12/22.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit
import SDWebImage
class SettingTableViewController: UITableViewController {

    var dataArr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        dataArr = ["我的收藏", "清除缓存", "我的版本", "我的信息"]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArr.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier = "settingCell"
        let cell = SettingCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: initIdentifier)
        
        cell.textLabel?.text = self.dataArr[indexPath.row] as! String

      
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        if (1 == indexPath.row) {
            
            cell.detailTextLabel!.text = calculateCacheSize()
            cell.detailTextLabel?.textColor = UIColor.blackColor()
        }



        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (2 == indexPath.row) {//当前版本
            let alert = UIAlertView(title: "当前版本号", message: currentVersion!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定")
            alert.show()
        } else if (1 == indexPath.row) { //清楚缓存
            SDImageCache.sharedImageCache().clearDisk()
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
        } else if (0 == indexPath.row) { //点击了我的收藏
           print("点击了我的收藏")
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
