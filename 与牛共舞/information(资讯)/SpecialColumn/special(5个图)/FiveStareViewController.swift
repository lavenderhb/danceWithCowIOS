//
//  FiveStareViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit


var isFiveStareDown = true

@objc(FiveStareViewController)
class FiveStareViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,FiveStareHelperDelegate {
    
    var fiveSSMMMl : FiveStareModel!
    
    var page = 1
    
     var  cellId = "fiveStaredIIIID"
//    var
//     tableData = [["title":"swift -- 标签以"], ["title":"swift -- 使用的标签"]]
    
    var tableView:UITableView?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
      // 创建表视图
        self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 64))
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView?.separatorStyle = .None
        FiveStareHelper.moneysharedHelper().delegate = self
     self.view.addSubview(tableView!)
        
        // 添加刷新控件
        weak var weakSelf = self
        self.tableView?.addHeaderWithCallback{ () -> Void in
            isFiveStareDown =  true
            FiveStareHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/493/1?token=8c2f64f08271fc4e43")
            
        }
        // 添加尾部控件
        self.tableView?.addFooterWithCallback{ () -> Void in
            isFiveStareDown = false
            weakSelf?.page += 1
            FiveStareHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/493/\((weakSelf?.page)!)?token=8c2f64f08271fc4e43")
            
        }
        
        self.tableView?.headerBeginRefreshing()
        
    }
    
    // 协议
    func FiveStareViewReloadData() {
        // 主线程
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if isFiveStareDown == true{
                self.tableView?.headerEndRefreshing()
            }else{
                self.tableView?.footerEndRefreshing()
            }
            self.tableView?.reloadData()
        }
        
    }
    
    func rrrr(){
    }
    
    // 这里是服从的协议UITbaleViewDelegate和UITableViewDatasource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FiveStareHelper.moneysharedHelper().dataArray.count
//        return 10
    }
    
    // 返回cell的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    // 创建个单元格的内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : FiveStareTableViewCell!
        
       
        
      cell = FiveStareTableViewCell(style: .Default, reuseIdentifier: cellId)
        
        let ficeModel = FiveStareHelper.moneysharedHelper().dataArray[indexPath.row] as! FiveStareModel
        
        cell.configureCellWithModel(ficeModel)
        
//       cell.timeLael.text = "00000"

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        
        let fiveStareWeb = FiveWenView()
        fiveStareWeb.hidesBottomBarWhenPushed = true
        fiveSSMMMl = FiveStareHelper.moneysharedHelper().dataArray[indexPath.row] as! FiveStareModel
        fiveStareWeb.detailUrl = fiveSSMMMl.webUrl
        
        self.navigationController?.pushViewController(fiveStareWeb, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
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
