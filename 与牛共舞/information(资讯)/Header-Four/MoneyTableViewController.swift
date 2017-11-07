//
//  MoneyTableViewController.swift
//  与牛共舞
//
//  Created by Mac on 9/19/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

var isDown = true

var monCFLSModel : MoneyTalkModel!
@objc(MoneyTableViewController)
class MoneyTableViewController: UITableViewController,MoneyNetworkHelperDelegate {

    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorStyle = .None
        // 设置代理
        MoneytalkNetWorkHelper.moneysharedHelper().delegate = self
        
      // 注册cell
        // 添加头部刷新控件   "http://app.yngw518.com/api/news/479/1?token=8c2f64f08271fc4e43"
        weak var weakSelf = self
        self.tableView.addHeaderWithCallback { () -> Void in
            isDown = true
            weakSelf!.page = 1
            // http://appv2.yngw518.com/api.php/news/486/1?token=8c2f64f08271fc4e43
            MoneytalkNetWorkHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/479/1?token=8c2f64f08271fc4e43")
        }
        
        // 添加尾部刷新控件
        self.tableView.addFooterWithCallback { () -> Void in
            isDown = false
            weakSelf!.page += 1
            if (weakSelf?.page >= 10){
                let ALLt = UIAlertView()
                ALLt.addButtonWithTitle("已经到达底部")
            }else{
                MoneytalkNetWorkHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/479/\((weakSelf?.page)!)?token=8c2f64f08271fc4e43")
            }
        }
        // 进入页面的时候进行下拉刷新
        self.tableView.headerBeginRefreshing()
    }
    
    // 协议的方法
    func MoneytableViewReloadData() {
      // 回到主线程刷新UI
       dispatch_async(dispatch_get_main_queue()) { () -> Void in
        if isDown == true{
            // 如果是下拉,就停止头部刷新
            self.tableView.headerEndRefreshing()
        }else{
            // 如果是上提，就停止尾部刷新
            self.tableView.footerEndRefreshing()
        }
        self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MoneytalkNetWorkHelper.moneysharedHelper().dataArray.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell :MoneyTableViewCell!
        let CellID = "MoneyCell"
        if (cell == nil){
            cell = MoneyTableViewCell(style: .Default, reuseIdentifier: CellID)
            
           // 取出数据源中的模型
            let moneyModel = MoneytalkNetWorkHelper.moneysharedHelper().dataArray[indexPath.row] as! MoneyTalkModel
            // 给cell赋值
            cell.configureCellWithModel(moneyModel)
        
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let moyeyWb = MoneyLSWebViewView()
       monCFLSModel = MoneytalkNetWorkHelper.moneysharedHelper().dataArray[indexPath.row] as! MoneyTalkModel
        moyeyWb.detailUrl = monCFLSModel.detailURL
        
        moyeyWb.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(moyeyWb, animated: true)
       
        self.hidesBottomBarWhenPushed = false
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
