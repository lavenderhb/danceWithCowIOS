//
//  PZBBTableViewController.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isPZBBDown = true

@objc(PZBBTableViewController)
class PZBBTableViewController: UITableViewController, PZBBHelperDelegate {

    var pzMMMl : PZBBModel!
    var page = 1
    var PZBBCellIdent = "PZcell"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "盘中播报"
        
//        let navigationTitleAttribute: NSDictionary = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
        
        //   var attr: NSMutableDictionary! = [NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)]
        // 实现数据的进行新的分析
        
        let uiviewww = UIView(frame: CGRectMake(0, 0, 120, 30))
        uiviewww.backgroundColor = UIColor.clearColor()
        
        let labell = UILabel(frame: CGRectMake(40, 0, 80, 30))
        labell.text = "盘中播报"
        labell.textColor = UIColor.whiteColor()
        labell.font = UIFont.systemFontOfSize(18)
        uiviewww.addSubview(labell)
        
        self.navigationItem.titleView = uiviewww
        
        
        let button116 = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button116.setImage(UIImage(named: "968"), forState: UIControlState.Normal)
        button116.backgroundColor = UIColor.clearColor()
        button116.addTarget(self, action: #selector(HomeViewController.searchBarView), forControlEvents: UIControlEvents.TouchUpInside)
        button116.adjustsImageWhenHighlighted = false
        let barBUtton1161 = UIBarButtonItem(customView: button116)
        
        self.navigationItem.rightBarButtonItem = barBUtton1161
        
        
        PZBBhelper.moneysharedHelper().delegate = self
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .None
   
        tableView.registerClass(PZBBTableViewCell.self, forCellReuseIdentifier: PZBBCellIdent)
        // 添加头部刷新控件
        weak var weakSelf = self
        self.tableView.addHeaderWithCallback {  () -> Void in
            isPZBBDown = true
            // http://yngwtest.gotoip1.com/api.php/search?kwords=%E8%82%A1%E7%A5%A8&page=1&token=8c2f64f08271fc4e43
            PZBBhelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/492/1?token=8c2f64f08271fc4e43")
        }
//         添加尾部刷新控件
        self.tableView.addFooterWithCallback { () -> Void in
            isPZBBDown = false
            
            weakSelf!.page += 1
            PZBBhelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/492/\((weakSelf?.page)!)?token=8c2f64f08271fc4e43")
        }
        
        
        
        // 进入页面自动下拉刷新
        self.tableView.headerBeginRefreshing()

        let backbb  = UIButton(frame: CGRectMake(0, 0, 30, 30))
        //        backbb.backgroundColor = UIColor.blackColor()
        backbb.setImage(UIImage(named: "back4"), forState: UIControlState.Normal)
        backbb.backgroundColor = UIColor.clearColor()
        backbb.adjustsImageWhenHighlighted = false
        backbb.addTarget(self, action: #selector(SearchViewController.backToPrevious), forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftBarBtn = UIBarButtonItem(customView: backbb)
        
        
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -20;
        
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    func PZBBViewReloadData() {
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            if isPZBBDown == true {
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
        return PZBBhelper.moneysharedHelper().dataArray.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PZcell", forIndexPath: indexPath) as! PZBBTableViewCell
        
        cell.backgroundColor = UIColor.init(red: 213 / 255.0, green: 213 / 255.0, blue: 213 / 255.0, alpha: 0.6)
        
        let PPModel = PZBBhelper.moneysharedHelper().dataArray[indexPath.row] as! PZBBModel
        
        cell.configureCellWithModel(PPModel)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.hidesBottomBarWhenPushed = true
        let seaweb = PZBBWebView()
        seaweb.hidesBottomBarWhenPushed = true
        pzMMMl = PZBBhelper.moneysharedHelper().dataArray[indexPath.row] as! PZBBModel
        seaweb.nextdetailUrl = pzMMMl.detaUrl
        
        self.navigationController?.pushViewController(seaweb, animated: true)
        
    }
    
    func searchBarView(){
        
        let sera = SearchViewController()
        self.navigationController?.pushViewController(sera, animated: true)
        
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
