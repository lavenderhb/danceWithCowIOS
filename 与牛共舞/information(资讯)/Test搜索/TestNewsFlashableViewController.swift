//
//  TestNewsFlashableViewController.swift
//  与牛共舞
//
//  Created by dm on 16/12/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isTestNews = true

@objc(TestNewsFlashableViewController)
class TestNewsFlashableViewController: UITableViewController,TestNewsFlashHelperDelegate {

    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .None
        TestNewsFlashHelper.moneysharedHelper().delegate = self
        
        // 添加头部控件
        weak var weakSelf = self
        self.tableView.addHeaderWithCallback { () -> Void in
            isTestNews = true
//            weakSelf!.page  = 1
            TestNewsFlashHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/478/1?token=8c2f64f08271fc4e43")
        }
        // 尾部   ((weakSelf?.page)!)
        self.tableView.addFooterWithCallback { () -> Void in
            weakSelf!.page += 1
            TestNewsFlashHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/478/2?token=8c2f64f08271fc4e43")
            // \((weakSelf?.page)!)
        }
        self.tableView.headerBeginRefreshing()
    }
    
    
    func TestNewsFlashReloadData() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if isTestNews == true{
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
        return TestNewsFlashHelper.moneysharedHelper().dataArray.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : TestNewsTableViewCell!
        let cellID = "TestNewsCell000"
        if (cell == nil){
            cell = TestNewsTableViewCell(style: .Default, reuseIdentifier: cellID)
            let model = TestNewsFlashHelper.moneysharedHelper().dataArray[indexPath.row] as! TestNewsModel
            cell.configureCellWithModel(model)
            
        }
        
        return cell
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
