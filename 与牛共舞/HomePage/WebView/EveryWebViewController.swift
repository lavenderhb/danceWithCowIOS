//
//  EveryWebViewController.swift
//  与牛共舞
//
//  Created by dm on 16/9/28.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class EveryWebViewController: UIViewController {
    var everyUrl = NSString()
    var lastUrl = "/index/colart?token=8c2f64f08271fc4e43"
    var EverywebView : UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      EverywebView = UIWebView()
      EverywebView?.frame = self.view.frame
      EverywebView?.backgroundColor = UIColor.grayColor()
        self.view.addSubview(EverywebView!)
        self.navigationItem.title = "资讯正文"
        self.view.backgroundColor = UIColor.init(red: 235 / 255.0, green: 235 / 255.0, blue: 242 / 255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
  loadDataSource()
  
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
    
        
        let button116 = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button116.setImage(UIImage(named: "搜索001.png"), forState: UIControlState.Normal)
        button116.backgroundColor = UIColor.clearColor()
        button116.addTarget(self, action: #selector(EveryWebViewController.searCCC), forControlEvents: UIControlEvents.TouchUpInside)
        button116.adjustsImageWhenHighlighted = false
        let barBUtton1161 = UIBarButtonItem(customView: button116)
        
        self.navigationItem.rightBarButtonItem = barBUtton1161
    }
    
    func searCCC(){
        self.hidesBottomBarWhenPushed = true
        let seacc = SearchViewController()
        self.navigationController?.pushViewController(seacc, animated: true)
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func loadDataSource(){
        let urlString = (everyUrl as String) + lastUrl
        
        let aUrl = NSURL(string: urlString)
        let urlRequest = NSURLRequest(URL: aUrl!)
        EverywebView?.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
