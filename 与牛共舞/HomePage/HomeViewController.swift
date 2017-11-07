 //
 //  HomeViewController.swift
 //  与牛共舞
 
 //  Created by Mac on 16/8/29.
 //  Copyright © 2016年 Mac. All rights reserved.
 
 
 import UIKit
 
 var Tagchange = 1
 
 var TagTired : NSNumber?
 
 var BecomChangeViewThing : UIViewController!
 
 @objc(HomeViewController)
 class HomeViewController: BaseViewController,CirCleViewDelegate,UITableViewDelegate,UITableViewDataSource, NetWorkHelperDelegate,FontThreeNetWorkHelperDelegate,EveryThreeNetWorkHelperDelegate,SDCycleScrollViewDelegate,ScrollerHeadHelperDelegate {
    
    
    var openKefu:Bool=false
    
    var tableData: [String] = ["BMW", "Ferrari", "Lambo"]
    // 排行前三新闻
    var FontThreeTableView:UITableView!
    var FontThreeCell =  "FontCell"
    // 轮播图的数据源
    var headScrooArray  =  NSMutableArray()
    
    // 轮播图中的web的连接
    var headWebScrollArray = NSMutableArray()
    
    // 每日电讯三个视图
    var EveryThreeTableView:UITableView!
    var Carcell = "CarCell"
    
    var threeMode : FontThreeModel!
    var EveRRYYModel : EveryThree!
    var CowFivvvModel : FiveIdeaModel!
    // 牛股情报站
    var cowFiveTableView:UITableView!
    var cell1 = UITableViewCell()
    var cowFiveIdent = "CowCellident"
    
    // 设置为fontthree的数组
    var itemss =  NSMutableArray()
    
    // 设置一个参数
    var fontThreeSegue  = "fontThreSegue"
    var DataWeb = NSString()
    // 下面tableView中的cell  更多内容
    var creatCell = UITableViewCell()
    // 定义一个tableview和数组
    var creatTableView:UITableView!
    var array = ["0", "0", "0", "0", "0", "0", "0"]
    
    //   weak var scrollHeaderView : SDCycleScrollView!
    
    // 设置为全局变量
    var FirstViewForMM : TTScrolSegmentView!
    
    // 轮播图
    //    let scrollHeaderView = SDCycleScrollView()
    //    var  scrollHeaderView : SDCycleScrollView!
    
    override func viewDidAppear(animated: Bool) {
        if openKefu {
            //            dispatch_q.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            //                //code
            //                print("1 秒后输出")
            //                let serView = ServiceViewController()
            //                self.navigationController?.pushViewController(serView, animated: true)
            //            }
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        
        //        self.edgesForExtendedLayout = 0
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 216 / 256.0, green: 216 / 256.0, blue: 216 / 256.0, alpha: 1.0)
        
        
        let item = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        item.tintColor = UIColor.whiteColor()
        //        item.image = UIImage(named: "back4.png")
        self.navigationItem.backBarButtonItem = item
        
        
        // 设置代理  redcolor
        NetWorkHelper.sharedHelper().delegate = self
        
        NetWorkHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: KFiveUrl)
        FontThreeHelper.sharedHelper().delegate = self
        FontThreeHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/index/recom?token=8c2f64f08271fc4e43")
        
        EveryThreeHelper.sharedHelper().delegate = self
        EveryThreeHelper.sharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/index/colart?token=8c2f64f08271fc4e43")
        
        self.navigationController?.navigationBar.hidden =  false
        
        let HHHeaderView = UIView(frame: CGRectMake(0, 0, 200, 30))
        HHHeaderView.backgroundColor = UIColor.clearColor()
        
        let headImage = UIImageView(frame: CGRectMake(34, 0, 42, 35))
        headImage.image = UIImage(named: "logo")
        HHHeaderView.addSubview(headImage)
        
        let LasssImage = UIImageView(frame: CGRectMake( 73, 5, 80, 25))
        LasssImage.image = UIImage(named: "main-title")
        HHHeaderView.addSubview(LasssImage)
        
        self.navigationItem.titleView =  HHHeaderView
        
        self.navigationController!.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 246 / 255.0, green: 75 / 255.0 , blue: 22 / 255.0, alpha: 1.0)
        let button116 = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button116.setImage(UIImage(named: "搜索001"), forState: UIControlState.Normal)
        button116.backgroundColor = UIColor.clearColor()
        button116.addTarget(self, action: #selector(HomeViewController.searchBarView), forControlEvents: UIControlEvents.TouchUpInside)
        button116.adjustsImageWhenHighlighted = false
        let barBUtton1161 = UIBarButtonItem(customView: button116)
        self.navigationItem.rightBarButtonItem = barBUtton1161
        
        
        topFourButtonView()
        creatTableView = UITableView(frame: CGRectMake(0, 104, self.view.bounds.width, self.view.bounds.height - 70))
        creatTableView.delegate = self
        creatTableView.dataSource = self
        
        creatTableView.backgroundColor = UIColor.clearColor()
        creatTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        creatTableView.userInteractionEnabled = true
        // 导航栏不隐蔽
        self.navigationController?.navigationBarHidden = false
        // 设置tableView的分割线的颜色
        creatTableView.separatorColor = UIColor.clearColor()
        // 各种视图的调用
        creatFontVView()
        creatEightButton()
        creatScrollView()
        topFourButtonView()
        self.view.addSubview(creatTableView)
        creatEveryThreeView()
        cretaCoWMoreView()
        creatCowIdeiaView()
    }
    
    
    //     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    // 协议中的方法
    func tableViewReloadData() {
        // 回到主线程刷新UI  search
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            
            self.cowFiveTableView.reloadData()
        }
    }
    
    
    // 协议中的方法
    func FontThreetableViewReloadData() {
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            
            self.FontThreeTableView.reloadData()
        }
    }
    
    func EveryThreetableViewReloadData() {
        
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            
            self.EveryThreeTableView.reloadData()
        }
    }
    
    
    /*
     * section 的方法
     */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    // 有几行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == creatTableView){
            return array.count
        }else if(tableView == FontThreeTableView){
            return FontThreeHelper.sharedHelper().dataArray.count
        }else if(tableView == EveryThreeTableView){
            return EveryThreeHelper.sharedHelper().dataArray.count
        }else if(tableView == cowFiveTableView){
            return NetWorkHelper.sharedHelper().dataArray.count
        }
        
        return 0
    }
    
    // cell的高度 green
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (tableView == creatTableView){
            return 128
        }else if(tableView == FontThreeTableView){
            return 40
        }else if(tableView == EveryThreeTableView){
            return 40
        }else if(tableView == cowFiveTableView){
            return 40
        }
        return 0
    }
    
    
    // tableView的点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.hidesBottomBarWhenPushed = true
        if (tableView ==  creatTableView){
        }
        if  (tableView == FontThreeTableView) {
            
            self.FontThreeTableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            let webview = WebViewController()
            
            threeMode = FontThreeHelper.sharedHelper().dataArray[indexPath.row] as! FontThreeModel
            webview.detailUrl = threeMode.weburl
            
            self.navigationController?.pushViewController(webview, animated: true)
        }
        
        if (tableView == EveryThreeTableView){
            self.EveryThreeTableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            let eveWeb = EveryWebViewController()
            EveRRYYModel = EveryThreeHelper.sharedHelper().dataArray[indexPath.row] as! EveryThree
            eveWeb.everyUrl = EveRRYYModel.everyWeburl
            self.navigationController?.pushViewController(eveWeb, animated: true)
            
        }
        
        if(tableView == cowFiveTableView){
            self.cowFiveTableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            let cowWebView = CowFiveWebViewController()
            CowFivvvModel = NetWorkHelper.sharedHelper().dataArray[indexPath.row] as! FiveIdeaModel
            cowWebView.cowFiveUrl = CowFivvvModel.cowFiveUrl1!
            self.navigationController?.pushViewController(cowWebView, animated: true)
        }
        self.hidesBottomBarWhenPushed = false
    }
    
    
    /*
     *  设定tableview的cell
     */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if(tableView == creatTableView){
            cell = TableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            //         gray
            
            
            cell.backgroundColor = UIColor(red: 216 / 256.0, green: 216 / 256.0, blue: 216 / 256.0, alpha: 1.0)
            cell.selected = false
            
            
            
        }else if(tableView == FontThreeTableView){
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier(self.FontThreeCell, forIndexPath: indexPath) as! FontThreeTableViewCell
            switch indexPath.row {
            case 0 :
                cell.HeaderImageView.image = UIImage(named: "1")
            case 1 :
                cell.HeaderImageView.image = UIImage(named: "2")
            case 2:
                cell.HeaderImageView.image = UIImage(named: "3")
            default: break
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = UIColor.whiteColor()
            cell.selectedBackgroundView?.backgroundColor = UIColor.clearColor()
            let fontThreeMModel = FontThreeHelper.sharedHelper().dataArray[indexPath.row] as! FontThreeModel
            
            //            self.DataWeb = FontThreeModel.
            cell.configureFontCellWithModel(fontThreeMModel)
            
            return cell
            
        }else if(tableView ==  EveryThreeTableView){
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier(self.Carcell, forIndexPath: indexPath) as!  CarrrViewCell
            
            let eveTThtrrModel = EveryThreeHelper.sharedHelper().dataArray[indexPath.row] as! EveryThree
            cell.configureFontCellWithModel(eveTThtrrModel)
            cell.selectedBackgroundView?.backgroundColor = UIColor.clearColor()
            switch indexPath.row {
            case 0 :
                cell.headerimageView.image = UIImage(named: "每日电讯")
            case 1 :
                cell.headerimageView.image = UIImage(named: "行家选股")
            case 2:
                cell.headerimageView.image = UIImage(named: "主力动向")
            default: break
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
        }else if(tableView == cowFiveTableView){
            let cell = tableView.dequeueReusableCellWithIdentifier(cowFiveIdent.self, forIndexPath: indexPath) as! CowFiveTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            //            cell.textLabel?.text = "0909期-每日涨停预期预示热"
            // 获取数据源
            let fiveMMdel = NetWorkHelper.sharedHelper().dataArray[indexPath.row] as! FiveIdeaModel
            // 给cell布局  // 牛股情报站
            cell.configureCellWithModel(fiveMMdel)
            
            cell.selectedBackgroundView?.backgroundColor = UIColor.clearColor()
            
            return cell
            
        }
        return cell
    }
    
    
    
    
    // 创建牛股情报站的1
    func creatCowIdeiaView(){
        
        cowFiveTableView = UITableView(frame: CGRectMake(0,610, self.view.bounds.width, 200))
        cowFiveTableView.backgroundColor =  UIColor.whiteColor()
        cowFiveTableView.delegate = self
        cowFiveTableView.dataSource = self
        // 注册cell
        let cellNIb = UINib(nibName: "CowFiveTableViewCell", bundle: nil)
        cowFiveTableView.registerNib(cellNIb, forCellReuseIdentifier: cowFiveIdent)
        
        creatTableView.addSubview(cowFiveTableView)
    }
    
    
    // 创建每日报报站的视图
    func creatEveryThreeView(){
        EveryThreeTableView = UITableView(frame: CGRectMake(0, 450, self.view.bounds.width, 120))
        EveryThreeTableView.backgroundColor = UIColor.whiteColor()
        // 注册cell
        let cellNib = UINib(nibName: "CarrrViewCell", bundle: nil)
        EveryThreeTableView.registerNib(cellNib, forCellReuseIdentifier: Carcell)
        EveryThreeTableView.delegate = self
        EveryThreeTableView.dataSource = self
        
        creatTableView.addSubview(EveryThreeTableView)
    }
    
    
    // 创建上面的三个tableViewCell所出现的视图
    func creatFontVView(){
        FontThreeTableView = UITableView(frame: CGRectMake(0, 323, self.view.bounds.width, 120))
        FontThreeTableView.backgroundColor = UIColor.whiteColor()
        
        // 注册cell
        let cellNib = UINib(nibName: "FontThreeTableViewCell", bundle: nil)
        FontThreeTableView.registerNib(cellNib, forCellReuseIdentifier: FontThreeCell)
        
        FontThreeTableView.delegate = self
        FontThreeTableView.dataSource = self
        
        
        creatTableView.addSubview(FontThreeTableView)
        //        self.showData()
    }
    
    
    
    
    /*
     *  设定牛股情报站的页面  redColor()
     */
    
    func cretaCoWMoreView(){
        
        let titleCowMoreView : UIView = UIView(frame: CGRectMake(0,577,self.view.bounds.width,40))
        titleCowMoreView.backgroundColor = UIColor.whiteColor()
        
        let titlbutton : UILabel = UILabel(frame: CGRectMake(19, 5, self.view.bounds.width / 3, 30))
        
        titlbutton.text = "牛股情报站"
        titlbutton.alpha = 0.7
        titleCowMoreView.addSubview(titlbutton)
        titlbutton.font = UIFont.italicSystemFontOfSize(14)
        
        let headerLittle = UILabel(frame: CGRectMake(13, 10, 2.5, 18))
        headerLittle.backgroundColor = UIColor.redColor()
        titleCowMoreView.addSubview(headerLittle)
        
        let moreButton : UIButton = UIButton(frame: CGRectMake(self.view.bounds.width * 0.75 - 30, 12,self.view.bounds.width * 0.4, 20))
        moreButton.alpha = 0.7
        //        UIBackgroundFetchResult
        moreButton.setTitle("更多情报站内容", forState: UIControlState.Normal)
        moreButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        moreButton.addTarget(self, action: #selector(HomeViewController.moreViewAction), forControlEvents: UIControlEvents.TouchUpInside)
        moreButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        titleCowMoreView.addSubview(moreButton)
        
        creatTableView.addSubview(titleCowMoreView)
        
    }
    
    // 牛股情报站更多内容的按钮  推荐
    func moreViewAction(){
        
        NSThread.sleepForTimeInterval(0.2)
        self.tabBarController?.selectedIndex = 2
        TagTired = 0
        NSNotificationCenter.defaultCenter().postNotificationName("tiao", object:"123", userInfo: ["偏移量" : 1]);
    }
    
    // 创建上面四个button的视图
    func topFourButtonView() {
        
        
        let fourButtonView = UIView(frame: CGRectMake(0, 64, KScreenWidth, 40))
        
        fourButtonView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(fourButtonView)
        
        // 新闻精选  greencolor
        let button1 = UIButton(frame: CGRectMake(5,8,KScreenWidth / 4 - 10,24))
        
        button1.setTitle("新闻精选", forState: UIControlState.Normal)
        button1.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        button1.titleLabel?.font = UIFont.systemFontOfSize(15)
        let label11 = UILabel(frame: CGRectMake(5, 36, 80, 1.5))
        label11.backgroundColor = UIColor.orangeColor()
        label11.alpha = 0.7
        //        button1.alpha = 0.8
        fourButtonView.addSubview(label11)
        
        fourButtonView.addSubview(button1)
        
        button1.addTarget(self, action: #selector(HomeViewController.button1View), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        // 行情数据
        let button2 = UIButton(frame: CGRectMake(KScreenWidth / 4,8,KScreenWidth / 4 - 10,24))
        button2.setTitle("行情数据", forState: UIControlState.Normal)
        button2.titleLabel?.font = UIFont.systemFontOfSize(15)
        button2.alpha = 0.7
        button2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button2.addTarget(self, action: #selector(HomeViewController.Button2View), forControlEvents: UIControlEvents.TouchUpInside)
        fourButtonView.addSubview(button2)
        
        // 牛股情报站
        let button3 = UIButton(frame: CGRectMake(KScreenWidth / 2,8,100,24))
        button3.setTitle("牛股情报", forState: UIControlState.Normal)
        button3.titleLabel?.font = UIFont.systemFontOfSize(15)
        button3.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button3.alpha = 0.7
        button3.addTarget(self, action: #selector(HomeViewController.button3View), forControlEvents: UIControlEvents.TouchUpInside)
        fourButtonView.addSubview(button3)
        
        // 客服团队
        let button4 = UIButton(frame: CGRectMake(KScreenWidth / 4 * 3 + 10,8,75,24))
        button4.setTitle("客服团队", forState: UIControlState.Normal)
        button4.titleLabel?.font = UIFont.systemFontOfSize(15)
        button4.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button4.alpha = 0.7
        button4.addTarget(self, action: #selector(HomeViewController.button4View), forControlEvents: UIControlEvents.TouchUpInside)
        fourButtonView.addSubview(button4)
    }
    
    func button4View(){
        self.hidesBottomBarWhenPushed = true
        let serviceView = ServiceViewController()
        navigationController?.pushViewController(serviceView, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    
    // 牛股情报站的按钮
    func button3View(){
        
        NSThread.sleepForTimeInterval(0.2)
        self.tabBarController?.selectedIndex = 2
        TagTired = 0
        NSNotificationCenter.defaultCenter().postNotificationName("tiao", object:"123", userInfo: ["偏移量" : 1]);
    }
    
    
    // 行情数据的点击按钮
    func Button2View() {
        NSThread.sleepForTimeInterval(0.2)
        self.tabBarController?.selectedIndex = 1
        //        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        //        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("fiveonefive_main") as! ViewController
        //        self.presentViewController(anotherView, animated: true, completion: nil)
    }
    
    
    // 新闻精选点击事件
    func button1View(){
        
        NSThread.sleepForTimeInterval(0.2)
        self.tabBarController?.selectedIndex = 2
        TagTired = 0
        NSNotificationCenter.defaultCenter().postNotificationName("pianyi", object:"123", userInfo: ["偏移量" : 1]);
        
    }
    
    
    // 查询出现的界面 reloadData
    func searchBarView(){
        self.hidesBottomBarWhenPushed = true
        let searchBarVC = SearchViewController()
        
        navigationController?.pushViewController(searchBarVC, animated: true)
        
        self.hidesBottomBarWhenPushed = false
    }
    
    
    func ScrollerHeadReloadData() {
        dispatch_async(dispatch_get_main_queue()) {  () -> Void in
            
            
        }
        
    }
    
    // 创建无限轮播的视图
    func creatScrollView(){
        
        let scrollView = UIView(frame: CGRectMake(0,0,self.view.bounds.width,115))
        scrollView.backgroundColor = UIColor.whiteColor()
        //            self.view.addSubview(scrollView)
        
        let sdcHHeadView = UIScrollView()
        sdcHHeadView.frame = CGRectMake(0, 0, KScreenWidth, 115)
        sdcHHeadView.contentSize = CGSizeMake(KScreenWidth, 1200)
        self.view.addSubview(sdcHHeadView)
        
        let uirl = NSURL(string: "http://appv2.yngw518.com/api.php/slide/0/5?token=8c2f64f08271fc4e43")
        let  dataLB = NSData(contentsOfURL: uirl!)
        let  str = NSString(data: dataLB!, encoding: NSUTF8StringEncoding)
        var json : AnyObject?
        do{
            json = try NSJSONSerialization.JSONObjectWithData(dataLB!, options: NSJSONReadingOptions.AllowFragments)
        }catch let error as NSError{
        }
        
        let arr = json!["data"] as! NSArray
        
        for MyselfScr in arr {
            
            //            self.headScrooArray.addObjectsFromArray((MyselfScr["image"] as? [AnyObject])!)
            //            self.headScrooArray.addObjectsFromArray((MyselfScr["image"] as? [AnyObject])!)
            //            self.headScrooArray.addObject(MyselfScr["image"])
            
            let testScrollView = MyselfScr["image"] as? String
            
            self.headScrooArray.addObject(testScrollView!)
        }
        
        
        // 1、创建无线轮播器   设置frame 牛股情报站
        //        self.automaticallyAdjustsScrollViewInsets = false
        //        let imageArray: NSArray = ["http://appv2.yngw518.com/uploadfiles/1481850518.jpg","http://appv2.yngw518.com/uploadfiles/1481166881.jpg","http://appv2.yngw518.com/uploadfiles/1481166897.jpg","http://appv2.yngw518.com/uploadfiles/1481166914.jpg"]
        
        let imageArray  = self.headScrooArray
        
        let scrollHeaderView = SDCycleScrollView()
        scrollHeaderView.frame = CGRectMake(0, 0, KScreenWidth, 115)
        scrollHeaderView.delegate = self
        
        scrollHeaderView.placeholderImage = UIImage(named: "placeholder")
        scrollHeaderView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        sdcHHeadView.addSubview(scrollHeaderView)
        
        // 模拟加载延迟
        //        scrollHeaderView.imageURLStringsGroup = imageArray as [AnyObject]
        scrollHeaderView.imageURLStringsGroup = imageArray as [AnyObject]
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (UInt64)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(),{
        //
        
        
        creatTableView.addSubview(sdcHHeadView)
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        self.hidesBottomBarWhenPushed = true
        let uirl = NSURL(string: "http://appv2.yngw518.com/api.php/slide/0/5?token=8c2f64f08271fc4e43")
        let  dataLB = NSData(contentsOfURL: uirl!)
        let  str = NSString(data: dataLB!, encoding: NSUTF8StringEncoding)
        var json : AnyObject?
        do{
            json = try NSJSONSerialization.JSONObjectWithData(dataLB!, options: NSJSONReadingOptions.AllowFragments)
        }catch let error as NSError{
        }
        
        let arr = json!["data"] as! NSArray
        
        for MyselfScr in arr {
            
            let headWebView = MyselfScr["detail_url"] as? String
            
            self.headWebScrollArray.addObject(headWebView!)
            
            let testScrollView = MyselfScr["image"] as? String
            
            self.headScrooArray.addObject(testScrollView!)
        }
        
        
        let topSScrollview = TopScrollview()
        self.navigationController?.pushViewController(topSScrollview, animated: true)
        
        topSScrollview.detailUrl = (headWebScrollArray[index] as! String) + "?token=8c2f64f08271fc4e43"
        self.hidesBottomBarWhenPushed = false
    }
    
    
    
    
    
    // 创建八个按钮视图  grayColor
    func creatEightButton(){
        
        let eightView = UIView(frame: CGRectMake(0,115,UIScreen.mainScreen().bounds.size.width,100))
        eightView.backgroundColor = UIColor.whiteColor()
        
        creatTableView.addSubview(eightView)
        
        let centerlittlelabel = UILabel(frame: CGRectMake(0, 100, eightView.bounds.width, 2))
        centerlittlelabel.backgroundColor = UIColor.grayColor()
        
        creatTableView.addSubview(centerlittlelabel)
        
        // 自选股
        let selfButton = UIButton()
        selfButton.frame = CGRectMake(0,0,eightView.bounds.width / 4,100)
        
        let selfView = UIImageView()
        selfView.frame = CGRectMake(20, 10, 50, 50)
        selfView.image = UIImage(named: "zixuangu.png")
        
        
        let selfLabel = UILabel()
        selfLabel.frame = CGRectMake(23, 68, 60, 25)
        selfLabel.font = UIFont.systemFontOfSize(14)
        //        selfLabel.adjustsFontSizeToFitWidth = true
        selfLabel.layer.borderWidth = 0
        selfLabel.alpha = 0.7
        selfLabel.text = "自选股"
        
        selfButton.addSubview(selfLabel)
        selfButton.addSubview(selfView)
        
        selfButton.backgroundColor = UIColor.whiteColor()
        selfButton.addTarget(self, action: #selector(HomeViewController.selfView), forControlEvents: UIControlEvents.TouchUpInside)
        
        eightView.addSubview(selfButton)
        
        // 大势研判
        let moneyButton = UIButton(frame: CGRectMake(eightView.bounds.width / 4,0,eightView.bounds.width / 4,100))
        moneyButton.backgroundColor = UIColor.whiteColor()
        //            moneyButton.setImage(UIImage(named: "zw2.png"), forState: .Normal)
        moneyButton.addTarget(self, action: #selector(HomeViewController.MoneyView), forControlEvents: UIControlEvents.TouchUpInside)
        
        let selfView2 = UIImageView()
        selfView2.frame = CGRectMake(20, 10, 50, 50)
        selfView2.image = UIImage(named: "caifu.png")
        
        let selfLabel2 = UILabel()
        selfLabel2.frame = CGRectMake(17, 68, 60, 25)
        selfLabel2.font = UIFont.systemFontOfSize(14)
        selfLabel2.alpha = 0.7
        //        selfLabel.adjustsFontSizeToFitWidth = true
        selfLabel2.layer.borderWidth = 0
        selfLabel2.text = "大势研判"
        
        moneyButton.addSubview(selfView2)
        moneyButton.addSubview(selfLabel2)
        
        eightView.addSubview(moneyButton)
        
        // 传闻揭秘
        let hearButton = UIButton(frame: CGRectMake(eightView.bounds.width / 2,0, eightView.bounds.width / 4, 100))
        let selfView3 = UIImageView()
        selfView3.frame = CGRectMake(20, 10, 50, 50)
        selfView3.image = UIImage(named: "zhuanti")
        hearButton.addTarget(self, action: #selector(HomeViewController.HearAction), forControlEvents: UIControlEvents.TouchUpInside)
        let selfLabel3 = UILabel()
        selfLabel3.frame = CGRectMake(17, 68, 60, 25)
        selfLabel3.font = UIFont.systemFontOfSize(14)
        //        selfLabel.adjustsFontSizeToFitWidth = true
        selfLabel3.layer.borderWidth = 0
        selfLabel3.text = "传闻揭秘"
        selfLabel3.alpha = 0.7
        
        hearButton.addSubview(selfView3)
        hearButton.addSubview(selfLabel3)
        eightView.addSubview(hearButton)
        
        // 牛人战报
        let godButton = UIButton(frame: CGRectMake(eightView.bounds.width * 0.75, 0, eightView.bounds.width / 4, 100))
        godButton.addTarget(self, action: #selector(HomeViewController.GodACCtion), forControlEvents: UIControlEvents.TouchUpInside)
        let selfView4 = UIImageView()
        selfView4.frame = CGRectMake(20, 10, 50, 50)
        selfView4.image = UIImage(named: "zhanbao")
        
        
        let selfLabel4 = UILabel()
        selfLabel4.alpha = 0.7
        selfLabel4.frame = CGRectMake(17, 68, 60, 25)
        selfLabel4.font = UIFont.systemFontOfSize(14)
        //        selfLabel.adjustsFontSizeToFitWidth = true
        selfLabel4.layer.borderWidth = 0
        selfLabel4.text = "高手追踪"
        
        godButton.addSubview(selfView4)
        godButton.addSubview(selfLabel4)
        eightView.addSubview(godButton)
        
        
        let eightView1 = UIView(frame: CGRectMake(0,217,self.view.bounds.width,100))
        eightView1.backgroundColor = UIColor.whiteColor()
        creatTableView.addSubview(eightView1)
        // 专题研究
        let specialButton = UIButton(frame: CGRectMake(0,0,eightView.bounds.width / 4, 100))
        let selfView5 = UIImageView()
        selfView5.frame = CGRectMake(20, 10, 50, 50)
        selfView5.image = UIImage(named: "xuangu")
        specialButton.addTarget(self, action: #selector(HomeViewController.specialACCtion), forControlEvents: UIControlEvents.TouchUpInside)
        let selfLabel5 = UILabel()
        selfLabel5.frame = CGRectMake(17, 68, 60, 25)
        selfLabel5.font = UIFont.systemFontOfSize(14)
        //        selfLabel.adjustsFontSizeToFitWidth = true
        selfLabel5.layer.borderWidth = 0
        selfLabel5.alpha = 0.7
        selfLabel5.text = "专题研究"
        
        specialButton.addSubview(selfView5)
        specialButton.addSubview(selfLabel5)
        eightView1.addSubview(specialButton)
        
        // 盘中播报
        let dishButton = UIButton(frame: CGRectMake(eightView.bounds.width / 4,0,eightView.bounds.width / 4, 100))
        dishButton.addTarget(self, action: #selector(HomeViewController.PZBBAction), forControlEvents: UIControlEvents.TouchUpInside)
        let selfView6 = UIImageView()
        selfView6.frame = CGRectMake(20, 10, 50, 50)
        selfView6.image = UIImage(named: "video")
        
        let selfLabel6 = UILabel()
        selfLabel6.frame = CGRectMake(17, 68, 60, 25)
        selfLabel6.font = UIFont.systemFontOfSize(14)
        //        selfLabel.adjustsFontSizeToFitWidth = true
        selfLabel6.layer.borderWidth = 0
        selfLabel6.text = "盘中播报"
        selfLabel6.alpha = 0.7
        
        dishButton.addSubview(selfView6)
        dishButton.addSubview(selfLabel6)
        eightView1.addSubview(dishButton)
        
        // 视频点金
        let videoButton = UIButton(frame: CGRectMake(eightView.bounds.width * 0.5,0,eightView.bounds.width / 4, 100))
        let selfView7 = UIImageView()
        selfView7.frame = CGRectMake(20, 10, 50, 50)
        selfView7.image = UIImage(named: "panzhong")
        videoButton.addTarget(self, action: #selector(HomeViewController.videoGoldAction), forControlEvents: UIControlEvents.TouchUpInside)
        let selfLabel7 = UILabel()
        selfLabel7.frame = CGRectMake(17, 68, 60, 25)
        selfLabel7.font = UIFont.systemFontOfSize(14)
        selfLabel7.alpha = 0.7
        selfLabel7.layer.borderWidth = 0
        selfLabel7.text = "视频点金"
        
        videoButton.addSubview(selfView7)
        videoButton.addSubview(selfLabel7)
        eightView1.addSubview(videoButton)
        
        // 理财助手
        let managerButton = UIButton(frame: CGRectMake(eightView.bounds.width * 0.75, 0, eightView.bounds.width / 4, 100))
        let selfView8 = UIImageView()
        selfView8.frame = CGRectMake(20, 10, 50, 50)
        selfView8.image = UIImage(named: "licai")
        managerButton.addTarget(self, action: #selector(HomeViewController.LCZSAction), forControlEvents: UIControlEvents.TouchUpInside)
        let selfLabel8 = UILabel()
        selfLabel8.frame = CGRectMake(17, 68, 60, 25)
        selfLabel8.font = UIFont.systemFontOfSize(14)
        selfLabel8.layer.borderWidth = 0
        selfLabel8.alpha = 0.7
        selfLabel8.text = "理财助手"
        
        managerButton.addSubview(selfView8)
        managerButton.addSubview(selfLabel8)
        eightView1.addSubview(managerButton)
    }
    
    func LCZSAction(){
        self.hidesBottomBarWhenPushed = true
        let LCZS  = LCZSViewController()
        self.navigationController?.pushViewController(LCZS, animated: true)
        self.hidesBottomBarWhenPushed =  false
    }
    
    // 盘中播报
    func PZBBAction(){
        
        self.hidesBottomBarWhenPushed = true
        let pzz = PZBBTableViewController()
        self.navigationController?.pushViewController(pzz, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    
    // 自选股
    func selfView(){
        NSThread.sleepForTimeInterval(0.2)
        self.tabBarController?.selectedIndex = 1
        //        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        //        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("fiveonefive_main") as! ViewController
        //        self.presentViewController(anotherView, animated: true, completion: nil)
        
    }
    
    
    
    // 大势研判
    func MoneyView(){
        NSThread.sleepForTimeInterval(0.2)
        self.tabBarController?.selectedIndex = 2
        TagTired = 0
        NSNotificationCenter.defaultCenter().postNotificationName("pianyi", object:"123", userInfo: ["偏移量" : 1]);
    }
    
    
    
    
    // 传闻揭秘
    func HearAction(){
        NSThread.sleepForTimeInterval(0.2)
        self.tabBarController?.selectedIndex = 2
        TagTired = 2
        NSNotificationCenter.defaultCenter().postNotificationName("pianyi", object:"123", userInfo: ["偏移量" : 1]);
    }
    
    
    
    // 牛人战报
    func GodACCtion(){
        
        NSThread.sleepForTimeInterval(0.2)
        self.tabBarController?.selectedIndex = 2
        TagTired = 3
        NSNotificationCenter.defaultCenter().postNotificationName("tiao", object:"123", userInfo: ["偏移量" : 1]);
    }
    
    // 专题研究
    func specialACCtion(){
        NSThread.sleepForTimeInterval(0.2)
        self.tabBarController?.selectedIndex = 2
        TagTired = 1
        NSNotificationCenter.defaultCenter().postNotificationName("tiao", object:"123", userInfo: ["偏移量" : 1]);
        
    }
    
    // 视频点金
    func videoGoldAction(){
        
        NSThread.sleepForTimeInterval(1)
        self.tabBarController?.selectedIndex = 2
        TagTired = 4
        NSNotificationCenter.defaultCenter().postNotificationName("tiao", object:"123", userInfo: ["偏移量" : 1]);
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        MobClick.endLogPageView("PageOne")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // 毛玻璃效果
        MobClick.beginLogPageView("PageOne")
        self.navigationController!.navigationBar.translucent = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
 }
