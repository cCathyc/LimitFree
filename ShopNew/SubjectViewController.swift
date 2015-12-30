//
//  SubjectViewController.swift
//  ShopNew
//
//  Created by caoting on 15/12/21.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import MBProgressHUD
class SubjectViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
       var tableView:UITableView!
       var dataArr = NSMutableArray()
       var  height:CGFloat!
    var footerView:MJRefreshAutoNormalFooter!
    var headerView:MJRefreshNormalHeader!
    
    var   pageNumber:Int = 1 // 记录页数

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "专题"
        self.createTableView()
        self.loadDataWithPageNumber(pageNumber, isRemoveAll: false)
        self.createReFresh()
   


    }
    func createTableView(){
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 400
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(tableView)
    }
    func loadDataWithPageNumber(pageNumber:Int,isRemoveAll:Bool){
        // 呈现缓冲视图,告诉用户正在加载数据
        MBProgressHUD .showHUDAddedTo(self.view, animated: true)
        let str = "http://1000phone.net:8088/app/iAppFree/api/topic.php?page=\(pageNumber)&number=5"
        
        Alamofire.request(.POST, str, parameters:nil).responseJSON {response in
            
            //            debugPrint(response)
            switch response.result {
            case .Success:
                //把得到的JSON数据转为字典
                MBProgressHUD .hideHUDForView(self.view, animated: true)
                if let backData = response.result.value as? NSMutableArray{
//                    //获取字典里面的key为数组
//                    let Items = j.valueForKey("applications")as! NSArray
                    //便利数组得到每一个字典模型
                    if isRemoveAll{
                        self.dataArr = []
                    }
                    for dict in backData{
                        let bm = SubjectModel()
                        bm.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
                        self.dataArr.addObject(bm)
                        
                    }
                    self.tableView .reloadData()
                    self.headerView.endRefreshing()
                    self.footerView.endRefreshing()
                    
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                    
                    
                    
                }
            case .Failure(let error):
                MBProgressHUD .hideHUDForView(self.view, animated: true)
                self.headerView.endRefreshing()
                self.footerView.endRefreshing()
                print(error)
            }
        }



    }
    func createReFresh(){
        headerView = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("headerLoadData"))
        tableView.header = headerView
        footerView = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("footerLoadData"))
        footerView.setTitle("上拉加载更多", forState: MJRefreshStateIdle)
        footerView.setTitle("松开加载更多", forState: MJRefreshStatePulling)
        footerView.setTitle("正在加载", forState: MJRefreshStateRefreshing)
        footerView.setTitle("没有更多了", forState: MJRefreshStateNoMoreData)
        
        tableView.footer = footerView

    }
    
    func headerLoadData(){
        self.loadDataWithPageNumber(pageNumber, isRemoveAll: true)
        
    }
    func footerLoadData(){
        pageNumber += 1

        self.loadDataWithPageNumber(pageNumber, isRemoveAll: false)
        }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier = "bassCell"
        let cell = SubjectCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: initIdentifier)
        
        let model = self.dataArr[indexPath.row] as! SubjectModel
            cell.CellWithModel(model)
        
        
   
        
        
        return cell

    }
        
    }


    

 


