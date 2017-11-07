//
//  LCZSViewController.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isLAZCDOwn = true

class LCZSViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HEadCollectionHelperDelegate,EndLLLHelperDelegate {

    var HeaderCollectionView : UICollectionView!

    var backView : UITableView!
    
    var alertQQ : UIAlertView!
    
    weak var conversation:JMSGConversation!
    weak var chattingVC:JChatChattingViewController!
    
    var endTableView : UITableView!
    
    var  SStitleView : UIView!
    
    var page = 1
    
    var  endMMML : EnddddModel!
    
    var harrdddmodel : HradModel!
    
    var endCellID  = "EndTTTViewCell11"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        SStitleView = UIView(frame: CGRectMake(0,0,240,25))
        SStitleView.layer.cornerRadius = 6
        SStitleView.backgroundColor = UIColor.whiteColor()
        // 创建segmentcontrller背景视图
        self.navigationItem.titleView = SStitleView
        
        
        let leftButton = UIButton(frame: CGRectMake(0, 0, 120, 25))
        leftButton.backgroundColor = UIColor.whiteColor()
        leftButton.layer.cornerRadius = 5
        leftButton.setTitle("理财团队", forState: UIControlState.Normal)
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        leftButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        let CenterButton = UIButton(frame: CGRectMake(120, 0, 5, 25))
        CenterButton.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
        SStitleView.addSubview(CenterButton)
        
        let RightButton = UIButton(frame: CGRectMake(120, 0, 120, 25))
        RightButton.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
        RightButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        RightButton.setTitle("互动大厅", forState: UIControlState.Normal)
        RightButton.addTarget(self, action: #selector(LCZSViewController.Jchat), forControlEvents: UIControlEvents.TouchUpInside)
        RightButton.layer.cornerRadius = 5
        
        SStitleView.addSubview(RightButton)
        SStitleView.addSubview(leftButton)

        /*
         let button = UIButton(frame: CGRectMake(0, 0, 30, 30))
         button.setImage(UIImage(named: "968"), forState: UIControlState.Normal)
         button.backgroundColor = UIColor.clearColor()
         button.addTarget(self, action: #selector(ServiceViewController.searchActiomn), forControlEvents: UIControlEvents.TouchUpInside)
         button.adjustsImageWhenHighlighted=false //使触摸模式下按钮也不会变暗
         let barBUtton116 = UIBarButtonItem(customView: button)
         self.navigationItem.rightBarButtonItem = barBUtton116
         */
        
        let button = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button.setImage(UIImage(named: "968"), forState: UIControlState.Normal)
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: #selector(LCZSViewController.LCZSAAA), forControlEvents: UIControlEvents.TouchUpInside)
        button.adjustsImageWhenHighlighted=false //使触摸模式下按钮也不会变暗
        let barBUtton116 = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barBUtton116
        
        
        // 设定背景的tableView的视图
        backView = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        print(self.view.bounds.width)
        backView.backgroundColor = UIColor.whiteColor()
        backView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Back11Cell")
        self.backView.separatorStyle = .None
        backView.delegate = self
        backView.dataSource = self
        
//        self.view.addSubview(backView)
        
        
        
        // Do any additional setup after loading the view.
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
        AddVIew()
        
         HEadCollectionHelper.sharedHelper().delegate  = self
    
        
    }
    

