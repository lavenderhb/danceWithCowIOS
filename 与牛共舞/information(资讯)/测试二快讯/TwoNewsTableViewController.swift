//
//  TwoNewsTableViewController.swift
//  与牛共舞
//
//  Created by dm on 16/12/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isTwoNewsDown = true

@objc(TwoNewsTableViewController)
class TwoNewsTableViewController: UITableViewController,TwoNewsWorkHelperDelegagte {

    var page = 1
    
    var timeNumber : Int?
    var mainIdent = "TestNewsCell000"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwoNewsHelper.moneysharedHelper().delegate = self
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        // 注册cell
        tableView.registerClass(TestNewsTableViewCell.self, forCellReuseIdentifier: "TestNewsCell000")
        
        let cellNib = UINib(nibName: "NewsHeaderTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "cell1")
        
        // 头部
        weak var weakself = self
        self.tableView.addHeaderWithCallback {  () -> Void in
            isTwoNewsDown = true
            
            TwoNewsHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/487/1?token=8c2f64f08271fc4e43")
            
        }
        self.tableView.addFooterWithCallback { () -> Void in
            isTwoNewsDown = false
            weakself?.page += 1
            
            TwoNewsHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/487/\((weakself?.page)!)?token=8c2f64f08271fc4e43")
            self.timeNumber = weakself?.page
        }
        // 进入页面下拉刷新
        self.tableView.headerBeginRefreshing()
    }
    
    // 协议
    func TwoNewsTableViewReloadData() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if isTwoNewsDown == true {
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TwoNewsHelper.moneysharedHelper().timeArray.count
//        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TwoNewsHelper.moneysharedHelper().dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            let cell1 = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! NewsHeaderTableViewCell
            let str = TwoNewsHelper.moneysharedHelper().timeArray[indexPath.section]
            // 进行数据请求的时候的分割，然后根据数据的形成来取相应的字段
            let strArr = str.componentsSeparatedByString("-")
            
            cell1.dayLabel.text = strArr[2];
            cell1.monthlabel.text = "\(strArr[1])月";
            
            let mainModel = TwoNewsHelper.moneysharedHelper().dataArray[indexPath.row] as! TestNewsModel
//            cell1.contentfigureWithModel(mainModel)
            
//            cell1.contentfigureWithModel(model)
            cell1.backgroundColor = UIColor.whiteColor()
            cell1.selectionStyle = UITableViewCellSelectionStyle.None
            cell1.backgroundColor = UIColor.redColor()
            cell1.selected = false
            return cell1
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(mainIdent, forIndexPath: indexPath) as! TestNewsTableViewCell
            let mainModel = TwoNewsHelper.moneysharedHelper().dataArray[indexPath.row] as! TestNewsModel
            cell.configureCellWithModel(mainModel)
            cell.backgroundColor = UIColor.whiteColor()
            return cell
        }
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
