//
//  SearchViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var isSearchDow = true



class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FirstSSHelperDelegate{

    var searchModdl : SearchModel!
    
    var searchtableView : UITableView!
    
    var seaCellId = "searchID"
    
    
    var item : UIBarButtonItem!
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
//     texzt.delegate = self
        // 导航栏进行调用
        setSearch()
        self.view.backgroundColor = UIColor.whiteColor()
        // SearchAACCtt

        item  = UIBarButtonItem(title: "搜索", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SearchViewController.SearchAACCtt(_:)))
       
        item.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = item
        
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
        
        createSearchViuew()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchViewController.downloadImage(_:)),name: "passValue", object: nil)
    }
    
    
    func downloadImage(notification : NSNotification){
        
        
//        let message = notification.userInfo as! [String : AnyObject]
//        print(message)
//        let valueq = message["value"] as! String
        
        let text = notification.userInfo!["value"]  as! String
        print("中国的\(text)")
        self.searchtableView.removeHeader()
        self.searchtableView.removeFooter()
//        XZAlertView.addXZAlertView(self.view, title: "没有数据了")
//        self.presentQQQ()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.resignFirstResponder()
    }
        
    override func viewWillAppear(animated: Bool) {
        self.searchtableView.reloadData()
        
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    // 设置导航栏
    func setSearch() {
        navigationItem.titleView = seachBar
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 进行导航栏 print
    private lazy var seachBar:UISearchBar = {
       
        let seachBar = UISearchBar()
        seachBar.placeholder = "最新新闻"
        seachBar.barTintColor = UIColor.whiteColor()
//        seachBar.tintColor = UIColor.blueColor()
        seachBar.searchBarStyle = .Default
     
        
        return seachBar
        
    }()

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
     
    }
    
    // 寻找界面
    func createSearchViuew(){
        self.searchtableView = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        searchtableView.delegate = self
        searchtableView.dataSource = self
        
        let saeaacell = UINib(nibName: "SearchTableViewCell", bundle: nil)
        searchtableView.registerNib(saeaacell, forCellReuseIdentifier: seaCellId)
        
        searchtableView.separatorStyle = .None
        self.view.addSubview(searchtableView)

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.searchtableView.dequeueReusableCellWithIdentifier(seaCellId, forIndexPath: indexPath) as! SearchTableViewCell
        
        let searMool = FirstSearHelper.moneysharedHelper().dataArray[indexPath.row] as! SearchModel
        
        cell.configureCellWithModel(searMool)
        
        return cell
    }
    
    func FirstSearchReloadData() {
        dispatch_async(dispatch_get_main_queue()) {  () -> Void in
            if isSearchDow == true {
                // 如果是下拉, 就停止头部刷新
                self.searchtableView.headerEndRefreshing()
//                self.searchtableView.headerHidden = true
            } else {
                // 如果是上提, 就停止尾部刷新
                self.searchtableView.footerEndRefreshing()
            }
            
            self.searchtableView!.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    func SearchAACCtt(sender : UIBarButtonItem){
        
        
        if (seachBar.text == ""){
            FirstSearHelper.moneysharedHelper().dataArray.removeAllObjects();
            self.searchtableView.reloadData();
            XZAlertView.addXZAlertView(self.view, title: "没有数据")
        }else{
            
            
            
            FirstSearHelper.moneysharedHelper().delegate  = self
            let url  = NSURL(string: "http://appv2.yngw518.com/api.php/search?kwords=\(encodeEscapesURL(seachBar.text!))&page=1&token=8c2f64f08271fc4e43")
            let data = NSData(contentsOfURL: url!)
            
            var json : AnyObject?
            do{
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            }catch let error as NSError{
                print(error)
            }
        
            if ((json?.objectForKey("data") as? NSString) == "没有数据"){
                XZAlertView.addXZAlertView(view, title: "没有数据")
            
            }else{
                weak var weakself = self
                self.searchtableView.addHeaderWithCallback {  () -> Void in
                    isSearchDow = true
                    FirstSearHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/search?kwords=\(self.encodeEscapesURL(self.seachBar.text!))&page=1&token=8c2f64f08271fc4e43")
                }
                
                self.searchtableView.addFooterWithCallback { () -> Void in
                    isSearchDow = false
                    
                    weakself!.page += 1
                    
                    FirstSearHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/search?kwords=\(self.encodeEscapesURL(self.seachBar.text!))&page=\((weakself?.page)!)&token=8c2f64f08271fc4e43")
                let sss =     FirstSearHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/search?kwords=\(self.encodeEscapesURL(self.seachBar.text!))&page=\((weakself?.page)!)&token=8c2f64f08271fc4e43")
                    
                    
                    TagSearch = NSUserDefaults.standardUserDefaults().objectForKey("TagSearch") as? NSString
//                    if (TagSearch == "没有数据"){
//                         print("这个是搜索数据没有的新号标志")
//                        self.presentQQQ()
//                       
//                        //                        self.searchtableView.removeFooter()
//                        //                        self.searchtableView.removeHeader()
//                    }
//                    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchViewController.downloadImage), name: "passValue", object: nil)
//                   NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchViewController.downloadImage(_:)), name: "", object: nil)
                }
                self.searchtableView.headerBeginRefreshing()
            }
        }
    }
    
    
    
    // 移除监听
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // 收到通知post后执行方法
    func getValue(notification:NSNotification) {
        // 赋值
        // 移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "passValue", object: nil)
    }
    
    func presentQQQ(){
        alertQQ = UIAlertView(title: "", message: "已经没有数据喽", delegate: nil, cancelButtonTitle: nil)
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(SearchViewController.dismiss), userInfo: nil, repeats: false)
        alertQQ.show()
    }
    
    func dismiss(){
        alertQQ.dismissWithClickedButtonIndex(0, animated: false)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true
    }
    
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.searchtableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.hidesBottomBarWhenPushed = true
        let searweb = searchWebView()
        
        searchModdl = FirstSearHelper.moneysharedHelper().dataArray[indexPath.row] as! SearchModel
        
        searweb.nextdetailUrl = searchModdl.detailUrl
       
        self.navigationController?.pushViewController(searweb, animated: true)

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  FirstSearHelper.moneysharedHelper().dataArray.count
    }
    
   
    
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
