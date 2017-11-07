//
//  searchWebView.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class searchWebView: UIViewController {

        var  NextWebView : UIWebView?
        var  nextdetailUrl = NSString()
        var  nextOtherUrl = "?token=8c2f64f08271fc4e43"
        override func viewDidLoad() {
            
            super.viewDidLoad()
            self.view.backgroundColor = UIColor.whiteColor()
            NextWebView = UIWebView()
            NextWebView?.backgroundColor = UIColor.whiteColor()
            NextWebView?.scrollView.bounces = false
            NextWebView?.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
            self.view.addSubview(NextWebView!)
            self.view.backgroundColor = UIColor.init(red: 235 / 255.0, green: 235 / 255.0, blue: 242 / 255.0, alpha: 1.0)
            
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
        }
        
        //返回按钮点击响应
        func backToPrevious(){
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        func LastAction(){
            
            let chatView = VServiceChatiewController()
            
            self.navigationController?.pushViewController(chatView, animated: true)
        }
        
        
        // 创建数据连接
        func loadDataSource(){
            let UrlString = (nextdetailUrl as String) + nextOtherUrl
            
            let auul = NSURL(string: UrlString)
            let rulRequest = NSURLRequest(URL: auul!)
            NextWebView?.loadRequest(rulRequest)
            
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
