//
//  CategoryViewController.swift
//  ShopNew
//
//  Created by caoting on 15/12/25.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import MJRefresh

protocol CategoryViewControllerDelegate {
    func  categoryViewControllWith(cateID:String)
}
class CategoryViewController: UITableViewController {

    var delegate : CategoryViewControllerDelegate?
    var dataArr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "分类"
      
       self.tableView.rowHeight = 80
        self.loadData()
        
    }
    func loadData(){
     
        MBProgressHUD .showHUDAddedTo(self.view, animated: true)
        let url = "http://1000phone.net:8088/app/iAppFree/api/appcate.php"
        Alamofire.request(.POST, url, parameters:nil).responseJSON {response in
            
            //            debugPrint(response)
            switch response.result {
            case .Success:
                //把得到的JSON数据转为字典
                MBProgressHUD .hideHUDForView(self.view, animated: true)
                let Items = response.result.value as? NSArray
                
                    //便利数组得到每一个字典模型
                  for dict in Items!{
                        let cm = CateModel()
                        cm.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
                        self.dataArr.addObject(cm)
                        
                    }
                 
                    self.tableView .reloadData()
                    
                    
                    
               
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
       
        return dataArr.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier = "cateCell"
        let cell = CateCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: initIdentifier)
        
        let model = self.dataArr[indexPath.row] as! CateModel
        cell.CellWithModel(model)
        
        
        return cell
    
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = dataArr[indexPath.row] as! CateModel
       self.delegate?.categoryViewControllWith(model.categoryId!)
        self.navigationController?.popViewControllerAnimated(true)
  
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
