//
//  SearchViewController.swift
//  ShopNew
//
//  Created by caoting on 15/12/25.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class SearchViewController: UITableViewController {

    var searchText:String!
    var urlStr:String!
    var dataArr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索"
        self.tableView.rowHeight = 60
        //发送请求获取数据
        self.loadData()


        
    }
    func loadData(){
        let str = "\(self.urlStr)page=1&number=20&"
        let dic = ["search": self.searchText]
        Alamofire.request(.GET, str, parameters:dic).responseJSON {response in
            
            //            debugPrint(response)
            switch response.result {
            case .Success:
                //把得到的JSON数据转为字典
                MBProgressHUD .hideHUDForView(self.view, animated: true)
                if let j = response.result.value as? NSDictionary{
                    //获取字典里面的key为数组
                    let Items = j.valueForKey("applications")as! NSArray
                    for dict in Items{
                        let bm = BassModel()
                        bm.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
                        self.dataArr.addObject(bm)
                        
                    }
                 
                    self.tableView .reloadData()
                    
                    
                    
                }
            case .Failure(let error):
                MBProgressHUD .hideHUDForView(self.view, animated: true)
                print(error)
            }
        }

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
        let initIdentifier = "bassCell"
        let cell = SearchCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: initIdentifier)
        let model = self.dataArr[indexPath.row] as! BassModel
        cell.CellWithModel(model)
  
        
        
        return cell

    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = DetailViewController()
        let detail = dataArr[indexPath.row] as! BassModel
        detailVC.appID = detail.applicationId
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    

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
