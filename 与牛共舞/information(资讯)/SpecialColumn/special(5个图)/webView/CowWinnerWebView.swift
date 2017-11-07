

//
//  CowWinnerWebView.swift
//  与牛共舞
//
//  Created by dm on 16/11/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class CowWinnerWebView: UIViewController {

    var moneyLSWeb  : UIWebView?
    var headerView : UIView!
    var detailUrl = NSString()
    var  Backbutton : UIButton!
    var laturl = "/index/recom?token=8c2f64f08271fc4e43"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(red: 235 / 255.0, green: 235 / 255.0, blue: 242 / 255.0, alpha: 1.0)
        
        headerView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, 64))
        headerView.backgroundColor = UIColor.init(red: 255 / 255.0, green: 70 / 255.0, blue: 48 / 255.0, alpha: 1.0)
        self.view.addSubview(headerView)
        
        let HEadLabel = UILabel(frame: CGRectMake(self.headerView.bounds.width / 2 - 40, 28, 100, 30))
        HEadLabel.text = "咨询正文"
        HEadLabel.font = UIFont.boldSystemFontOfSize(20)
        HEadLabel.textColor = UIColor.whiteColor()
        HEadLabel.backgroundColor = UIColor.init(red: 255 / 255.0, green: 70 / 255.0, blue: 48 / 255.0, alpha: 1.0)
        headerView.addSubview(HEadLabel)
        
        let SearchBuuton = UIButton(frame: CGRectMake(self.headerView.bounds.width - 40, 28, 30, 25))
        SearchBuuton.backgroundColor = UIColor.whiteColor()
        SearchBuuton.setImage(UIImage(named: "search.png"), forState: UIControlState.Normal)
        SearchBuuton.adjustsImageWhenHighlighted = false
        SearchBuuton.addTarget(self, action: #selector(MoneyLSWebViewView.SearchAction), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(SearchBuuton)
        
        self.moneyLSWeb = UIWebView()
        moneyLSWeb?.frame = CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height - 44)
        moneyLSWeb?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(moneyLSWeb!)
        
        Backbutton = UIButton(frame: CGRectMake(0, 28, 30, 30))
        Backbutton.backgroundColor = UIColor.whiteColor()
        Backbutton.adjustsImageWhenHighlighted = false
        Backbutton.setImage(UIImage(named: "返回.jpg"), forState: UIControlState.Normal)
        Backbutton.addTarget(self, action: #selector(MoneyLSWebViewView.BackAction), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(Backbutton)
        
        loadConfigure()
        // Do any additional setup after loading the view.
    }
    
    func SearchAction(){
        
        let sppp = SpecialSearchViewController()
        self.navigationController?.pushViewController(sppp, animated: true)
        
    }
    
    func BackAction(){
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    
    func loadConfigure(){
        
        let url = detailUrl as String + laturl
        let ZZurl = NSURL(string: url)
        let urlRequst = NSURLRequest(URL: ZZurl!)
        moneyLSWeb?.loadRequest(urlRequst)
        
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
