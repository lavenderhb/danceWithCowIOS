//
//  CowsPeopleViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isCowsPeopleDown = true

@objc(CowsPeopleViewController)
class CowsPeopleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CowPPeopleHelperDelegate {

    var cowsPelpleMMMl : CowManModel!
    var page = 1
    var cowManTableView = UITableView()
    var cellID = "CowManCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor = UIColor.whiteColor()
        
        self.cowManTableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let nib = UINib(nibName: "CowManTableViewCell", bundle: nil)
        self.cowManTableView.registerNib(nib, forCellReuseIdentifier: cellID)
        
        self.cowManTableView.delegate = self
        self.cowManTableView.dataSource = self
        CowPPeopleHelper.moneysharedHelper().delegate = self
        self.cowManTableView.separatorStyle = .None
    self.view.addSubview(self.cowManTableView)
        
        weak var weakSelf = self
        self.cowManTableView.addHeaderWithCallback { () -> Void in
            isCowsPeopleDown = true
            CowPPeopleHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/491/1?token=8c2f64f08271fc4e43")
            
        }
        // 添加尾部
        self.cowManTableView.addFooterWithCallback { () -> Void in
            CowPPeopleHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/news/491/\((weakSelf?.page)!)?token=8c2f64f08271fc4e43")
            
        }
        self.cowManTableView.headerBeginRefreshing()
    }

    // 协议
    func CowPPeopleViewReloadData() {
        
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if isCowsPeopleDown == true {
                // 如果是下拉, 就停止头部刷新
                self.cowManTableView.headerEndRefreshing()
            } else {
                // 如果是上提, 就停止尾部刷新
                self.cowManTableView.footerEndRefreshing()
            }
            self.cowManTableView.reloadData()
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
          return CowPPeopleHelper.moneysharedHelper().dataArray.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell : CowManTableViewCell!
            cell = CowManTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell.photoImageView.backgroundColor = UIColor.clearColor()
//            cell.timeLabel.text = "00000"
            
            let cowPeople = CowPPeopleHelper.moneysharedHelper().dataArray[indexPath.row] as! CowManModel
            
            cell.configureCellWithModel(cowPeople)
            
            return cell
        }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.cowManTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cowPpweb = CowPeopleWebVView()
        
        cowsPelpleMMMl = CowPPeopleHelper.moneysharedHelper().dataArray[indexPath.row] as! CowManModel
        cowPpweb.detailUrl = cowsPelpleMMMl.webUrl
        cowPpweb.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(cowPpweb, animated: true)
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
