
//
//  ViedioTableView.swift
//  与牛共舞
//
//  Created by dm on 16/11/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isViedioDown = true

@objc(ViedioTableView)
class ViedioTableView: UITableViewController, ViedioGoldDDHelperDelegate {

    
    var viedioMMmm : ViedioGoldModel!
    
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.registerClass(ViedioGoldCell.self, forCellReuseIdentifier: "viedddddCEELLL")
        weak var weakSelf = self
        
        ViedioGoldDDHelper.moneysharedHelper().delegate = self
        
        let nsurl = NSURL(string: "http://appv2.yngw518.com/api.php/news/490/1?token=8c2f64f08271fc4e43")
        
        
        
        self.tableView.addHeaderWithCallback {  () -> Void in
            isViedioDown = true
            
            ViedioGoldDDHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/490/1?token=8c2f64f08271fc4e43")
            
            
        }
        // 添加尾部刷新控件
        self.tableView.addFooterWithCallback { () -> Void in
            isViedioDown = false
            
            weakSelf!.page += 1
            ViedioGoldDDHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/490/2?token=8c2f64f08271fc4e43")
            
        }
        // 进入页面自动下拉刷新
        self.tableView.headerBeginRefreshing()
  
    }
    
    
    
    func ViedioGoldDDViewReloadData() {
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if isViedioDown == true {
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

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ViedioGoldDDHelper.moneysharedHelper().dataArray.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("viedddddCEELLL", forIndexPath: indexPath) as! ViedioGoldCell

        let mmml = ViedioGoldDDHelper.moneysharedHelper().dataArray[indexPath.row] as! ViedioGoldModel
        cell.selectionStyle = UITableViewCellSelectionStyle.None
//        cell.setSelected(false, animated: )
        cell.configureCellWithModel(mmml)
        // Configure the cell...

        return cell
    }
  
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        return 50
//    }
//    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let web = ViedioGoldWebView()
        web.hidesBottomBarWhenPushed = true
        viedioMMmm = ViedioGoldDDHelper.moneysharedHelper().dataArray[indexPath.row] as! ViedioGoldModel
        
        web.detailUrl = viedioMMmm.webUrl
        self.navigationController?.pushViewController(web, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
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
