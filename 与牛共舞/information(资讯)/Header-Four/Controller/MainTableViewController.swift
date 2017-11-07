//
//  MainTableViewController.swift
//  与牛共舞
//
//  Created by dm on 16/10/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isMainDown = true

@objc(MainTableViewController)
class MainTableViewController: UITableViewController,MainNetWorkHelperDelegagte {

    var page = 1
    
    var mainMMMol : MainModel!
    var mainIdent = "mainCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        MaindataHelper.moneysharedHelper().delegate = self
        self.tableView.backgroundColor = UIColor.whiteColor()
      self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        // 注册cell
        tableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: "mainCell")
        
        // 头部
        weak var weakself = self
        self.tableView.addHeaderWithCallback {  () -> Void in
        isMainDown = true
            
            MaindataHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/485/1?token=8c2f64f08271fc4e43")

        }
       self.tableView.addFooterWithCallback { () -> Void in
        isMainDown = false
        weakself?.page += 1
        
        MaindataHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/485/\((weakself?.page)!)?token=8c2f64f08271fc4e43")

        
        }
       // 进入页面下拉刷新
       self.tableView.headerBeginRefreshing()
    }
    
    // 协议
    func MainTableViewReloadData() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if isMainDown == true {
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
        return MaindataHelper.moneysharedHelper().dataArray.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

  
            let cell = tableView.dequeueReusableCellWithIdentifier(mainIdent, forIndexPath: indexPath) as! MainTableViewCell
        
        let mainModel = MaindataHelper.moneysharedHelper().dataArray[indexPath.row] as! MainModel
        cell.mainconfigureCellWitModel(mainModel)
        
        
        
        
//         cell.photoImage.image = UIImage(named: "22.jpg")

        return cell
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
   

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mainWeb = MainWebViewController()
        
        mainWeb.hidesBottomBarWhenPushed = true
        mainMMMol = MaindataHelper.moneysharedHelper().dataArray[indexPath.row] as! MainModel
        mainWeb.detailUrl = mainMMMol.webUrl
        
        self.navigationController?.pushViewController(mainWeb, animated: true)
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
