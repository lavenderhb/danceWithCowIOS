//
//  WebViewController.swift
//  与牛共舞
//
//  Created by dm on 16/9/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var detailUrl = NSString()
  
    var LastURL = "/index/recom?token=8c2f64f08271fc4e43"
    var webView : UIWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = UIWebView()
        webView?.frame = self.view.frame
        
        webView?.backgroundColor = UIColor.grayColor()
        self.view.backgroundColor = UIColor.init(red: 235 / 255.0, green: 235 / 255.0, blue: 242 / 255.0, alpha: 1.0)
        self.view.addSubview(webView!)
        loadDataSource()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "资讯正文"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let button116 = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button116.setImage(UIImage(named: "搜索001.png"), forState: UIControlState.Normal)
        button116.backgroundColor = UIColor.clearColor()
        button116.addTarget(self, action: #selector(WebViewController.searCCC), forControlEvents: UIControlEvents.TouchUpInside)
        button116.adjustsImageWhenHighlighted = false
        let barBUtton1161 = UIBarButtonItem(customView: button116)
        
        self.navigationItem.rightBarButtonItem = barBUtton1161
    }
    
    func searCCC(){
        self.hidesBottomBarWhenPushed = true
        let seacc = SearchViewController()
        self.navigationController?.pushViewController(seacc, animated: true)
    }

    func loadDataSource(){
            
        let urlString = (detailUrl as String) + "/index/recom?token=8c2f64f08271fc4e43"
        
        let aUrl = NSURL(string: urlString)
//        let aUrl = NSURL(string: "http://yngwtest.gotoip1.com/api.php/News/detail/id/8024/index/recom?token=8c2f64f08271fc4e43")
        let urlRequest = NSURLRequest(URL: aUrl!)
        webView?.loadRequest(urlRequest)
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
