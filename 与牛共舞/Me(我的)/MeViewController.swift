//
//  MeViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import SwiftHTTP


var TagToLoad : NSNumber?

var CanloadButton : UIButton!

var TagCancle : NSNumber?
class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    weak var conversation:JMSGConversation!
    weak var chattingVC:JChatChattingViewController!
    var EEbutton : UIButton!
    var mineThreeView = UITableView()
    var threeIdent = "ThrenCell"
    
    
    var CanButtonTag : Int!
    // 清除缓存提示框
    var cleanAlertView : UIAlertView!
    // 确认退出的提示框
    var SureAlertView : UIAlertView!
    
    var alertQQ : UIAlertView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TagCancle = 200
        self.view.backgroundColor = UIColor.init(red: 239 / 255.0, green: 238 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 240 / 255.0, green: 54 / 255.0, blue: 30 / 255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let leftBarBtn = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = leftBarBtn
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255.0, green: 64/255.0, blue: 28/255.0, alpha: 0.6)
        
        mineThreeView = UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, 100))
        
        mineThreeView.backgroundColor = UIColor.whiteColor()
        
        let cellNib = UINib(nibName: "MineTableViewCell", bundle: nil)
        mineThreeView.registerNib(cellNib, forCellReuseIdentifier: threeIdent)
        self.mineThreeView.scrollEnabled = false
        
        mineThreeView.delegate = self
        mineThreeView.dataSource = self
        
        EEbutton = UIButton(frame: CGRectMake( 50, 235, self.view.bounds.width - 100, 38))
        EEbutton.layer.cornerRadius = 5
        EEbutton.backgroundColor = UIColor.init(red: 240 / 255.0, green: 54 / 255.0, blue: 30 / 255.0, alpha: 1.0)
        self.navigationItem.title = "未登录/注册"
        EEbutton.setTitle("登录/注册", forState: UIControlState.Normal)
        EEbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        EEbutton.addTarget(self, action: #selector(MeViewController.LoadViewAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(EEbutton)
        self.view.addSubview(mineThreeView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MeViewController.gameOver), name: "gameOverNotification", object: LoadAll)
        
        creatpersonInformation()
    }
    
    // 作为单一缓存用户的信息的缓存 TagCancle
    func creatpersonInformation(){
        
        LoadAll =  NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary
        
        if (LoadAll != nil) {
            self.gameOver()
        }
    }
    
    
    func gameOver()
    {
        
        CanloadButton = UIButton(frame: CGRectMake( 50, 235, self.view.bounds.width - 100, 38))
        CanloadButton.layer.cornerRadius = 5
        CanloadButton.backgroundColor = UIColor.init(red: 240 / 255.0, green: 54 / 255.0, blue: 30 / 255.0, alpha: 1.0)
        CanloadButton.setTitle("安全退出", forState: UIControlState.Normal)
        CanloadButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        CanloadButton.addTarget(self, action: #selector(MeViewController.LoadViewActionCancle), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(CanloadButton)
        self.navigationItem.title = LoadAll!["username"]?.stringByRemovingPercentEncoding!
        
    }
    
    func LoadViewActionCancle(){
        let alertController = UIAlertController(title: "确定退出吗",
                                                message: nil, preferredStyle: .Alert)
        let cancleAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            print("确定按钮点击事件")
        }
        
        let alertView2 = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            TagToLoad = 300
            NSNotificationCenter.defaultCenter().postNotificationName("canMakeLoad", object: TagToLoad)
            
            self.navigationItem.title = "未登录/注册"
            CanloadButton.setTitle("登录/注册", forState: UIControlState.Normal)
            CanloadButton.hidden = true
            NSNotificationCenter.defaultCenter().postNotificationName("anquantuichu", object: LoadAll)
            LoadAll = nil;
            NSUserDefaults.standardUserDefaults().setValue(LoadAll, forKey: "LoadAll");
            NSUserDefaults.standardUserDefaults().synchronize();
            self.hidesBottomBarWhenPushed = true
            let ooo = LoadViewController()
            self.navigationController?.pushViewController(ooo, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
        alertController.addAction(cancleAction)
        alertController.addAction(alertView2)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    // 选择登录的按钮和进行安全退出的按钮
    func LoadViewAction(){
        
        
        self.hidesBottomBarWhenPushed = true
        let loadvc  = LoadViewController()
        
        self.navigationController?.pushViewController(loadvc, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(threeIdent.self, forIndexPath: indexPath) as! MineTableViewCell
        if (indexPath.row == 0){
            cell.bigLabel.text = "我的客服"
        }else if(indexPath.row ==  1){
            cell.bigLabel.text = "手动清理缓存"
            if (fileSizeOfCache() > 0) {
                cell.smiallLabel.text = "共有\(fileSizeOfCache())M缓存"
                
            }else{
                cell.smiallLabel.text = ""
            }
        }else if(indexPath.row ==  2){
            cell.bigLabel.text = "查看崩溃信息"
        }
        
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == 0){
            toChat()
            
            //            NSNotificationCenter.defaultCenter().addObserver(self, selector: nil, name: "Test", object: TagCancle)
            //            print("---------------\(TagCancle)")
            //            NSNotificationCenter.defaultCenter().postNotificationName("anquantuichu", object: LoadAll)
            //
            //            if (LoadAll == nil){
            //                self.hidesBottomBarWhenPushed = true
            //                let loadView = LoadViewController()
            //                self.navigationController?.pushViewController(loadView, animated: true)
            //                self.hidesBottomBarWhenPushed = false
            //            }else{
            //                self.hidesBottomBarWhenPushed = true
            //
            //                print(LoadAll!["jiguang_password"])
            //                print(LoadAll!["jiguang_kefu_username"])
            //
            //
            //                JMSGUser.loginWithUsername((LoadAll!["jiguang_username"]?.stringByRemovingPercentEncoding!)!, password: (LoadAll!["jiguang_password"]?.stringByRemovingPercentEncoding!)!, completionHandler: { (resultObject, error) -> Void in
            //                    //                            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            //
            //                    if error == nil {
            //                        NSNotificationCenter.defaultCenter().postNotificationName(kupdateUserInfo, object: nil)
            //                        self.userLoginSave()
            //                        JMSGUser.myInfo()
            //                        print("\(JMSGUser.myInfo())")
            //                    }
            //                    else {
            //                        print("login fail error \(NSString.errorAlert(error))")
            //                        MBProgressHUD.showMessage(NSString.errorAlert(error), view: self.view)
            //                    }
            //                })
            //                JMSGConversation.createSingleConversationWithUsername(LoadAll!["jiguang_kefu_username"]!.stringByRemovingPercentEncoding!!, completionHandler: { (singleConversation, error) -> Void in
            //
            //                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //                        //                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            //                    })
            //                    if error == nil {
            //
            //                        let chattingVC = JChatChattingViewController()
            //
            //                        self.hidesBottomBarWhenPushed = true
            //                        chattingVC.conversation = singleConversation as! JMSGConversation
            //                        self.navigationController?.pushViewController(chattingVC, animated: true)
            //                    } else {
            //                        //                    MBProgressHUD.showMessage("添加的用户不存在", view: self.view)
            //                    }
            //                })
            //            }
            //
            self.hidesBottomBarWhenPushed = false
        }else if(indexPath.row == 1){
            
            if (fileSizeOfCache() > 0){
                
                cleanAlertView = UIAlertView()
                cleanAlertView.title = "清理缓存"
                cleanAlertView.addButtonWithTitle("取消")
                cleanAlertView.addButtonWithTitle("确定")
                cleanAlertView.cancelButtonIndex = 0
                cleanAlertView.delegate=self;
                cleanAlertView.show()
                
            }else{
                self.present()
            }
        }else if(indexPath.row==2){
            crashHandle { (crashInfoArr) in
                print(crashInfoArr.count)
                for info in crashInfoArr{
                    //将上一次崩溃信息显示在屏幕上
                    dispatch_async(dispatch_get_main_queue(),{
                        let infoLabel = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height))
                        infoLabel.backgroundColor = UIColor.grayColor()
                        infoLabel.textColor = UIColor.whiteColor()
                        infoLabel.editable = false
                        infoLabel.text = info
                        
                        UIApplication.sharedApplication().keyWindow?.addSubview(infoLabel)
                        
                    })
                }
            }
            
            
        }
        print("\(indexPath.row)")
    }
    
    func getNewKefu(){
        let loadAll =  NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary;
        let userName = loadAll?.objectForKey("username") as! String
        let password = loadAll?.objectForKey("password") as! String
        
        do{
            let opt = try HTTP.GET("http://appv2.yngw518.com/api.php/user/login?token=8c2f64f08271fc4e43&username=" + "\(encodeEscapesURL(userName))" + "&password=" + password)
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        var json : AnyObject?
                        
                        do{
                            json = try NSJSONSerialization.JSONObjectWithData((result.text?.dataUsingEncoding(NSUTF8StringEncoding))!, options: NSJSONReadingOptions.AllowFragments)
                        }catch let error as NSError{
                            print(error)
                        }
                        
                        let statues : Int = json!.objectForKey("status") as! Int
                        
                        var LoadAll0:NSMutableDictionary=NSMutableDictionary()
                        
                        if (statues == 1){
                            let data : NSDictionary = json?.objectForKey("data") as! NSDictionary
                            
                            let data0:NSMutableDictionary=NSMutableDictionary.init(dictionary: data)
                            
                            if data0["jiguang_kefu_nickname"] is NSNull {
                                data0.setValue("", forKey: "jiguang_kefu_nickname")
                            }
                            
                            data0.setObject(password, forKey: "password")
                            
                            LoadAll0 = data0
                            
                            let userDefaut=NSUserDefaults.standardUserDefaults()
                            userDefaut.setValue(LoadAll0, forKey: "LoadAll")
                            userDefaut.synchronize()
                            
                        }else{
                            LoadAll0=NSMutableDictionary.init(dictionary: loadAll!)
                        }
                        
                        //判断是否有专属客服
                        var kefuID = (LoadAll0.objectForKey("jiguang_kefu_username") as! String).stringByReplacingOccurrencesOfString("tianding_", withString: "");
                        //无专属客服，进入聊天界面
                        if kefuID == ""{
                            //                var  chatVC = ChatViewController()
                            //                chatVC.kefuDto=dto;
                            //                navigationController?.pushViewController(chatVC, animated: true)
                            
                            XZAlertView.addXZAlertView(self.view, title: "请联系客服分配助理")
                        }
                            //有专属客服
                        else{
                            let dto=NextServiceModel()
                            dto.originalId=NSNumber.init(double: NSString.init(string: kefuID).doubleValue)
                            dto.name=LoadAll0.objectForKey("jiguang_kefu_nickname") as! String
                            var chatVC = ChatViewController()
                            chatVC.kefuDto=dto
                            self.navigationController?.pushViewController(chatVC, animated: true)
                            
                        }
                        
                        
                    })
                }
            }
        }catch let error {
            print("请求失败: \(error)")
            
        }
        
        
    }
    
    
    func toChat(){
        
        if hasLogin() {
            getNewKefu()
        }else{
            //跳转到登录
            self.hidesBottomBarWhenPushed = true
            let nav = LoadViewController()
            self.navigationController?.pushViewController(nav, animated: true)
            
        }
        
    }
    
    func hasLogin()->Bool{
        let loadAll =  NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary;
        if loadAll != nil{
            //login
            return true
        }else{
            return false
        }
        
    }
    
    func present(){
        
        alertQQ = UIAlertView(title: "", message: "已经很干净了", delegate: nil, cancelButtonTitle: nil)
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MeViewController.dismiss), userInfo: nil, repeats: false)
        alertQQ.show()
    }
    
    func dismiss(){
        
        alertQQ.dismissWithClickedButtonIndex(0, animated: false)
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        
        if(buttonIndex==alertView.cancelButtonIndex){
            print("点击了取消")
        }
        else{
            self.clearCache()
            self.mineThreeView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.mineThreeView.reloadData()
        
        // 友盟界面的统计
        MobClick.beginLogPageView("PageFour")
        // 毛玻璃效果
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.translucent = true
        //        print(txtUsr.text)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // 友盟界面的统计
        MobClick.endLogPageView("PageFour")
    }
    
    
    //获取缓存大小
    func fileSizeOfCache()-> Int {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath =
            NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        //缓存目录路径
        //        print(cachePath)
        
        // 取出文件夹下所有文件数组
        let fileArr = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            
            // 把文件名拼接到路径中
            let path = cachePath?.stringByAppendingString("/\(file)")
            // 取出文件属性
            let floder = try? NSFileManager.defaultManager().attributesOfItemAtPath(path!)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder! {
                // 累加文件大小
                if abc == NSFileSize {
                    size += bcd.integerValue
                }
            }
        }
        
        let mm = size / 1024 / 1024
        return mm
    }
    
    
    //清除缓存
    
    func clearCache() {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
        
        // 遍历删除
        for file in fileArr! {
            
            let path = cachePath?.stringByAppendingString("/\(file)")
            if NSFileManager.defaultManager().fileExistsAtPath(path!) {
                
                do {
                    try NSFileManager.defaultManager().removeItemAtPath(path!)
                } catch {
                    
                }
            }
        }
    }
    
    
    func userLoginSave() {
        NSUserDefaults.standardUserDefaults().setObject("tianding_246451535", forKey: kuserName)
        NSUserDefaults.standardUserDefaults().setObject("tianding_246451535", forKey: klastLoginUserName)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 513
    // 进行URL编码
    func encodeEscapesURL(value:String) -> String {
        let str:NSString = value
        let originalString = str as CFStringRef
        let charactersToBeEscaped = "!*'();:@&=+$,/?%#[]" as CFStringRef  //":/?&=;+!@#$()',*"    //转意符号
        //let charactersToLeaveUnescaped = "[]." as CFStringRef  //保留的符号
        let result =
            CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                    originalString,
                                                    nil,    //charactersToLeaveUnescaped,
                charactersToBeEscaped,
                CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) as NSString
        
        return result as String
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
