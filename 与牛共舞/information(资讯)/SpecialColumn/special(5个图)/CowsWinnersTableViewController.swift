//
//  CowsWinnersTableViewController.swift
//  与牛共舞


//  Created by Mac on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
var isCowMainDown = true

@objc(CowsWinnersTableViewController)
class CowsWinnersTableViewController: UITableViewController,CowsMainerHelperDelegate{

    var cowWinnnerMMMol : CowMinnerModel!
    
    var page = 1
    var CellIdent = "hearSaycell1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        CowMainnerHelper.moneysharedHelper().delegate = self
        self.tableView.separatorStyle = .None
        
        // 注册cell
        tableView.registerClass(CowsWinnerTableViewCell.self, forCellReuseIdentifier: "hearSayCell1")
        
        // 添加头部刷新控件
        weak var weakSelf = self
        self.tableView.addHeaderWithCallback {  () -> Void in
            isCowMainDown = true
            
            CowMainnerHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/481/1?token=8c2f64f08271fc4e43")
        }
        // 添加尾部刷新控件
        self.tableView.addFooterWithCallback { () -> Void in
            isCowMainDown = false
            
            weakSelf!.page += 1
            CowMainnerHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/481/\((weakSelf?.page)!)?token=8c2f64f08271fc4e43")
            
        }
        // 进入页面自动下拉刷新
        self.tableView.headerBeginRefreshing()
    }

    
    // 协议中的方法
    func CowsMainerViewReloadData() {
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            if isCowMainDown == true {
                // 如果是下拉, 就停止头部刷新
                self.tableView.headerEndRefreshing()
            } else {
                // 如果是上提, 就停止尾部刷新
                self.tableView.footerEndRefreshing()
            }
            
            self.tableView.reloadData()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CowMainnerHelper.moneysharedHelper().dataArray.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCellWithIdentifier("hearSayCell1", forIndexPath: indexPath) as! CowsWinnerTableViewCell
        
        let hearModel = CowMainnerHelper.moneysharedHelper().dataArray[indexPath.row] as! CowMinnerModel
        
        cell.configureCellWitModel(hearModel)


        return cell
    }
 
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cowWWW = CowWinnerWebView()
        
        cowWinnnerMMMol = CowMainnerHelper.moneysharedHelper().dataArray[indexPath.row] as! CowMinnerModel
        cowWWW.hidesBottomBarWhenPushed = true
        cowWWW.detailUrl = cowWinnnerMMMol.webUrl
        
        self.navigationController?.pushViewController(cowWWW, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
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
