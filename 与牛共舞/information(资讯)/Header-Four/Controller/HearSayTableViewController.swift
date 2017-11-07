//
//  HearSayTableViewController.swift
//  与牛共舞
//
//  Created by dm on 16/9/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isHearSayDown = true
@objc(HearSayTableViewController)

class HearSayTableViewController: UITableViewController,HearSayNetworkHelperDelegate {

    var page = 1
    var hearPPModel : HearSayModel!
    
    var CellIdent = "hearSaycell"
    override func viewDidLoad() {
        super.viewDidLoad()
  
        HearSayHelper.moneysharedHelper().delegate = self
        tableView.delegate = self
         tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // 注册cell
       tableView.registerClass(HearSayTableViewCell.self, forCellReuseIdentifier: "hearSayCell")
        
        // 添加头部刷新控件
        weak var weakSelf = self
        self.tableView.addHeaderWithCallback {  () -> Void in
            isHearSayDown = true
           
            HearSayHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/484/1?token=8c2f64f08271fc4e43")
        }
        // 添加尾部刷新控件
        self.tableView.addFooterWithCallback { () -> Void in
            isHearSayDown = false
            
            weakSelf!.page += 1
            HearSayHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/484/\((weakSelf?.page)!)?token=8c2f64f08271fc4e43")
            
        }
     
//            HearSayHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://yngwtest.gotoip1.com/api.php/news/478/1?token=8c2f64f08271fc4e43")


        
        // 进入页面自动下拉刷新
        self.tableView.headerBeginRefreshing()
        
    }
    

    // 协议中的方法
    func HearSayTableViewReloadData() {
        
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            if isHearSayDown == true {
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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HearSayHelper.moneysharedHelper().dataArray.count
    }

    
    
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("hearSayCell", forIndexPath: indexPath) as! HearSayTableViewCell
       
        let hearModel = HearSayHelper.moneysharedHelper().dataArray[indexPath.row] as! HearSayModel
        cell.configureCellWitModel(hearModel)
        
        return cell
     
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let hearWeb = HearsayWebView()
        hearPPModel = HearSayHelper.moneysharedHelper().dataArray[indexPath.row] as! HearSayModel
        hearWeb.detailUrl = hearPPModel.webUrl
        hearWeb.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(hearWeb, animated: true)
        self.hidesBottomBarWhenPushed = false
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
