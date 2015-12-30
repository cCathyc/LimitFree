//
//  ZhuiViewController.swift
//  ShopNew
//
//  Created by caoting on 15/12/17.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import MJRefresh
class ZhuiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CategoryViewControllerDelegate{
    var urlStr:String?
    
    var tableView:UITableView!
    var  searchBar:UISearchBar!
    var  dataArr = NSMutableArray() // 装载数据数组
    
    // 声明刷新的视图变量
    var footerView:MJRefreshAutoNormalFooter!
    var headerView:MJRefreshNormalHeader!
  
    var   pageNumber:Int = 1 // 记录页数
    
    var  isCate:Bool = false
    var  cateID:String = "" //记录传过来的cateID
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavItem()// 创建导航元素项
        self.createUI()

    }
    func createUI(){
     
      self.automaticallyAdjustsScrollViewInsets = false
      self.tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49), style: UITableViewStyle.Plain)
        
        self.tableView?.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
//        self.tableView.rowHeight = [BaseCell cellHeight];
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        self.view.addSubview(self.tableView!)
        // 创建searchBar
        let  searchBar = UISearchBar(frame: CGRectMake(0, 0, ScreenWidth, 44))
        
        searchBar.delegate = self
        searchBar.placeholder = "请输入您要搜索的应用"
        searchBar.showsCancelButton = true
        searchBar.showsBookmarkButton = true
       self.searchBar = searchBar;
        self.tableView?.tableHeaderView = searchBar
        self.loadData("1", isRemovedAll: false, cateID:"", isCate: false)
        self.creatRefresh()
        
    }
    func creatRefresh(){
        headerView = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("headerLoadData"))
        tableView.header = headerView
        footerView = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("footerLoadData"))
        footerView.setTitle("上拉加载更多", forState: MJRefreshStateIdle)
        footerView.setTitle("松开加载更多", forState: MJRefreshStatePulling)
        footerView.setTitle("正在加载", forState: MJRefreshStateRefreshing)
        footerView.setTitle("没有更多了", forState: MJRefreshStateNoMoreData)

        tableView.footer = footerView
        
        //下拉刷新
        /*
        _headerView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderView)];
        shoplist.header = _headerView;
        
        _footerView = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooterView)];
        [_footerView setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [_footerView setTitle:@"松开加载更多" forState:MJRefreshStatePulling];
        [_footerView setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
        [_footerView setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
        shoplist.footer = _footerView;

        */
     
//        self.tableView.header.beginRefreshing()
//        self.tableView.footer.setRefreshingTarget(self, refreshingAction: Selector("footerLoadData"))
//        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            // 进入刷新状态后会自动调用这个block
//            }];
//        或
//        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//        
//        // 马上进入刷新状态
//        [self.tableView.header beginRefreshing];

    }
    func headerLoadData(){
        self.loadData("1", isRemovedAll: true, cateID:self.cateID, isCate: isCate)
        
    }
    func footerLoadData(){
        pageNumber += 1
        let str = "\(pageNumber)"
        
      
      self.loadData(str, isRemovedAll:false, cateID: self.cateID, isCate: isCate)
     

        
    }
    func loadData(page:String,isRemovedAll:Bool,cateID:String,isCate:Bool){
    
        
//        // 呈现缓冲视图,告诉用户正在加载数据
        var str = ""
         MBProgressHUD .showHUDAddedTo(self.view, animated: true)
        str = "page=\(pageNumber)&number=20"
               if isCate && cateID != "0"{
           str = "page=\(pageNumber)&number=20&cate_id=\(cateID)"
              
        }
        let url = self.urlStr!+"\(str)"
        Alamofire.request(.POST, url, parameters:nil).responseJSON {response in
            
            //            debugPrint(response)
            switch response.result {
            case .Success:
                //把得到的JSON数据转为字典
                 MBProgressHUD .hideHUDForView(self.view, animated: true)
                if let j = response.result.value as? NSDictionary{
                    //获取字典里面的key为数组
                    let Items = j.valueForKey("applications")as! NSArray
                    //便利数组得到每一个字典模型
                    if isRemovedAll{
                        self.dataArr = []
                    }
                    for dict in Items{
                        let bm = BassModel()
                        bm.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
                        self.dataArr.addObject(bm)
              
                    }
                   self.headerView.endRefreshing()
                    self.footerView.endRefreshing()
                    self.tableView .reloadData()
                    

                    
                }
            case .Failure(let error):
                MBProgressHUD .hideHUDForView(self.view, animated: true)
                print(error)
            }
        }
    }
    func createNavItem(){
        // 设置左上角分类按钮
        let leftBtn = UIButton(type: UIButtonType.Custom)
        leftBtn.frame = CGRectMake(0, 0, 50, 32)
        leftBtn.setTitle("分类", forState: UIControlState.Normal)
        leftBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        leftBtn.setBackgroundImage(UIImage(named: "buttonbar_action"), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action: Selector("jumpCateVC"), forControlEvents:UIControlEvents.TouchUpInside)
       self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        // 设置右上角分类按钮
        let rightBtn = UIButton(type: UIButtonType.Custom)
        rightBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        rightBtn.frame = CGRectMake(0, 0, 50, 32)
        rightBtn.setTitle("设置", forState: UIControlState.Normal)
        rightBtn.setBackgroundImage(UIImage(named: "buttonbar_action"), forState: UIControlState.Normal)
        rightBtn.addTarget(self, action: Selector("jumpSettingVC"), forControlEvents:UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
    
    }
    // 点击导航栏分类按钮
     func jumpCateVC(){
    let category = CategoryViewController()
    category.hidesBottomBarWhenPushed = true
    category.delegate = self
    self.navigationController?.pushViewController(category, animated: true)
  
    }
    // 点击导航栏设置按钮
   func jumpSettingVC() {
    let settingVC = SettingTableViewController()
 
    settingVC.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(settingVC, animated: true)
    }

    func categoryViewControllWith(cateID:String) {
    self.isCate = true
    self.cateID = cateID
        if self.cateID == "0" {
            self.isCate = false
        }
    self.loadData("1", isRemovedAll: true, cateID: self.cateID, isCate: self.isCate)
   
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier = "bassCell"
        let cell = BassCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: initIdentifier)
        let model = self.dataArr[indexPath.row] as! BassModel
        cell.CellWithModel(model)
        tableView.rowHeight = 80.0
        
    
          return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let VC =  DetailViewController()
        let bassModel = dataArr[indexPath.row] as!BassModel
        VC.appID = bassModel.applicationId
        VC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(VC, animated: true)
    }
    // 拖动tableView时退出编辑状态
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

    // 点击searchBar取消按钮时调用
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.text = ""
    }

    // 点击searchBar搜索按钮时调用
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        let searchVC = SearchViewController()
        
        searchVC.urlStr = self.urlStr
        searchVC.searchText = searchBar.text
        searchBar.text = ""
        searchVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC, animated: true)

    }



   
}
