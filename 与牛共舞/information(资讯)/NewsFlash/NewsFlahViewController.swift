//
//  NewsFlahViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/26.
//  Copyright © 2016年 Mac. All rights reserved.


import UIKit

// 快讯界面
@objc(NewsFlahViewController)
class NewsFlahViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NewsFlashHelperDelegate {

var colorArr = [UIColor.redColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.blueColor(), UIColor.orangeColor()];
    var i = 0;
    var NewsFlashTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        NewsFlashHelper.sharedHelper().delegate = self
        
      NewsFlashTableView = UITableView(frame: CGRectMake(0, 0, KScreenWidth, KScreenHeight - 99))
        self.NewsFlashTableView.delegate = self
        self.NewsFlashTableView.dataSource = self
        
        self.NewsFlashTableView.registerClass(NewsFlashTableViewCell.self, forCellReuseIdentifier: "cell")

        let cellNib = UINib(nibName: "NewsHeaderTableViewCell", bundle: nil)
        NewsFlashTableView.registerNib(cellNib, forCellReuseIdentifier: "cell1")
        // 全部加载 http://appv2.yngw518.com/api.php/recom?token=8c2f64f08271fc4e43
        // http://appv2.yngw518.com/api.php/news/486/1?token=8c2f64f08271fc4e43
        NewsFlashHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/recom?token=8c2f64f08271fc4e43")
        self.view.addSubview(NewsFlashTableView)
       self.NewsFlashTableView.separatorStyle = .None
        
        self.NewsFlashTableView.estimatedRowHeight = 44
        self.NewsFlashTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    // 协议中的方法
    func NewFlashHelperReloadData() {
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.NewsFlashTableView.reloadData()
        }
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return NewsFlashHelper.sharedHelper().ddd.count
//        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsFlashHelper.sharedHelper().dataArray[section].count
//        return NewsFlashHelper.sharedHelper().dataArray.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        if indexPath.row == 0 {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! NewsHeaderTableViewCell
            let str = NewsFlashHelper.sharedHelper().ddd[indexPath.section];
            // 进行数据请求的时候的分割，然后根据数据的形成来取相应的字段
            let strArr = str.componentsSeparatedByString("-");
            cell1.dayLabel.text = strArr[2];
            cell1.monthlabel.text = "\(strArr[1])月";
            let model = (NewsFlashHelper.sharedHelper().dataArray[indexPath.section] as! NSMutableArray)[indexPath.row] as! NewsFlashModel
            cell1.setSelected(false, animated: true)
            
            cell1.contentfigureWithModel(model);
            cell1.adjustCellWithModel(model)
            cell1.backgroundColor = UIColor.whiteColor()
            cell1.selectionStyle = UITableViewCellSelectionStyle.None
            return cell1;
        }else {
            let  cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! NewsFlashTableViewCell
            cell.setSelected(false, animated: true)
            let label = UILabel(frame: CGRectMake(22, 39, 2, cell.bounds.height - 50))
            label.backgroundColor = UIColor.redColor()
            cell.addSubview(label)
            let newssModel = (NewsFlashHelper.sharedHelper().dataArray[indexPath.section] as! NSMutableArray)[indexPath.row] as! NewsFlashModel
            cell.contentfigureWithModel(newssModel)
            //        // 重新布局  cell.bounds.height / 3 * 2 - 20
            cell.adjustCellWithModel(newssModel)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
    }
    
    // 返回cell高度
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = (NewsFlashHelper.sharedHelper().dataArray[indexPath.section] as! NSMutableArray)[indexPath.row] as! NewsFlashModel
        return 65 + NewsFlashTableViewCell.calculateLabelHeightWithModel(model)
//        return 80
    }
  
    override func viewWillAppear(animated: Bool) {
        print("出现的快讯")
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
