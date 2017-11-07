//
//  EveryDayViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isEveryDown = true

@objc(EveryDayViewController)
class EveryDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,EveryELEHelperDelegate{

     var page = 1

    var eveDDModel : EveryDayModel!
    
    var AllEveryTableview : UITableView!
    // ID
    var EveryCellIdent = "MondayCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        AllEveryTableview = UITableView(frame:CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        EveryELECHelper.everyysharedHelp().delegate = self
        AllEveryTableview.backgroundColor = UIColor.whiteColor()
        AllEveryTableview.delegate = self
        AllEveryTableview.dataSource = self
        
        self.AllEveryTableview.separatorStyle = .None
        // 注册cell
        let cellNib = UINib(nibName: "MoneyDayCell", bundle: nil)
        AllEveryTableview.registerNib(cellNib, forCellReuseIdentifier: EveryCellIdent)
        
        self.view.addSubview(AllEveryTableview)
        
        weak var weakSelf = self
        AllEveryTableview.addHeaderWithCallback {  () -> Void in
            isEveryDown = true
            weakSelf!.page = 1
            EveryELECHelper.everyysharedHelp().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/478/1?token=8c2f64f08271fc4e43")
        }
        // 添加尾部刷新控件
        AllEveryTableview.addFooterWithCallback { () -> Void in
            isEveryDown = false
            
            weakSelf!.page += 1
            EveryELECHelper.everyysharedHelp().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/478/\((weakSelf?.page)!)?token=8c2f64f08271fc4e43")
            
        }
        
        // 进入页面的时候进行下拉刷新
        AllEveryTableview.headerBeginRefreshing()
        
        // Do any additional setup after loading the view.
    }
    
    
    // 协议中的方法
    func EverytableViewReloadData() {
        // 回到主线程
        dispatch_async(dispatch_get_main_queue()) { 
            if isEveryDown == true{
                self.AllEveryTableview.headerEndRefreshing()
            }else{
                self.AllEveryTableview.footerEndRefreshing()
            }
            self.AllEveryTableview.reloadData()
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EveryELECHelper.everyysharedHelp().dataArraty.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCellWithIdentifier(EveryCellIdent.self, forIndexPath: indexPath) as! MoneyDayCell
        let eveModel = EveryELECHelper.everyysharedHelp().dataArraty[indexPath.row] as! EveryDayModel
        // 给cell赋值
        cell.configureCellWithModel(eveModel)
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      
        
      let eveWerb = EvEdayWEbView()
     eveDDModel = EveryELECHelper.everyysharedHelp().dataArraty[indexPath.row] as! EveryDayModel
     eveWerb.detailUrl = eveDDModel.WEbuRL
        eveWerb.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(eveWerb, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  

}
