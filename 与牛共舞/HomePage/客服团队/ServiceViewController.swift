
//
//  ServiceViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/9/3.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

import SwiftHTTP
// 测试用的UIColllectionView
//客服推荐
var TestCollectionView : UICollectionView!

weak var conversation:JMSGConversation!
weak var chattingVC:JChatChattingViewController!

// 设置全局变量
var topServiceModdel : TopServiceModel!
var nextServiceModel :  NextServiceModel!

// 正在帮你加载
var  SStitleView : UIView!
// 下面客服列表
var  MoreTableview : UITableView!
// 互动大厅
var  serviceView = UIView()
// 客服的界面
var  loadOneView = UIView()
// 背景视图
var  backTableView : UITableView!

var MoreIdentfier = "moreCell"

var alertQQ : UIAlertView!

@objc(ServiceViewController)
class ServiceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource,
    SerViceHelperDelegate,
NextServiceHelperDelegate {
    
    override func viewWillDisappear(animated: Bool) {
        //        let a:Double=Double.init("p")!
        super.viewWillDisappear(animated)
        (AppDelegate.delegate as! AppDelegate).pageCondition=0
        (AppDelegate.delegate as! AppDelegate).listViewController.removeAtIndex(0)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //
        super.viewDidAppear(animated)
        (AppDelegate.delegate as! AppDelegate).pageCondition=1
        (AppDelegate.delegate as! AppDelegate).listViewController.insert(self,atIndex: 0)
        comeNews()
        //        aa()
    }
    
    
    func showSelf(viewController: UIViewController, animated: Bool){
        //        navigationController?.pushViewController(viewController, animated: true)
        
        //        [[UIApplication sharedApplication].delegate window].rootViewController = WZXlaunchVC;
        
        super.navigationController?.pushViewController(viewController, animated: true)
        
        //        UIApplication.sharedApplication().keyWindow?.rootViewController=viewController
    }
    
    func comeNews(){
        let list:[NSNumber] = GloMethod.setWebList(3, str: NSNumber.init())
        NextServiceHelper.sharedHelper().setComeNews(list)
        MoreTableview.reloadData()
    }
    
    override func viewDidLoad() { // 页面初始化代码 graycolor
        super.viewDidLoad()
        
        // 横向的数据
        ServiceHelper.sharedHelper().delegate = self
        ServiceHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: GloStr.kftjurl)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        SStitleView = UIView(frame: CGRectMake(0,0,240,25))
        SStitleView.layer.cornerRadius = 6
        SStitleView.backgroundColor = UIColor.whiteColor()
        // 创建segmentcontrller背景视图
        self.navigationItem.titleView = SStitleView
        
        let leftButton = UIButton(frame: CGRectMake(0, 0, 120, 25))
        leftButton.backgroundColor = UIColor.whiteColor()
        leftButton.layer.cornerRadius = 5
        leftButton.setTitle("客服团队", forState: UIControlState.Normal)
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        leftButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        let CenterButton = UIButton(frame: CGRectMake(120, 0, 5, 25))
        CenterButton.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
        SStitleView.addSubview(CenterButton)
        
        let RightButton = UIButton(frame: CGRectMake(120, 0, 120, 25))
        RightButton.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
        RightButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        RightButton.setTitle("互动大厅", forState: UIControlState.Normal)
        RightButton.addTarget(self, action: #selector(ServiceViewController.CanTalkWithService), forControlEvents: UIControlEvents.TouchUpInside)
        RightButton.layer.cornerRadius = 5
        SStitleView.addSubview(RightButton)
        SStitleView.addSubview(leftButton)
        
        let button = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button.setImage(UIImage(named: "968"), forState: UIControlState.Normal)
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: #selector(ServiceViewController.searchActiomn), forControlEvents: UIControlEvents.TouchUpInside)
        button.adjustsImageWhenHighlighted=false //使触摸模式下按钮也不会变暗
        let barBUtton116 = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barBUtton116
        
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
        
        // 设定背景的tableView的视图
        backTableView = UITableView(frame: CGRectMake(0, 0, KScreenWidth, KScreenHeight))
        
        backTableView.backgroundColor = UIColor.whiteColor()
        backTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "BackCell")
        
        backTableView.delegate = self
        backTableView.dataSource = self
        
        //  创建下面的tableview的视图
        MoreTableview = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, KScreenHeight),style : UITableViewStyle.Grouped)
        MoreTableview.backgroundColor = UIColor.whiteColor()
        
        // 注册cell
        let MoreCell  = UINib(nibName: "MoreServiceTableCell", bundle: nil)
        MoreTableview.registerNib(MoreCell, forCellReuseIdentifier: MoreIdentfier)
        
        MoreTableview.separatorStyle = .None
        MoreTableview.delegate = self
        MoreTableview.dataSource = self
        
        self.view.addSubview(MoreTableview)
        NextServiceHelper.sharedHelper().delegate = self
        NextServiceHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: GloStr.KefuListAllUrl)
        
    }
    
    // 是否可以进行客服聊天  互动大厅
    func CanTalkWithService(){
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
                //  MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                if error == nil {
                    NSNotificationCenter.defaultCenter().postNotificationName(kupdateUserInfo, object: nil)
                    //     self.userLoginSave()
                    JMSGUser.myInfo()
                }
                else {
                    print("login fail error \(NSString.errorAlert(error))")
                    MBProgressHUD.showMessage(NSString.errorAlert(error), view: self.view)
                }
            })
            
            LoadAll = NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary
            
            JMSGConversation.createSingleConversationWithUsername(LoadAll!["jiguang_kefu_username"]!.stringByRemovingPercentEncoding!!, completionHandler: { (singleConversation, error) -> Void in
                
                //            self = [(self.conversation.target as! JMSGUser)]
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                })
                if error == nil {
                    let chattingVC = JChatChattingViewController()
                    
                    chattingVC.conversation = singleConversation as! JMSGConversation
                    self.navigationController?.pushViewController(chattingVC, animated: true)
                } else {
                    MBProgressHUD.showMessage("添加的用户不存在", view: self.view)
                }
            })
        }
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let back = UIView(frame: CGRectMake(0, 0, KScreenWidth, 60))
        back.backgroundColor = UIColor.whiteColor()
        
        let Testlayout = UICollectionViewFlowLayout()
        TestCollectionView = UICollectionView(frame: CGRectMake(0, 25, UIScreen.mainScreen().bounds.width, 125), collectionViewLayout: Testlayout)
        // 注册cell
        TestCollectionView!.registerClass(TestCollectionViewCell.self, forCellWithReuseIdentifier: "TestCEll")
        TestCollectionView.showsHorizontalScrollIndicator = false
        
        TestCollectionView?.delegate = self
        TestCollectionView?.dataSource = self
        Testlayout.scrollDirection = .Horizontal
        
        let TestLabel : UILabel = UILabel(frame: CGRectMake(5,0, 70, 30))
        TestLabel.backgroundColor = UIColor.whiteColor()
        TestLabel.textColor = UIColor.redColor()
        TestLabel.text = "客服推荐"
        TestCollectionView?.backgroundColor = UIColor.whiteColor()
        Testlayout.itemSize = CGSizeMake(85, 95)
        
        back.addSubview(TestCollectionView)
        back.addSubview(TestLabel)
        return back
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 125
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func searchActiomn(){
        self.hidesBottomBarWhenPushed = true
        let serac = SearchViewController()
        self.navigationController?.pushViewController(serac, animated: true)
    }
    
    // 协议中的方法
    func ServiceReloadData() {
        dispatch_async(dispatch_get_main_queue()) {  () -> Void in
            TestCollectionView!.reloadData()
        }
    }
    
    // 协议中的方法
    func NextServiceHelperData() {
        dispatch_async(dispatch_get_main_queue()) {  () -> Void in
            if (MoreTableview != nil){
                MoreTableview.reloadData()
            }
        }
    }
    
    func action_segmentValueChanged(sender :UISegmentedControl) {
        debugPrint(sender.selectedSegmentIndex)
        switch (sender.selectedSegmentIndex) {
        case 0:
            serviceView.hidden = false
            loadOneView.hidden = true
            break
        case 1:
            serviceView.hidden = true
            loadOneView.hidden = false
            break
        default:
            break
        }
    }
    
    // 出现tableview的代理
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == backTableView){
            return 6
        }else if(tableView == MoreTableview){
            return NextServiceHelper.sharedHelper().dataArray.count
        }
        return 0
    }
    
    func  tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (tableView == backTableView){
            return 120
        }else if (tableView == MoreTableview){
            return 102
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if (tableView == backTableView){
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "BackCell")
            cell.backgroundColor = UIColor.whiteColor()
            cell.textLabel?.text = ""
            cell.selected = false
            cell.selectionStyle = .None
            
        }else if(tableView == MoreTableview){
            
            let cell = tableView.dequeueReusableCellWithIdentifier(MoreIdentfier.self, forIndexPath: indexPath) as! MoreServiceTableCell
            
            let NextServiceModell = NextServiceHelper.sharedHelper().dataArray[indexPath.row] as! NextServiceModel
            
            cell.headerView.layer.cornerRadius = 50
            cell.configureCellWithModel(NextServiceModell)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
        }
        
        return cell
    }
    
    // tableview的点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(tableView == MoreTableview){
            MoreTableview.deselectRowAtIndexPath(indexPath, animated: true)
            self.hidesBottomBarWhenPushed = true
            
            nextServiceModel = NextServiceHelper.sharedHelper().dataArray[indexPath.row] as! NextServiceModel
            toChat(nextServiceModel)
        }
    }
    
    func encodeEscapesURL(value:String) -> String {
        let str:NSString = value
        let originalString = str as CFStringRef
        let charactersToBeEscaped = "!*'();:@&=+$,/?%#[]" as CFStringRef  //":/?&=;+!@#$()',*"    //转意符号
        //let charactersToLeaveUnescaped = "[]." as CFStringRef  //保留的符号 101
        let result =
            CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                    originalString,
                                                    nil,    //charactersToLeaveUnescaped,
                charactersToBeEscaped,
                CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) as NSString
        
        return result as String
    }
    
    func getNewKefu(dto:NextServiceModel){
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
                            //判断是否为当前客服
                            let kefuIdInt = Int32(kefuID)
                            //为当前客服，跳转到聊天界面
                            if kefuIdInt == dto.originalId.intValue{
                                
                                var  chatVC = ChatViewController()
                                chatVC.kefuDto=dto
                                self.navigationController?.pushViewController(chatVC, animated: true)
                                
                            }
                                //不是当前客服，提示
                            else{
                                XZAlertView.addXZAlertView(self.view, title: "请选择自己的专属客服"+(LoadAll0.objectForKey("jiguang_kefu_nickname") as! String))
                            }
                        }

                        
                    })
                }
            }
        }catch let error {
            print("请求失败: \(error)")
            
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
    
    func toChat(dto:NextServiceModel){
        
        if hasLogin() {
            getNewKefu(dto)
        }else{
            //跳转到登录
            self.hidesBottomBarWhenPushed = true
            let nav = LoadViewController()
            self.navigationController?.pushViewController(nav, animated: true)
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ServiceHelper.sharedHelper().dataArray.count
    }
    
    // uicollectionView的点击事件
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        TestCollectionView.deselectItemAtIndexPath(indexPath, animated: true)
        self.hidesBottomBarWhenPushed = true
        
        topServiceModdel = ServiceHelper.sharedHelper().dataArray[indexPath.row] as! TopServiceModel
        
        var next:NextServiceModel=NextServiceModel()
        next.name = topServiceModdel.nameLabelUrl
        next.originalId = NSNumber(double: NSString(string: topServiceModdel.originalId).doubleValue)
        
        toChat(next)
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("TestCEll", forIndexPath: indexPath) as! TestCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        
        let serviceHeaderModel = ServiceHelper.sharedHelper().dataArray[indexPath.row] as! TopServiceModel
        
        cell.configureCellWithModel(serviceHeaderModel)
        //        cell.tittleLabell?.text = "sdasda"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
