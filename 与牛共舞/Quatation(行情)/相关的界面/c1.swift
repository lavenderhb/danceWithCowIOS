//
//  c1.swift
//  dancewithcow
//
//  Created by 章如强 on 16/5/10.
//  Copyright © 2016年 章如强. All rights reserved.
//

import UIKit
import SwiftHTTP

class c1: UIViewController , UITableViewDelegate, UITableViewDataSource{
    // 这个时间的限制
    var timer:NSTimer!
    static var isDo:Bool=false
    static var isDoc1:Bool=false
    static var listdo:Bool=false
    var ListcontractionisDo0:Bool=false
    var ListcontractionisDo1:Bool=false
    var ListcontractionisDo2:Bool=false
    var ListcontractionisDo3:Bool=false

    
    
    
    var searchvc = searchViewController()
    
    let buttonback:UIButton = UIButton(type:.System)
    let buttonsearch:UIButton = UIButton(type:.System)
    
    let buttoninto1:UIButton = UIButton(type:.System)
    let buttoninto2:UIButton = UIButton(type:.System)
    let buttoninto3:UIButton = UIButton(type:.System)
    
    
    //颜色
    var nocolor=UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 0)
    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
    var bule1=UIColor(red: 19/255, green: 20/255, blue: 29/255, alpha: 1)
    var gray1=UIColor(red: 26/255, green: 25/255, blue: 32/255, alpha: 1)
    //背景模块
    var page1 = UIView()
    var page2 = UIView()
    var page3 = UIView()
    var line1 = UIView()
    var line2 = UIView()

    var namelabel = UILabel()
    var pricelabel = UILabel()
    var percentlabel = UILabel()
    
    var index1 = UILabel()
    var index2 = UILabel()
    var index3 = UILabel()
    
    var price1 = UILabel()
    var upd1 = UILabel()
    var updp1 = UILabel()
    var upline1 = UILabel()
    
    
    var price2 = UILabel()
    var upd2 = UILabel()
    var updp2 = UILabel()
    var upline2 = UILabel()
    
    var price3 = UILabel()
    var upd3 = UILabel()
    var updp3 = UILabel()
    var upline3 = UILabel()
    

    
    var tableView:UITableView?
    
    var bdbeanAll:Dictionary<Int, [BDBean]>?
    var bdbeans:Dictionary<Int, [BDBean]>?
    
    var Headers:[String]?
    
    //    let urls=[GloStr.ZFUrl,GloStr.DFUrl,GloStr.HSLUrl,GloStr.ZFBUrl]
    
    
    
    override func loadView() {
        super.loadView()
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        c1.isDo=true
        
        self.view.backgroundColor = bule1
        setButton()
        setTableList()
        getData()
        getDetail1()
        getDetail2()
        getDetail3()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2,target:self,selector:#selector(c1.tickDown),userInfo:nil,repeats:true)

    }
    
    func setButton(){
        //设置按钮
        buttonback.frame=CGRectMake(8, 28, 40, 40)
        buttonback.setBackgroundImage(UIImage(named:"backs100"),forState:.Normal)
//        self.view.addSubview(buttonback);
        buttonback.addTarget(self,action:#selector(tapped),forControlEvents:.TouchUpInside)
        
        buttonsearch.frame=CGRectMake(UIScreen.mainScreen().bounds.width - 50, 28, 40, 40)
        buttonsearch.setBackgroundImage(UIImage(named:"searchs100"),forState:.Normal)
        self.view.addSubview(buttonsearch);
        buttonsearch.addTarget(self,action:#selector(searchbt),forControlEvents:.TouchUpInside)
        
        
        //横条设置
        page1.backgroundColor = red1
        page1.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.width , 70)
        self.view.addSubview(page1)
        self.view.sendSubviewToBack(page1)
        
        page2.backgroundColor = black1
        page2.frame = CGRectMake(0,70, UIScreen.mainScreen().bounds.width , 90)
        self.view.addSubview(page2)
        
        page3.backgroundColor = bule1
        page3.frame = CGRectMake(0,160, UIScreen.mainScreen().bounds.width , 30)
        self.view.addSubview(page3)
        
        line1.backgroundColor = gray1
        line1.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3,95, 1 , 40)
        self.view.addSubview(line1)
        line2.backgroundColor = gray1
        line2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3,95, 1 , 40)
        self.view.addSubview(line2)
        
        index1.frame = CGRectMake(0, 75, UIScreen.mainScreen().bounds.width/3, 30)
        index1.text = "上证指数"
        index1.textColor = UIColor.whiteColor()
        index1.font = UIFont(name:"Zapfino", size:13)
        index1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(index1)
        
        index2.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, 75, UIScreen.mainScreen().bounds.width/3, 30)
        index2.text = "深圳成指"
        index2.textColor = UIColor.whiteColor()
        index2.font = UIFont(name:"Zapfino", size:13)
        index2.textAlignment=NSTextAlignment.Center
        self.view.addSubview(index2)
        
        index3.frame = CGRectMake(UIScreen.mainScreen().bounds.width/1.5, 75, UIScreen.mainScreen().bounds.width/3, 30)
        index3.text = "创业板指"
        index3.textColor = UIColor.whiteColor()
        index3.font = UIFont.systemFontOfSize(13)
        index3.textAlignment=NSTextAlignment.Center
        self.view.addSubview(index3)
        
        price1.frame = CGRectMake(0, 100, UIScreen.mainScreen().bounds.width/3, 30)
        price1.text = "－－"
        price1.textColor = UIColor.whiteColor()
        price1.font = UIFont.systemFontOfSize(13)
        price1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(price1)
        
        price2.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, 100, UIScreen.mainScreen().bounds.width/3, 30)
        price2.text = "－－"
        price2.textColor = UIColor.whiteColor()
        price2.font = UIFont.systemFontOfSize(13)
        price2.textAlignment=NSTextAlignment.Center
        self.view.addSubview(price2)
        
        price3.frame = CGRectMake(UIScreen.mainScreen().bounds.width/1.5, 100, UIScreen.mainScreen().bounds.width/3, 30)
        price3.text = "－－"
        price3.textColor = UIColor.whiteColor()
        price3.font = UIFont.systemFontOfSize(13)
        price3.textAlignment=NSTextAlignment.Center
        self.view.addSubview(price3)
        
        upd1.frame = CGRectMake(0, 125, UIScreen.mainScreen().bounds.width/6 - 5, 30)
        upd1.text = "－"
        upd1.textColor = UIColor.whiteColor()
        upd1.font = UIFont.systemFontOfSize(13)
        upd1.textAlignment=NSTextAlignment.Right
        self.view.addSubview(upd1)
        
        upd2.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, 125, UIScreen.mainScreen().bounds.width/6 - 5, 30)
        upd2.text = "－"
        upd2.textColor = UIColor.whiteColor()
        upd2.font = UIFont.systemFontOfSize(13)
        upd2.textAlignment=NSTextAlignment.Right
        self.view.addSubview(upd2)
        
        upd3.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/6, 125, UIScreen.mainScreen().bounds.width/6 - 5, 30)
        upd3.text = "－"
        upd3.textColor = UIColor.whiteColor()
        upd3.font = UIFont.systemFontOfSize(13)
        upd3.textAlignment=NSTextAlignment.Right
        self.view.addSubview(upd3)
        
        updp1.frame = CGRectMake(UIScreen.mainScreen().bounds.width/6 + 5, 125, UIScreen.mainScreen().bounds.width/6 - 5, 30)
        updp1.text = "－%"
        updp1.textColor = UIColor.whiteColor()
        updp1.font = UIFont.systemFontOfSize(13)
        updp1.textAlignment=NSTextAlignment.Left
        self.view.addSubview(updp1)
        
        updp2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*3/6 + 5, 125, UIScreen.mainScreen().bounds.width/6 - 5, 30)
        updp2.text = "－%"
        updp2.textColor = UIColor.whiteColor()
        updp2.font = UIFont.systemFontOfSize(13)
        updp2.textAlignment=NSTextAlignment.Left
        self.view.addSubview(updp2)
        
        updp3.frame = CGRectMake(UIScreen.mainScreen().bounds.width*5/6 + 5, 125, UIScreen.mainScreen().bounds.width/6 - 5, 30)
        updp3.text = "－%"
        updp3.textColor = UIColor.whiteColor()
        updp3.font = UIFont.systemFontOfSize(13)
        updp3.textAlignment=NSTextAlignment.Left
        self.view.addSubview(updp3)
        
        upline1.frame = CGRectMake(0, 125, UIScreen.mainScreen().bounds.width/3, 30)
        upline1.text = "｜"
        upline1.textColor = UIColor.darkGrayColor()
        upline1.font = UIFont.systemFontOfSize(13)
        upline1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(upline1)
        
        upline2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/6, 125, UIScreen.mainScreen().bounds.width/3, 30)
        upline2.text = "｜"
        upline2.textColor = UIColor.darkGrayColor()
        upline2.font = UIFont.systemFontOfSize(13)
        upline2.textAlignment=NSTextAlignment.Center
        self.view.addSubview(upline2)
        
        upline3.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/6, 125, UIScreen.mainScreen().bounds.width/3, 30)
        upline3.text = "｜"
        upline3.textColor = UIColor.darkGrayColor()
        upline3.font = UIFont.systemFontOfSize(13)
        upline3.textAlignment=NSTextAlignment.Center
        self.view.addSubview(upline3)
        
        namelabel.frame = CGRectMake(0, 160, UIScreen.mainScreen().bounds.width/4, 30)
        namelabel.text = "名称"
        namelabel.textColor = UIColor.whiteColor()
        namelabel.font = UIFont.systemFontOfSize(12)
        namelabel.textAlignment=NSTextAlignment.Center
        self.view.addSubview(namelabel)
        
        pricelabel.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, 160, UIScreen.mainScreen().bounds.width/4, 30)
        pricelabel.text = "最新价格"
        pricelabel.textColor = UIColor.whiteColor()
        pricelabel.font = UIFont.systemFontOfSize(12)
        pricelabel.textAlignment=NSTextAlignment.Center
        self.view.addSubview(pricelabel)
        
        percentlabel.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 - 10, 160, UIScreen.mainScreen().bounds.width/4, 30)
        percentlabel.text = "榜单百分比"
        percentlabel.textColor = UIColor.whiteColor()
        percentlabel.font = UIFont.systemFontOfSize(12)
        percentlabel.textAlignment=NSTextAlignment.Center
        self.view.addSubview(percentlabel)
        
        
        
        buttoninto1.frame=CGRectMake(0, 70, UIScreen.mainScreen().bounds.width/3, 90)
        self.view.addSubview(buttoninto1);
        buttoninto1.addTarget(self,action:#selector(buttoninto1fun),forControlEvents:.TouchUpInside)
        
        buttoninto2.frame=CGRectMake(UIScreen.mainScreen().bounds.width/3, 70, UIScreen.mainScreen().bounds.width/3, 90)
        self.view.addSubview(buttoninto2);
        buttoninto2.addTarget(self,action:#selector(buttoninto2fun),forControlEvents:.TouchUpInside)
        
        buttoninto3.frame=CGRectMake(UIScreen.mainScreen().bounds.width*2/3, 70, UIScreen.mainScreen().bounds.width/3, 90)
        self.view.addSubview(buttoninto3);
        buttoninto3.addTarget(self,action:#selector(buttoninto3fun),forControlEvents:.TouchUpInside)
        
    }
    
    func setTableList(){
        
        self.bdbeanAll =  [
            0:[BDBean]([]),
            1:[BDBean]([]),
            2:[BDBean]([]),
            3:[BDBean]([]),
            
        ];
        self.bdbeans =  [
            0:[BDBean]([]),
            1:[BDBean]([]),
            2:[BDBean]([]),
            3:[BDBean]([]),
            
        ];
        
        
        
        self.Headers = [
            "涨幅榜",
            "跌幅榜",
            "换手率榜",
            "振幅榜"
        ]
        
        self.tableView = UITableView(frame:CGRectMake(0,190,(UIScreen.mainScreen().bounds.width),(UIScreen.mainScreen().bounds.height - 240)), style:UITableViewStyle.Grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.backgroundColor = bule1
        self.tableView!.registerNib(UINib(nibName:"BDTableCell", bundle:nil),
                                    forCellReuseIdentifier:"bdcell")
        self.view.addSubview(self.tableView!)
        
    }
    
    
    
    
    
    func getData(){
        
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        
        do {
            let opt0 = try HTTP.New(GloStr.ZFUrl, method: .GET)
            opt0.onFinish = { response in
                let jsons=GloMethod.formJsonToBD(response.text!)
                
                self.bdbeanAll![0]=[]
                self.bdbeans![0]=[]
                for i in 0...jsons.count-1{
                    let array:[String]=jsons[i].string!.componentsSeparatedByString(",")
                    let bdBean:BDBean=BDBean()
                    
                    bdBean.name=array[2]
                    bdBean.symbol=array[1]
                    bdBean.closeprice=array[3]
                    
                    bdBean.code = GloMethod.changeDFCFWTo126(array[0], symbol: bdBean.symbol!)
                    bdBean.price = array[5]
                    bdBean.percent = array[11]

                    if self.ListcontractionisDo0 == false{
                    self.bdbeanAll![0]?.append(bdBean)
                    }else{
                        
                    }
                    self.bdbeans![0]?.append(bdBean)

                    
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView?.reloadData()
                    
                })
                
            }
            
            let opt1 = try HTTP.New(GloStr.DFUrl, method: .GET)
            opt1.onFinish = { response in
                let jsons=GloMethod.formJsonToBD(response.text!)
                self.bdbeanAll![1]=[]
                self.bdbeans![1]=[]
                for i in 0...jsons.count-1{
                    let array:[String]=jsons[i].string!.componentsSeparatedByString(",")
                    let bdBean:BDBean=BDBean()
                    
                    bdBean.name=array[2]
                    bdBean.symbol=array[1]
                    bdBean.closeprice=array[3]
                    
                    bdBean.code = GloMethod.changeDFCFWTo126(array[0], symbol: bdBean.symbol!)
                    bdBean.price = array[5]
                    bdBean.percent = array[11]
                    if self.ListcontractionisDo1 == false{
                        self.bdbeanAll![1]?.append(bdBean)
                    }else{
                        
                    }
                        self.bdbeans![1]?.append(bdBean)

                    
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView?.reloadData()
                    
                })
                
            }
            
            let opt2 = try HTTP.New(GloStr.HSLUrl, method: .GET)
            opt2.onFinish = { response in
                let jsons=GloMethod.formJsonToBD(response.text!)
                self.bdbeanAll![2]=[]
                self.bdbeans![2]=[]
                for i in 0...jsons.count-1{
                    let array:[String]=jsons[i].string!.componentsSeparatedByString(",")
                    let bdBean:BDBean=BDBean()
                    
                    bdBean.name=array[2]
                    bdBean.symbol=array[1]
                    bdBean.closeprice=array[3]
                    
                    bdBean.code = GloMethod.changeDFCFWTo126(array[0], symbol: bdBean.symbol!)
                    bdBean.price = array[5]
                    bdBean.percent = array[23]
                    if self.ListcontractionisDo2 == false{
                        self.bdbeanAll![2]?.append(bdBean)
                    }else{
                        
                    }
                        self.bdbeans![2]?.append(bdBean)

                    
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView?.reloadData()
                    
                })
                
            }
            
            let opt3 = try HTTP.New(GloStr.ZFBUrl, method: .GET)
            opt3.onFinish = { response in
                let jsons=GloMethod.formJsonToBD(response.text!)
                self.bdbeanAll![3]=[]
                self.bdbeans![3]=[]
                for i in 0...jsons.count-1{
                    let array:[String]=jsons[i].string!.componentsSeparatedByString(",")
                    let bdBean:BDBean=BDBean()
                    
                    bdBean.name=array[2]
                    bdBean.symbol=array[1]
                    bdBean.closeprice=array[3]
                    
                    bdBean.code = GloMethod.changeDFCFWTo126(array[0], symbol: bdBean.symbol!)
                    bdBean.price = array[5]
                    bdBean.percent = array[13]
                    if self.ListcontractionisDo3 == false{
                        self.bdbeanAll![3]?.append(bdBean)
                    }else{
                        
                    }
                         self.bdbeans![3]?.append(bdBean)

                   
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView?.reloadData()
                    
                })
                
            }
            
            
            operationQueue.addOperation(opt0)
            operationQueue.addOperation(opt1)
            operationQueue.addOperation(opt2)
            operationQueue.addOperation(opt3)
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
    //button方法

    func buttoninto1fun(){
        c1.isDo=false
        c1.isDoc1=true
        (AppDelegate.delegate as! AppDelegate).searchcode = ["上证指数","000001","0000001"]
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
        self.presentViewController(anotherView, animated: false, completion: nil)
    }
    
    func buttoninto2fun(){
        c1.isDo=false
        c1.isDoc1=true
        (AppDelegate.delegate as! AppDelegate).searchcode = ["深圳成指","399001","1399001"]
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
        self.presentViewController(anotherView, animated: false, completion: nil)
    }
    
    func buttoninto3fun(){
        c1.isDo=false
        c1.isDoc1=true
        (AppDelegate.delegate as! AppDelegate).searchcode = ["创业板指","399006","1399006"]
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
        self.presentViewController(anotherView, animated: false, completion: nil)
    }
    
    
    func tapped(){
        c1.isDo=false
        self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func searchbt(){
        c1.isDo=false
        c1.isDoc1=true
        self.presentViewController(searchvc, animated: false, completion: nil)
    }

    
    func Listcontraction3(){
        
        if self.bdbeanAll![3]?.count != 0{
        self.bdbeanAll![3]=[]
            Listname3="＞    振幅榜"
            ListcontractionisDo3 = true
            self.tableView?.reloadData()
        }else if self.bdbeanAll![3]?.count == 0{
            self.bdbeanAll![3]=self.bdbeans![3]
            Listname3="∨    振幅榜"
            ListcontractionisDo3 = false
            self.tableView?.reloadData()
        }
        
    }
    func Listcontraction2(){
        
        if self.bdbeanAll![2]?.count != 0{
            self.bdbeanAll![2]=[]
            Listname2="＞    换手率榜"
            ListcontractionisDo2 = true
            self.tableView?.reloadData()
        }else if self.bdbeanAll![2]?.count == 0{
            self.bdbeanAll![2]=self.bdbeans![2]
            Listname2="∨    换手率榜"
            ListcontractionisDo2 = false
            self.tableView?.reloadData()
        }
        
    }
    func Listcontraction1(){
        
//        buttons1.setTitle(aaaaa, forState: .Normal)
        if self.bdbeanAll![1]?.count != 0{
            self.bdbeanAll![1]=[]
            Listname1="＞    跌幅榜"
            ListcontractionisDo1 = true
            self.tableView?.reloadData()
            
        }else if self.bdbeanAll![1]?.count == 0{
            self.bdbeanAll![1]=self.bdbeans![1]
            Listname1="∨    跌幅榜"
            ListcontractionisDo1 = false
            self.tableView?.reloadData()
        }
        
    }
    func Listcontraction0(){
        
        if self.bdbeanAll![0]?.count != 0{
            self.bdbeanAll![0]=[]
            Listname0="＞    涨幅榜"
            ListcontractionisDo0 = true
            self.tableView?.reloadData()
        }else if self.bdbeanAll![0]?.count == 0{
            self.bdbeanAll![0]=self.bdbeans![0]
            Listname0="∨    涨幅榜"
            ListcontractionisDo0 = false
            self.tableView?.reloadData()
        }
        
    }
    


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (bdbeanAll?.count)!;
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.bdbeanAll?[section]
        return data!.count
    }
    
    let buttons0 = UIButton()
    let buttons1 = UIButton()
    let buttons2 = UIButton()
    let buttons3 = UIButton()
    var Listname0="∨    涨幅榜"
    var Listname1="∨    跌幅榜"
    var Listname2="∨    换手率榜"
    var Listname3="∨    振幅榜"
    let bdlistimg = UILabel()
    

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let buttons = UIButton()
        buttons.setTitleColor(UIColor.whiteColor() , forState: UIControlState.Normal)
        buttons.titleLabel!.font = UIFont.systemFontOfSize(15)
        buttons.setTitle("...", forState:UIControlState.Normal)
        
        
        buttons0.setTitleColor(UIColor.whiteColor() , forState: UIControlState.Normal)
        buttons0.titleLabel!.font = UIFont.systemFontOfSize(15)
        buttons0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0 - UIScreen.mainScreen().bounds.width*5/6, bottom: 0, right: 0)
        buttons0.setImage(UIImage(named:"ddd3"),forState:.Normal)
        buttons0.imageEdgeInsets = UIEdgeInsets(top: 0, left:  UIScreen.mainScreen().bounds.width*5/6, bottom: 0, right: 0)
        buttons0.titleLabel!.textAlignment=NSTextAlignment.Left
        
        buttons1.setTitleColor(UIColor.whiteColor() , forState: UIControlState.Normal)
        buttons1.titleLabel!.font = UIFont.systemFontOfSize(15)
        buttons1.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0 - UIScreen.mainScreen().bounds.width*5/6, bottom: 0, right: 0)
        buttons1.setImage(UIImage(named:"ddd3"),forState:.Normal)
        buttons1.imageEdgeInsets = UIEdgeInsets(top: 0, left:  UIScreen.mainScreen().bounds.width*5/6, bottom: 0, right: 0)
        buttons1.titleLabel!.textAlignment=NSTextAlignment.Left
        
        buttons2.setTitleColor(UIColor.whiteColor() , forState: UIControlState.Normal)
        buttons2.titleLabel!.font = UIFont.systemFontOfSize(15)
        buttons2.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15 - UIScreen.mainScreen().bounds.width*5/6, bottom: 0, right: 0)
        buttons2.setImage(UIImage(named:"ddd3"),forState:.Normal)
        buttons2.imageEdgeInsets = UIEdgeInsets(top: 0, left:  UIScreen.mainScreen().bounds.width*5/6, bottom: 0, right: 0)
        buttons2.titleLabel!.textAlignment=NSTextAlignment.Left
        
        buttons3.setTitleColor(UIColor.whiteColor() , forState: UIControlState.Normal)
        buttons3.titleLabel!.font = UIFont.systemFontOfSize(15)
        buttons3.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0 - UIScreen.mainScreen().bounds.width*5/6, bottom: 0, right: 0)
        buttons3.setImage(UIImage(named:"ddd3"),forState:.Normal)
        buttons3.imageEdgeInsets = UIEdgeInsets(top: 0, left:  UIScreen.mainScreen().bounds.width*5/6, bottom: 0, right: 0)
        buttons3.titleLabel!.textAlignment=NSTextAlignment.Left
        

        
        
        
        switch section {
        case 0:
            buttons0.setTitle(Listname0, forState:UIControlState.Normal)
            buttons0.addTarget(self,action:#selector(Listcontraction0),forControlEvents:.TouchUpInside)
            return buttons0
        case 1:
            buttons1.setTitle(Listname1, forState:UIControlState.Normal)
            buttons1.addTarget(self,action:#selector(Listcontraction1),forControlEvents:.TouchUpInside)
            return buttons1
        case 2:
            buttons2.setTitle(Listname2, forState:UIControlState.Normal)
            buttons2.addTarget(self,action:#selector(Listcontraction2),forControlEvents:.TouchUpInside)
            return buttons2
        case 3:
            buttons3.setTitle(Listname3, forState:UIControlState.Normal)
            buttons3.addTarget(self,action:#selector(Listcontraction3),forControlEvents:.TouchUpInside)
            return buttons3
        default: break
        }
        return bdlistimg
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let hengview = UIView()
        hengview.backgroundColor = UIColor.clearColor()
        return hengview
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {

        
        let cell:BDTableCell = tableView.dequeueReusableCellWithIdentifier("bdcell")
            as! BDTableCell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        
        let secno = indexPath.section
        
        let item=bdbeanAll![secno]
        if item?.count == 0 {
            return cell
        }else{
            
            let percentString = item![indexPath.row].percent
            
            if percentString != nil{
                if secno == 2 {
                    cell.price.textColor = UIColor.whiteColor()
                    cell.percent.textColor = UIColor.whiteColor()
                    
                }
                else if secno == 3{
                    cell.price.textColor = UIColor.whiteColor()
                    cell.percent.textColor = UIColor.whiteColor()
                }
                    
                else if (percentString! as NSString).substringToIndex(1) == "-"{
                    cell.price.textColor = UIColor.greenColor()
                    cell.percent.textColor = UIColor.greenColor()
                    
                }else{
                    cell.price.textColor = UIColor.redColor()
                    cell.percent.textColor = UIColor.redColor()
                    
                }
                let bjp1 = item![indexPath.row].price
                let bjp2 = item![indexPath.row].closeprice
                if bjp1 > bjp2{
                    cell.price.textColor = UIColor.redColor()
                }else if bjp2 > bjp1{
                    cell.price.textColor = UIColor.greenColor()
                }

                if secno == 0 {
                    cell.price.textColor = UIColor.redColor()
                    cell.percent.textColor = UIColor.redColor()
                    
                }
                
//                cell.selectedBackgroundView!.backgroundColor = bule1
                cell.name.text=item![indexPath.row].name
                cell.symbol.text=item![indexPath.row].symbol
                cell.code.text=item![indexPath.row].code
                cell.price.text=item![indexPath.row].price
                cell.percent.text=item![indexPath.row].percent
            }
        }
        
        
        
        //        var data = self.allnames?[secno]
        //        cell.textLabel?.text = data![indexPath.row]
        
        return cell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        c1.isDo=false
        c1.isDoc1=true
        (AppDelegate.delegate as! AppDelegate).searchcode = [self.bdbeanAll![indexPath.section]![indexPath.row].name!,self.bdbeanAll![indexPath.section]![indexPath.row].symbol!,self.bdbeanAll![indexPath.section]![indexPath.row].code!]
        
        var listGP:[ListBean]=[]
        for gp in self.bdbeanAll![indexPath.section]! {
            let list=ListBean()
            list.name=gp.name
            list.symbol=gp.symbol
            list.code=gp.code
            c1.listdo = true
            listGP.append(list)
        }
        (AppDelegate.delegate as! AppDelegate).listGP = listGP
        
        getData()
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
        self.presentViewController(anotherView, animated: false, completion: nil)
        

        
    }
    
    


    
    var gupiaonew1:GPBean=GPBean()
    /*
     获取股票详情
     **/
    func getDetail1(){
        
        do{
            
            let opt = try HTTP.GET(GloStr.gpURL2+"0000011")
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    //                    print(result.text)
                    self.gupiaonew1=GloMethod.fromJsonToDetail(result.text!)
                    if !self.gupiaonew1.statu!{
                        return
                    }
                    self.price1.text=self.gupiaonew1._25price
                    self.upd1.text=self.gupiaonew1._27updown!
                    self.updp1.text=self.gupiaonew1._29updownpercent! + "%"
                    
                    let yest1 = Double(self.gupiaonew1._34yestclose!)
                    let now1 = Double(self.gupiaonew1._25price!)//

                    
                    if now1 < yest1{
                        self.price1.textColor = UIColor.greenColor()
                        self.upd1.textColor = UIColor.greenColor()
                        self.updp1.textColor = UIColor.greenColor()
                        self.upd1.text=self.gupiaonew1._27updown!
                        self.updp1.text=self.gupiaonew1._29updownpercent! + "%"

                        
                    }
                    else{
                        self.price1.textColor = UIColor.redColor()
                        self.upd1.textColor = UIColor.redColor()
                        self.updp1.textColor = UIColor.redColor()
                        self.upd1.text="+"+self.gupiaonew1._27updown!
                        self.updp1.text="+"+self.gupiaonew1._29updownpercent! + "%"
                        
                    }
                    
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.price1.setNeedsDisplay()
                        self.upd1.setNeedsDisplay()
                        self.updp1.setNeedsDisplay()

                        //self.yestClose.setNeedsDisplay()
                        
                        
                    })
                }
            }
            
        }catch let error {
            print("请求失败: \(error)")
            
        }
        
        
    }
    
    var gupiaonew3:GPBean=GPBean()
    /*
     获取股票详情
     **/
    func getDetail3(){
        
        do{
            
            let opt = try HTTP.GET(GloStr.gpURL2+"3990062")
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    //                    print(result.text)
                    self.gupiaonew3=GloMethod.fromJsonToDetail(result.text!)
                    if !self.gupiaonew3.statu!{
                        return
                    }
                    self.price3.text=self.gupiaonew3._25price

                    self.upd3.text=self.gupiaonew3._27updown!
                    self.updp3.text=self.gupiaonew3._29updownpercent! + "%"
                    
                    let yest3 = Double(self.gupiaonew3._34yestclose!)
                    let now3 = Double(self.gupiaonew3._25price!)//
                    
                    
                    if now3 < yest3{
                        self.price3.textColor = UIColor.greenColor()
                        self.upd3.textColor = UIColor.greenColor()
                        self.updp3.textColor = UIColor.greenColor()
                        self.upd3.text=self.gupiaonew3._27updown!
                        self.updp3.text=self.gupiaonew3._29updownpercent! + "%"
                        
                        
                    }
                    else{
                        self.price3.textColor = UIColor.redColor()
                        self.upd3.textColor = UIColor.redColor()
                        self.updp3.textColor = UIColor.redColor()
                        self.upd3.text="+"+self.gupiaonew3._27updown!
                        self.updp3.text="+"+self.gupiaonew3._29updownpercent! + "%"
                        
                    }
                    
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.price3.setNeedsDisplay()
                        self.upd3.setNeedsDisplay()
                        self.updp3.setNeedsDisplay()
                        
                        //self.yestClose.setNeedsDisplay()
                        
                        
                    })
                }
            }
            
        }catch let error {
            print("请求失败: \(error)")
            
        }
        
        
    }
    
    var gupiaonew2:GPBean=GPBean()
    /*
     获取股票详情
     **/
    func getDetail2(){
        
        do{
            
            let opt = try HTTP.GET(GloStr.gpURL2+"3990012")
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    //                    print(result.text)
                    self.gupiaonew2=GloMethod.fromJsonToDetail(result.text!)
                    if !self.gupiaonew2.statu!{
                        return
                    }
                    self.price2.text=self.gupiaonew2._25price
                    self.upd2.text=self.gupiaonew2._27updown!
                    self.updp2.text=self.gupiaonew2._29updownpercent! + "%"
                    
                    let yest2 = Double(self.gupiaonew2._34yestclose!)
                    let now2 = Double(self.gupiaonew2._25price!)//
                    
                    
                    if now2 < yest2{
                        self.price2.textColor = UIColor.greenColor()
                        self.upd2.textColor = UIColor.greenColor()
                        self.updp2.textColor = UIColor.greenColor()
                        self.upd2.text=self.gupiaonew2._27updown!
                        self.updp2.text=self.gupiaonew2._29updownpercent! + "%"
                        
                        
                    }
                    else{
                        self.price2.textColor = UIColor.redColor()
                        self.upd2.textColor = UIColor.redColor()
                        self.updp2.textColor = UIColor.redColor()
                        self.upd2.text="+"+self.gupiaonew2._27updown!
                        self.updp2.text="+"+self.gupiaonew2._29updownpercent! + "%"
                        
                    }
                    
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.price2.setNeedsDisplay()
                        self.upd2.setNeedsDisplay()
                        self.updp2.setNeedsDisplay()
                        
                        //self.yestClose.setNeedsDisplay()
                        
                        
                    })
                }
            }
            
        }catch let error {
            print("请求失败: \(error)")
            
        }
        
        
    }
    

    func tickDown()
    {
        if c1.isDo {
            getData()
            getDetail1()
            getDetail2()
            getDetail3()        
        }
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
