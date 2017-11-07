//
//  TopServiceWebView.swift
//  与牛共舞
//
//  Created by dm on 16/10/10.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var KScreenHeight =  UIScreen.mainScreen().bounds.height

var KScreenWidth = UIScreen.mainScreen().bounds.width

class TopServiceWebView: UIViewController {
    weak var conversation:JMSGConversation!
    weak var chattingVC:JChatChattingViewController!
    
    var TopWebView : UIWebView?
    var TopUrl  = NSString()
    var OtherUrl = "?token=8c2f64f08271fc4e43"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "客服团队"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.view.backgroundColor = UIColor.whiteColor()
   TopWebView = UIWebView()
        TopWebView?.backgroundColor = UIColor.whiteColor()
TopWebView?.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height / 7 * 6)
        self.view.addSubview(TopWebView!)
     TopWebView?.scrollView.bounces = false
        TopWebView?.opaque = false
        let LastButton = UIButton()
        LastButton.frame = CGRectMake(20,KScreenHeight - 100, KScreenWidth - 40, 35)
        LastButton.layer.cornerRadius = 10.0
        LastButton.backgroundColor = UIColor.redColor()
        LastButton.setTitle("发消息", forState: UIControlState.Normal)
        LastButton.addTarget(self, action: #selector(TopServiceWebView.LastAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(LastButton)
        
    loadDataSource()
        
        let backbb  = UIButton(frame: CGRectMake(0, 0, 30, 30))
        //        backbb.backgroundColor = UIColor.blackColor()
        backbb.setImage(UIImage(named: "back4"), forState: UIControlState.Normal)
        backbb.backgroundColor = UIColor.clearColor()
        backbb.adjustsImageWhenHighlighted = false
        backbb.addTarget(self, action: #selector(TopServiceWebView.backToPrevious), forControlEvents: UIControlEvents.TouchUpInside)
        
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

    // 发消息的点击事件
    func LastAction(){

                //                        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        //
        self.hidesBottomBarWhenPushed = true
        
        
//         这个地方作为存储的一个数据信息的本地缓存
        LoadAll =  NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary;
        
        
        if (LoadAll == nil){
            
            self.hidesBottomBarWhenPushed = true
            let nav = LoadViewController()
            self.navigationController?.pushViewController(nav, animated: true)
            
        }else{
            self.hidesBottomBarWhenPushed = true
            
            JMSGUser.loginWithUsername((LoadAll!["jiguang_username"]?.stringByRemovingPercentEncoding!)!, password: (LoadAll!["jiguang_password"]?.stringByRemovingPercentEncoding!)!, completionHandler: { (resultObject, error) -> Void in
                //                            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                if error == nil {
                    NSNotificationCenter.defaultCenter().postNotificationName(kupdateUserInfo, object: nil)
                    self.userLoginSave()
                    JMSGUser.myInfo()
                }
                else {
                    print("login fail error \(NSString.errorAlert(error))")
                    MBProgressHUD.showMessage(NSString.errorAlert(error), view: self.view)
                }
            })
            
            
            LoadAll = NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary
//            \LoadAll!["jiguang_username
            JMSGConversation.createSingleConversationWithUsername(LoadAll!["jiguang_kefu_username"]!.stringByRemovingPercentEncoding!!, completionHandler: { (singleConversation, error) -> Void in
                
                //            self = [(self.conversation.target as! JMSGUser)]
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                })
                if error == nil {
                    
                    let chattingVC = JChatChattingViewController()
                    
                    self.hidesBottomBarWhenPushed = true
                    chattingVC.conversation = singleConversation as! JMSGConversation
                    self.navigationController?.pushViewController(chattingVC, animated: true)
                    
                    
                } else {
//                    MBProgressHUD.showMessage("添加的用户不存在", view: self.view)
                }
            })
            
            
            
        }
        
    }
    
    func userLoginSave() {
        NSUserDefaults.standardUserDefaults().setObject("tianding_246451535", forKey: kuserName)
        NSUserDefaults.standardUserDefaults().setObject("tianding_246451535", forKey: klastLoginUserName)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // 创建数据连接
    func loadDataSource(){
        let UrlString = (TopUrl as String) + OtherUrl
        
        let auul = NSURL(string: UrlString)
        let rulRequest = NSURLRequest(URL: auul!)
        TopWebView?.loadRequest(rulRequest)
        
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