    func AddVIew(){
        let TestLabel : UILabel = UILabel(frame: CGRectMake(5,0, 120, 30))
        TestLabel.backgroundColor = UIColor.whiteColor()
        TestLabel.textColor = UIColor.redColor()
        TestLabel.text = "理财顾问推荐"
        backView.addSubview(TestLabel)

        
        let Testlayout = UICollectionViewFlowLayout()
        HeaderCollectionView = UICollectionView(frame: CGRectMake(0, 25, KScreenWidth, 125), collectionViewLayout: Testlayout)
        HeaderCollectionView.backgroundColor = UIColor.whiteColor()
        // 注册cell
        HeaderCollectionView!.registerClass(HradCollecttCollectionViewCell.self, forCellWithReuseIdentifier: "Test11CEll")
        
        HEadCollectionHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/customer/recom/16?token=8c2f64f08271fc4e43")
        // http://appv2.yngw518.com/api.php/customer/recom/16?token=8c2f64f08271fc4e43
        HeaderCollectionView.delegate = self
        HeaderCollectionView.dataSource = self
        Testlayout.scrollDirection = .Horizontal
       
        Testlayout.itemSize = CGSizeMake(85, 95)
        backView.addSubview(HeaderCollectionView)
        
        // **********************************************************
        endTableView = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height),style : UITableViewStyle.Grouped)
        endTableView.backgroundColor = UIColor.whiteColor()
        
        EndLLLHelper.sharedHelper().delegate  = self
        
        // 注册cell
        let MoreCell  = UINib(nibName: "EndTTTViewCell", bundle: nil)
        endTableView.registerNib(MoreCell, forCellReuseIdentifier: endCellID)
        
        endTableView.separatorStyle = .None
        endTableView.delegate = self
        endTableView.dataSource = self
        self.view.addSubview(endTableView)

        weak var weakSelf = self
        endTableView.addHeaderWithCallback { () -> Void in
            isLAZCDOwn = true
            weakSelf?.page = 1
            EndLLLHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/customer/16/1?token=8c2f64f08271fc4e43")
        }
        // 添加尾部刷新
        endTableView.addFooterWithCallback { () -> Void in
            isLAZCDOwn = false
            weakSelf?.page += 1
            /*
             let uirl = NSURL(string: "http://appv2.yngw518.com/api.php/slide/0/5?token=8c2f64f08271fc4e43")
             let  dataLB = NSData(contentsOfURL: uirl!)
             */
            if(weakSelf?.page > 4){
                self.endTableView.removeFooter()
                self.endTableView.removeHeader()
                self.present()
                print("ss")
                
            }else{
                EndLLLHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/customer/16/\((weakSelf?.page)!)?token=8c2f64f08271fc4e43")
//                if ([EndLLLHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/customer/16/\((weakSelf?.page)!)?token=8c2f64f08271fc4e43")] == nil){
//                    self.endTableView.removeFooter()
//                self.endTableView.removeHeader()
//                self.present()
//                print("ss")
//                }else{
//                }
            }
        }
        endTableView.headerBeginRefreshing()        
    }
    
    func present(){
        alertQQ = UIAlertView(title: "", message: "已经没有数据喽", delegate: nil, cancelButtonTitle: nil)

        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(LCZSViewController.dismiss), userInfo: nil, repeats: false)
        alertQQ.show()
    }
    
    func dismiss(){
        alertQQ.dismissWithClickedButtonIndex(0, animated: false)
    }
    
    func Jchat(){
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
                    //                    self.userLoginSave()
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
                    
                    
                    chattingVC.conversation = singleConversation as! JMSGConversation
                    self.navigationController?.pushViewController(chattingVC, animated: true)
                } else {
                    MBProgressHUD.showMessage("添加的用户不存在", view: self.view)
                }
            })
        }
    }
    
    func EndLLLHelperData() {
        
        dispatch_async(dispatch_get_main_queue()) {  () -> Void in
            
            if isLAZCDOwn == true{
                self.endTableView.headerEndRefreshing()
            }else{
                self.endTableView.footerEndRefreshing()
            }
            if (self.endTableView != nil){
                self.endTableView.reloadData()
                
            }else{
                print("22121")
            }
        }

        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let backkkView = UIView(frame: CGRectMake(0, 0, KScreenWidth, 125))
        
        let TestLabel : UILabel = UILabel(frame: CGRectMake(5,0, 120, 30))
        TestLabel.backgroundColor = UIColor.whiteColor()
        TestLabel.textColor = UIColor.redColor()
        TestLabel.text = "理财顾问推荐"
        backkkView.addSubview(TestLabel)
        
        
        let Testlayout = UICollectionViewFlowLayout()
        HeaderCollectionView = UICollectionView(frame: CGRectMake(0, 25, KScreenWidth, 125), collectionViewLayout: Testlayout)
        HeaderCollectionView.backgroundColor = UIColor.whiteColor()
        // 注册cell
        HeaderCollectionView!.registerClass(HradCollecttCollectionViewCell.self, forCellWithReuseIdentifier: "Test11CEll")
        
        HEadCollectionHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/customer/recom?token=8c2f64f08271fc4e43")
        HeaderCollectionView.showsHorizontalScrollIndicator = false
        
        HeaderCollectionView.delegate = self
        HeaderCollectionView.dataSource = self
        Testlayout.scrollDirection = .Horizontal
        backkkView.backgroundColor = UIColor.whiteColor()
        backkkView.addSubview(HeaderCollectionView)
        Testlayout.itemSize = CGSizeMake(85, 95)
        return backkkView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 125
        }
    
    func HEadCollectionReloadData() {
        dispatch_async(dispatch_get_main_queue()) {  () -> Void in
            
            self.HeaderCollectionView!.reloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  HEadCollectionHelper.sharedHelper().dataArray.count
    }
    
    // uicollectionView的点击事件
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
      
        HeaderCollectionView.deselectItemAtIndexPath( indexPath, animated: true)
        
        let hhhweb = HardWEbViewController()
        hhhweb.hidesBottomBarWhenPushed = true
        harrdddmodel = HEadCollectionHelper.sharedHelper().dataArray[indexPath.row] as! HradModel
        hhhweb.TopUrl = harrdddmodel.detailUrl
        
        self.navigationController?.pushViewController(hhhweb, animated: true)
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if  (tableView == backView) {
            print("s000")
        }else if (tableView == endTableView){
            endTableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            let endqweb = HardWEbViewController()
            endqweb.hidesBottomBarWhenPushed = true
             endMMML = EndLLLHelper.sharedHelper().dataArray[indexPath.row] as! EnddddModel
            endqweb.TopUrl = endMMML.detailURL
            self.navigationController?.pushViewController(endqweb, animated: true)

        }
    }

        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // TopCell
        
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("Test11CEll", forIndexPath: indexPath) as! HradCollecttCollectionViewCell
         let ceemodel = HEadCollectionHelper.sharedHelper().dataArray[indexPath.row] as! HradModel
        cell.configureCellWithModel(ceemodel)
        
        
        return cell
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func LCZSAAA(){
        
        let ssseep = SearchViewController()
        self.navigationController?.pushViewController(ssseep, animated: true)
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == backView){
            return 7
        }else if(tableView == endTableView){
            return EndLLLHelper.sharedHelper().dataArray.count
        }
        return 10
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
        if (tableView == backView){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Back11Cell")
            cell.backgroundColor = UIColor.whiteColor()
            cell.selected = false
            
            cell.selectionStyle = .None
        }else if(tableView == endTableView){
            let cell = tableView.dequeueReusableCellWithIdentifier(endCellID, forIndexPath: indexPath) as!  EndTTTViewCell
            cell.ContentLabel.text = "与牛共舞"
            cell.selectionStyle = .None
            
            let ENNNModel = EndLLLHelper.sharedHelper().dataArray[indexPath.row] as! EnddddModel
            
            cell.configureCellWithModel(ENNNModel)
            
            return cell
            
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (tableView == backView){
            return 100
        }else if(tableView == endTableView){
            return 110
        }
        return 110
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.hidesBottomBarWhenPushed = true
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
