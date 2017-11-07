
//
//  SpecialSearchViewController.swift
//  与牛共舞
//
//  Created by dm on 16/10/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var specialSpecialDown = true

class SpecialSearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,SpecialSearchHelperDelegate {
    
    var specialMMM : SpecialSearchModel!
    
    var headerrView : UIView!
    
    var searchTitle : UIView!
    
    var specilSrarchID = "specialSerachIdd"
    
    var specialTableView : UITableView!
    
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.view.backgroundColor = UIColor.whiteColor()
        headerrView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, 64))
        headerrView.backgroundColor = UIColor.init(red: 255 / 255.0, green: 70 / 255.0, blue: 48 / 255.0, alpha: 1.0)
        self.view.addSubview(headerrView)
      
        
        
        searchTitle = UIView(frame: CGRectMake(60, 25, seachBar.bounds.width + 10, seachBar.bounds.height))
        searchTitle.backgroundColor = UIColor.whiteColor()
        searchTitle.layer.cornerRadius = 6
        
        let seraButt = UIButton(frame: CGRectMake(searchTitle.bounds.width + 70, 25, 60, 30))
        seraButt.setTitle("搜索", forState: UIControlState.Normal)
        seraButt.adjustsImageWhenHighlighted = false
        seraButt.titleLabel?.tintColor = UIColor.whiteColor()
        seraButt.backgroundColor = UIColor.init(red: 255 / 255.0, green: 70 / 255.0, blue: 48 / 255.0, alpha: 1.0)
//        seraButt.backgroundColor = UIColor.blackColor()


        seraButt.addTarget(self, action: #selector(SpecialSearchViewController.SpecilAc), forControlEvents: UIControlEvents.TouchUpInside)
        
        headerrView.addSubview(seraButt)
     
        searchTitle.addSubview(seachBar)
        self.view.addSubview(searchTitle)
        
        let backButton = UIButton(frame: CGRectMake(5, 30, 30, 30))
        backButton.setImage(UIImage(named: "back00.png"), forState: UIControlState.Normal)
        backButton.adjustsImageWhenHighlighted = false
        backButton.addTarget(self, action: #selector(SpecialSearchViewController.BacA), forControlEvents: UIControlEvents.TouchUpInside)
        headerrView.addSubview(backButton)
        
        createSearchViuew()
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SpecialSearchViewController.downloadImage(_:)),name: "passValueSP", object: nil)
    }
    
    
    func downloadImage(notification : NSNotification){
        
        
        //        let message = notification.userInfo as! [String : AnyObject]
        //        print(message)
        //        let valueq = message["value"] as! String
        
        let text = notification.userInfo!["value"]  as! String
        self.specialTableView.removeHeader()
        self.specialTableView.removeFooter()
//        XZAlertView.addXZAlertView(self.view, title: "没有数据了")
        //        self.presentQQQ()
    }
    
    // 进行导航栏
    private lazy var seachBar:UISearchBar = {
        
        let seachBar = UISearchBar()
        seachBar.frame = CGRectMake(5, 0 , 220, 32)
//        seachBar.searchBarStyle = .Prominent
        seachBar.searchBarStyle = .Prominent
        seachBar.barTintColor = UIColor.whiteColor()
//        seachBar.layer.cornerRadius = 10
        seachBar.placeholder = "最新新闻"
        return seachBar
        
    }()
  
    func BacA(){
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    func createSearchViuew(){
        self.specialTableView = UITableView(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 64))
        specialTableView.delegate = self
        specialTableView.dataSource = self
        
        let saeaacell = UINib(nibName: "SpecialSearchTableViewCell", bundle: nil)
        specialTableView.registerNib(saeaacell, forCellReuseIdentifier: specilSrarchID)
        
        specialTableView.separatorStyle = .None
        self.view.addSubview(specialTableView)
        
    }
    
    func SpecilAc(){
        print(seachBar.text)
        SpecialSearchHelper.moneysharedHelper().delegate = self

        if (seachBar.text == ""){
            
            SpecialSearchHelper.moneysharedHelper().dataArray.removeAllObjects()
            self.specialTableView.reloadData()
            XZAlertView.addXZAlertView(self.view, title: "没有数据")
            
        }else{
            
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
                //            self.searchtableView.
                self.specialTableView.reloadData()
                
            }else{
                weak var weakSelf = self
                self.specialTableView.addHeaderWithCallback {  () -> Void in
                                    specialSpecialDown = true
                    
                    SpecialSearchHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/search?kwords=\(self.encodeEscapesURL(self.seachBar.text!))&page=1&token=8c2f64f08271fc4e43")
                }
                
                self.specialTableView.addFooterWithCallback { () -> Void in
                                    specialSpecialDown = false
                    
                    weakSelf!.page += 1
                    SpecialSearchHelper.moneysharedHelper().loadDataAndShowWithUrlStr(URLString: "http://appv2.yngw518.com/api.php/search?kwords=\(self.encodeEscapesURL(self.seachBar.text!))&page=\((weakSelf?.page)!)&token=8c2f64f08271fc4e43")
                    
                }
                self.specialTableView.headerBeginRefreshing()
            }
            
        }

    }
    
    
    func SpecialSearchSearchReloadData() {
        
        dispatch_async(dispatch_get_main_queue()) {  () -> Void in
            if specialSpecialDown == true {
                // 如果是下拉, 就停止头部刷新
                self.specialTableView.headerEndRefreshing()
            } else {
                // 如果是上提, 就停止尾部刷新
                self.specialTableView.footerEndRefreshing()
            }
            self.specialTableView!.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.hidesBottomBarWhenPushed = true
        self.specialTableView.deselectRowAtIndexPath(indexPath, animated: true)
        let seePecial = SpecialWebView()
        
        specialMMM = SpecialSearchHelper.moneysharedHelper().dataArray[indexPath.row] as! SpecialSearchModel
        
        seePecial.detailUrl = specialMMM.detailUrl
        
        self.navigationController?.pushViewController(seePecial, animated: true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SpecialSearchHelper.moneysharedHelper().dataArray.count
    }

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.specialTableView.dequeueReusableCellWithIdentifier(specilSrarchID, forIndexPath: indexPath) as! SpecialSearchTableViewCell
        
        let spppmodel = SpecialSearchHelper.moneysharedHelper().dataArray[indexPath.row] as! SpecialSearchModel
        
        cell.configureCellWithModel(spppmodel)
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
