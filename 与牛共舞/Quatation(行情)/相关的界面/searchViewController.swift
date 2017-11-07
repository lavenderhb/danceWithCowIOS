//
//  searchViewController.swift
//  YuNiuGongWu
//
//  Created by 章如强 on 16/5/10.
//  Copyright © 2016年 章如强. All rights reserved.
//

import Foundation
import UIKit
import SwiftHTTP

class searchViewController:UIViewController,UISearchBarDelegate,
UITableViewDataSource,UITableViewDelegate{
    
    
    //颜色
    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
    var bule1=UIColor(red: 19/255, green: 20/255, blue: 29/255, alpha: 1)
    var gray1=UIColor(red: 26/255, green: 25/255, blue: 32/255, alpha: 1)
    //背景模块
    var bkview = UIView()
    
    var page1 = UIView()
    
    var biaoti = UILabel()
    
    
    let buttonback:UIButton = UIButton(type:.System)
    let searchBar: UISearchBar = UISearchBar()
    var tableview: UITableView = UITableView(frame:CGRectMake(0,106,(UIScreen.mainScreen().bounds.width),(UIScreen.mainScreen().bounds.height - 106)),style:.Plain)
    
    
    
    
    
    
    
    var datas:[GupiaoBean]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bule1
        self.tableview.backgroundColor = bule1
        page1.backgroundColor = red1
        page1.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.width , 70)
        self.view.addSubview(page1)
        self.view.sendSubviewToBack(page1)
        
        biaoti.frame = CGRectMake(0, 35, UIScreen.mainScreen().bounds.width, 30)
        biaoti.text = "搜索"
        biaoti.textColor = UIColor.whiteColor()
        biaoti.font = UIFont.systemFontOfSize(16)
        biaoti.textAlignment=NSTextAlignment.Center
        self.view.addSubview(biaoti)
        
        buttonback.frame = CGRectMake(8, 28, 40, 40)
        buttonback.setBackgroundImage(UIImage(named: "backs100"), forState: UIControlState.Normal)
        buttonback.addTarget(self, action: #selector(BackClick(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonback)
        
        
        searchBar.frame = CGRectMake(0, 70, UIScreen.mainScreen().bounds.width, 36)
        searchBar.backgroundColor = red1
        searchBar.tintColor = bule1
        searchBar.barTintColor = bule1
        searchBar.placeholder = "请输入股票代码／简拼"
        searchBar.keyboardType = UIKeyboardType.NumbersAndPunctuation
        
        self.view.addSubview(searchBar)
        
        self.searchBar.delegate = self
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        
        self.tableview.registerNib(UINib(nibName:"searchCell", bundle:nil),
                                   forCellReuseIdentifier:"search")
        
        self.view.addSubview(tableview)
        
        bkview.frame = CGRectMake(0,106,UIScreen.mainScreen().bounds.width,UIScreen.mainScreen().bounds.height - 106)
        bkview.backgroundColor = black1
        self.view.addSubview(bkview)
        
    }
    
    func getSearchData(keyword:String) {
        do{
            let word=keyword.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            let opt = try HTTP.GET(GloStr.searchURL+"&word="+word!)
            opt.start{ result in
                if let error = result.error{
                    print(error)
                    
                }
                else{
                    
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.datas=GloMethod.fromJsonToSearch(result.text!)
                        self.tableview.reloadData()
                    })
                    
                }
            }
            
        }catch let error {
            print("请求失败: \(error)")
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func BackClick(button:UIButton)  {
        //        self.dismissViewControllerAnimated(true , completion: nil)
        self.view.addSubview(bkview)
        if c1.isDoc1{
            c1.isDo=true
            c2.isDo=true
            c1.isDoc1=false
            self.dismissViewControllerAnimated(false, completion:nil)
        }else if c2.isDoc2{
            c1.isDo=true
            c2.isDo=true
            c2.isDoc2=false
            self.dismissViewControllerAnimated(false, completion:nil)
        }else if g1.isDog1{
            g1.isDo=true
            g2.isDo=true
            g1.isDog1=false
            self.dismissViewControllerAnimated(false, completion:nil)
        }else if g2.isDog2{
            g1.isDo=true
            g2.isDo=true
            g2.isDog2=false
            self.dismissViewControllerAnimated(false, completion:nil)
        }else{
            self.dismissViewControllerAnimated(false, completion:nil)
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        
        
        let cell:searchCell = tableView.dequeueReusableCellWithIdentifier("search")
            as! searchCell
        if self.datas.count==0{
            return cell
        }
        cell.name.text = self.datas[indexPath.row].name
        cell.symbol.text = self.datas[indexPath.row].symbol
        cell.code.text = self.datas[indexPath.row].code
        if GloMethod.isAdd(cell.code.text!) {
            cell.jumpBtn.setBackgroundImage(UIImage(named: "newsub"), forState: UIControlState.Normal)
        }
        else {
            cell.jumpBtn.setBackgroundImage(UIImage(named: "newadd"), forState: UIControlState.Normal)
        }
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        (AppDelegate.delegate as! AppDelegate).searchcode = [self.datas[indexPath.row].name!,self.datas[indexPath.row].symbol!,self.datas[indexPath.row].code!]
        
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
        self.presentViewController(anotherView, animated: false, completion: nil)
        
    }
    
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.bkview.removeFromSuperview()
        if searchText == "" {
            
        }
        else {
            
            
            
            
            //            getSearchData(searchText)
        }
        // 刷新Table View显示
        getSearchData(searchText)
        
        
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
