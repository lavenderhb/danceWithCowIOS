//
//  screenViewController.swift
//  hqnew
//
//  Created by 章如强 on 16/11/21.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit
import SwiftHTTP

class screenViewController: UIViewController,ChangeLine,ChangeTop,Chage {
    //timeline
    func chage() {
        searchss()
    }
    
    func change(page: Int) {
        changeKViewLine(page)
    }
    func changeTopData(top: Double, low: Double, cjl: Double, Open: Double, close: Double) {
        self.price.text=String(close)
        self.todayOpen.text=String(Open)
        self.high.text=String(top)
        self.low.text=String(low)
    }
    
    
    static var SVCtimer:NSTimer!
    static var SVCtimeraddsub:NSTimer!
    static var isDo:Bool=true
    static var kviewisno:Bool=false
    //横屏左右切换后g2页面刷新
    static var scviewlrdo:Bool=false
    static var scviewlrdo2:Bool=false//确定退出刷新
    
    var searchvc = searchViewController()
    
    
    //添加删除自选
    let buttonaddsub:UIButton = UIButton(type:.System)
    let buttonaddsubpic:UIButton = UIButton(type:.System)
    

    var list:[ListBean]=[]
    let buttonleftgo:UIButton = UIButton(type:.System)
    let buttonrightgo:UIButton = UIButton(type:.System)
    static var g2code:String!
    static var g2codego:Bool=false
    
    let buttonback:UIButton = UIButton(type:.System)

    
    //指标切换按钮
    let buttonmacd:UIButton = UIButton(type:.System)

    //指标切换界面
    var buttonview = btview()
    var buttonviewisDo:Bool=false
    
    //seg设置
    let items:[String] = ["分时","日","周","月"]
    var segmented = UISegmentedControl()

    

    //走势图
    var rik:KBean?
    var riView = KlineView()
    var rivdo:Bool=true
    
    var zhouk:KBean?
    var zhouView = KlineView()
    var zhouvdo:Bool=true
    
    var yuek:KBean?
    var yueView = KlineView()
    var yuevdo:Bool=true
    
    
    
    var fenshi:FenshiBean?
    var timeView = TimeLine()
    var timeviewdo:Bool=true
    
    var isShow:Bool!

    
    var KlineSetvc = KlineSetViewController()//k线设置页面
    let buttonzhibiao:UIButton = UIButton(type:.System)
    
    //颜色
    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
    var red2=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 0.5)
    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
    var bule1=UIColor(red: 19/255, green: 20/255, blue: 29/255, alpha: 1)
    
    var gray1=UIColor(red: 26/255, green: 25/255, blue: 32/255, alpha: 1)
    var greed2=UIColor(red: 17/255, green: 124/255, blue: 3/255, alpha: 1)
    var color10=UIColor(red: 232/255, green: 203/255, blue: 50/255, alpha: 1)
    var color20=UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
    
    //背景模块
    var page1 = UIView()
    var page2 = UIView()
    var page3 = UIView()

    
    
    //文字
    var gpAndSymbol = UILabel()
    var gpname = UILabel()
    var gpsymbol = UILabel()
    var price = UILabel()
    var upDownMoney = UILabel()
    var upDownPer = UILabel()

    var hightext = UILabel()
    var high = UILabel()
    var lowtext = UILabel()
    var low = UILabel()

    var todayOpentext = UILabel()
    var todayOpen = UILabel()
    var changeHandPertext = UILabel()
    var changeHandPer = UILabel()

    var dealNumtext = UILabel()
    var dealNum = UILabel()
    var dealMoneytext = UILabel()
    var dealMoney = UILabel()
    //成交量成交额
    static var cjlview = screenViewdealnumview()
    
    //买卖档
    var bspr = UILabel()
    var fiveline = UIView()
    var fiveline2 = UIView()
    var buySellTextSize=CGFloat(10)
    var buy1 = UILabel()
    var buy2 = UILabel()
    var buy3 = UILabel()
    var buy4 = UILabel()
    var buy5 = UILabel()
    var sell1 = UILabel()
    var sell2 = UILabel()
    var sell3 = UILabel()
    var sell4 = UILabel()
    var sell5 = UILabel()
    
    var sell5price = UILabel()
    var sell4price = UILabel()
    var sell3price = UILabel()
    var sell2price = UILabel()
    var sell1price = UILabel()
    var sell5num = UILabel()
    var sell4num = UILabel()
    var sell3num = UILabel()
    var sell2num = UILabel()
    var sell1num = UILabel()
    
    var buy1price = UILabel()
    var buy2price = UILabel()
    var buy3price = UILabel()
    var buy4price = UILabel()
    var buy5price = UILabel()
    var buy1num = UILabel()
    var buy2num = UILabel()
    var buy3num = UILabel()
    var buy4num = UILabel()
    var buy5num = UILabel()

    
    //＊＊＊页面股票代码
    var searchCode:[String]?
    
    var gupiaonew:GPBean=GPBean()
    
    var name:String?
    var symbol:String?
    var code:String?
    

    func setViewProtrol(){
        riView.setChangeTop(self)
        zhouView.setChangeTop(self)
        yueView.setChangeTop(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeLeft.rawValue, forKey: "orientation")
        
        
        buttonview.setChange(self)
//        setViewProtrol()
        getCode()
        screenViewController.isDo=true
        
        self.view.backgroundColor = bule1
        
        
        self.riView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)//(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        self.zhouView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
        self.yueView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
        riView.buttonopen.hidden = true
        zhouView.buttonopen.hidden = true
        yueView.buttonopen.hidden = true
//        buttonrightgo.hidden = true
//        buttonleftgo.hidden = true
        

        
        //timeline
        if code == "0000001" {
            timeView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
        }
        else if code == "1399006" {
            timeView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
        }
        else if code == "1399001" {
            timeView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
        }
            
        else {
            timeView.frame = CGRectMake(5,50, (UIScreen.mainScreen().bounds.width - 10)*4/5, UIScreen.mainScreen().bounds.height-90)
        }
        
        
        
        
    
        getFenshiData()
        timeView.hidden = true
        
        
        if code == "0000001" {
            isShow=false
        }
        else if code == "1399006" {
            isShow=false
        }
        else if code == "1399001" {
            isShow=false
        }
            
        else {
            isShow=true
        }
        timeView.setChange(self,show: self.isShow)
        
        
    
    
        setButton()
        setHengtiao()
        setGP()
        
        
        gpAndSymbol.text = name!+"("+symbol!+")"
        gpname.text = name
        gpsymbol.text = symbol
        
        
        buttonmacd.hidden = true
        riView.hidden = false
        zhouView.hidden = true
        yueView.hidden = true
        
        getDetail()
        getRiKData()


        screenViewController.SVCtimer = NSTimer.scheduledTimerWithTimeInterval(2,target:self,selector:#selector(screenViewController.tickDown),userInfo:nil,repeats:true)
        screenViewController.SVCtimeraddsub = NSTimer.scheduledTimerWithTimeInterval(0.5,target:self,selector:#selector(screenViewController.ticktimeraddsub),userInfo:nil,repeats:true)
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    /*
     获取股票详情
     **/
    func getDetail(){
        let code2=GloMethod.change126CodeTo(code!, symbol: symbol!)
        do{
            
            let opt = try HTTP.GET(GloStr.gpURL2+code2)
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    //                    print(result.text)
                    self.gupiaonew=GloMethod.fromJsonToDetail(result.text!)
                    if !self.gupiaonew.statu!{
                        return
                    }
                    self.price.text=self.gupiaonew._25price
                    
                    
                    let yest0 = Double(self.gupiaonew._34yestclose!)
                    let now0 = Double(self.gupiaonew._25price!)//
                    let todayopeno = Double(self.gupiaonew._28todayopen!)
                    let higho = Double(self.gupiaonew._30top!)
                    let lowo = Double(self.gupiaonew._32bottom!)
                    
                    if now0 < yest0{
                        self.price.textColor = self.greed1
                        self.upDownPer.textColor = self.greed1
                        self.upDownMoney.textColor = self.greed1
                        self.upDownMoney.text=self.gupiaonew._27updown!
                        self.upDownPer.text=self.gupiaonew._29updownpercent!+"%"
                        //                        self.upDownMoney.textColor = self.greed1
                        //                        self.upDownPer.textColor = self.greed1

                    }
                    else{
                        self.price.textColor = self.red1
                        self.upDownPer.textColor = self.red1
                        self.upDownMoney.textColor = self.red1
                        self.upDownMoney.text="+"+self.gupiaonew._27updown!
                        self.upDownPer.text="+"+self.gupiaonew._29updownpercent!+"%"
                        //                        self.upDownMoney.textColor = self.red1
                        //                        self.upDownPer.textColor = self.red1

                    }
                    
                    if todayopeno < yest0{
                        self.todayOpen.textColor = self.greed1
                    }
                    else {
                        self.todayOpen.textColor = self.red1
                    }
                    
                    if higho < yest0{
                        self.high.textColor = self.greed1
                    }
                    else {
                        self.high.textColor = self.red1
                    }
                    
                    if lowo < yest0{
                        self.low.textColor = self.greed1
                    }
                    else {
                        self.low.textColor = self.red1
                    }
                    
                    self.price.text=self.gupiaonew._25price
                    self.high.text=self.gupiaonew._30top
                    self.low.text=self.gupiaonew._32bottom
                    self.changeHandPer.text=self.gupiaonew._37changehandpercent!+"%"
                    //                    self.upDownMoney.text=self.gupiaonew._27updown!
                    //                    self.upDownPer.text=self.gupiaonew._29updownpercent!+"%"
                    self.todayOpen.text=self.gupiaonew._28todayopen
                    //self.yestClose.text=self.gupiaonew._34yestclose
                    
                    
                screenViewController.cjlview.cjl=GloMethod.changeStrToShou(self.gupiaonew._31sumhand!)
                    screenViewController.cjlview.cje=self.gupiaonew._35dealmoney!
                    
                    self.sell5price.text=self.gupiaonew._12sell5!
                    self.sell4price.text=self.gupiaonew._11sell4!
                    self.sell3price.text=self.gupiaonew._10sell3!
                    self.sell2price.text=self.gupiaonew._9sell2!
                    self.sell1price.text=self.gupiaonew._8sell1!
                    self.buy1price.text=self.gupiaonew._3buy1!
                    self.buy2price.text=self.gupiaonew._4buy2!
                    self.buy3price.text=self.gupiaonew._5buy3!
                    self.buy4price.text=self.gupiaonew._6buy4!
                    self.buy5price.text=self.gupiaonew._7buy5!
                    self.sell5num.text=self.gupiaonew._22sell5num!
                    self.sell4num.text=self.gupiaonew._21sell4num!
                    self.sell3num.text=self.gupiaonew._20sell3num!
                    self.sell2num.text=self.gupiaonew._19sell2num!
                    self.sell1num.text=self.gupiaonew._18sell1num!
                    self.buy1num.text=self.gupiaonew._13buy1num!
                    self.buy2num.text=self.gupiaonew._14buy2num!
                    self.buy3num.text=self.gupiaonew._15buy3num!
                    self.buy4num.text=self.gupiaonew._16buy4num!
                    self.buy5num.text=self.gupiaonew._17buy5num!
                    
                    let bjb1 = Double(self.gupiaonew._3buy1!)
                    let bjb2 = Double(self.gupiaonew._4buy2!)
                    let bjb3 = Double(self.gupiaonew._5buy3!)
                    let bjb4 = Double(self.gupiaonew._6buy4!)
                    let bjb5 = Double(self.gupiaonew._7buy5!)
                    let bjs1 = Double(self.gupiaonew._8sell1!)
                    let bjs2 = Double(self.gupiaonew._9sell2!)
                    let bjs3 = Double(self.gupiaonew._10sell3!)
                    let bjs4 = Double(self.gupiaonew._11sell4!)
                    let bjs5 = Double(self.gupiaonew._12sell5!)
                    
                    
                    
                    
                    if bjb1 < yest0{
                        self.buy1price.textColor = self.greed1
                    }                    else {
                        self.buy1price.textColor = self.red1
                    }
                    if bjb1 == 0{
                        self.buy1price.textColor = UIColor.whiteColor()
                        self.buy1price.text = "－－"
                    }
                    if bjb2 < yest0{
                        self.buy2price.textColor = self.greed1
                    }
                    else {
                        self.buy2price.textColor = self.red1
                    }
                    if bjb2 == 0{
                        self.buy2price.textColor = UIColor.whiteColor()
                        self.buy2price.text = "－－"
                    }
                    if bjb3 < yest0{
                        self.buy3price.textColor = self.greed1
                    }
                    else {
                        self.buy3price.textColor = self.red1
                    }
                    if bjb3 == 0{
                        self.buy3price.textColor = UIColor.whiteColor()
                        self.buy3price.text = "－－"
                    }
                    if bjb4 < yest0{
                        self.buy4price.textColor = self.greed1
                    }
                    else {
                        self.buy4price.textColor = self.red1
                    }
                    if bjb4 == 0{
                        self.buy4price.textColor = UIColor.whiteColor()
                        self.buy4price.text = "－－"
                    }
                    if bjb5 < yest0{
                        self.buy5price.textColor = self.greed1
                    }
                    else {
                        self.buy5price.textColor = self.red1
                    }
                    if bjb5 == 0{
                        self.buy5price.textColor = UIColor.whiteColor()
                        self.buy5price.text = "－－"
                    }
                    if bjs1 < yest0{
                        self.sell1price.textColor = self.greed1
                    }
                    else {
                        self.sell1price.textColor = self.red1
                    }
                    if bjs1 == 0{
                        self.sell1price.textColor = UIColor.whiteColor()
                        self.sell1price.text = "－－"
                    }
                    if bjs2 < yest0{
                        self.sell2price.textColor = self.greed1
                    }
                    else {
                        self.sell2price.textColor = self.red1
                    }
                    if bjs2 == 0{
                        self.sell2price.textColor = UIColor.whiteColor()
                        self.sell2price.text = "－－"
                    }
                    if bjs3 < yest0{
                        self.sell3price.textColor = self.greed1
                    }
                    else {
                        self.sell3price.textColor = self.red1
                    }
                    if bjs3 == 0{
                        self.sell3price.textColor = UIColor.whiteColor()
                        self.sell3price.text = "－－"
                    }
                    if bjs4 < yest0{
                        self.sell4price.textColor = self.greed1
                    }
                    else {
                        self.sell4price.textColor = self.red1
                    }
                    if bjs4 == 0{
                        self.sell4price.textColor = UIColor.whiteColor()
                        self.sell4price.text = "－－"
                    }
                    if bjs5 < yest0{
                        self.sell5price.textColor = self.greed1
                    }
                    else {
                        self.sell5price.textColor = self.red1
                    }
                    if bjs5 == 0{
                        self.sell5price.textColor = UIColor.whiteColor()
                        self.sell5price.text = "－－"
                    }

                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.high.setNeedsDisplay()
                        self.low.setNeedsDisplay()
                        self.changeHandPer.setNeedsDisplay()
                        self.price.setNeedsDisplay()
                        self.upDownMoney.setNeedsDisplay()
                        self.upDownPer.setNeedsDisplay()
                        self.todayOpen.setNeedsDisplay()
                        //self.yestClose.setNeedsDisplay()
                        self.dealNum.setNeedsDisplay()
                        self.dealMoney.setNeedsDisplay()
                        
                        
                        self.sell5price.setNeedsDisplay()
                        self.sell4price.setNeedsDisplay()
                        self.sell3price.setNeedsDisplay()
                        self.sell2price.setNeedsDisplay()
                        self.sell1price.setNeedsDisplay()
                        self.buy5price.setNeedsDisplay()
                        self.buy4price.setNeedsDisplay()
                        self.buy3price.setNeedsDisplay()
                        self.buy2price.setNeedsDisplay()
                        self.buy1price.setNeedsDisplay()
                        self.sell5num.setNeedsDisplay()
                        self.sell4num.setNeedsDisplay()
                        self.sell3num.setNeedsDisplay()
                        self.sell2num.setNeedsDisplay()
                        self.sell1num.setNeedsDisplay()
                        self.buy5num.setNeedsDisplay()
                        self.buy4num.setNeedsDisplay()
                        self.buy3num.setNeedsDisplay()
                        self.buy2num.setNeedsDisplay()
                        self.buy1num.setNeedsDisplay()
 

                        screenViewController.cjlview.setNeedsDisplay()
                        
                    })
                }
            }
            
        }catch let error {
            print("请求失败: \(error)")
            
        }
        
        
    }
    
    
    /*
     获取分时数据
     **/
    func getFenshiData(){
        do{
            
            let opt = try HTTP.GET(GloStr.fenshi+code!+".json")
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    self.fenshi = GloMethod.fromJsonToFenshi(result.text!)
                    let fenshi2 = self.fenshi
                    
                    if fenshi2?.data?.count > 10{
                        fenshi2!.data?.removeAtIndex(0)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        self.buttonleftgo.enabled=true
                        self.buttonrightgo.enabled=true
                        
                        self.timeView.timeLineArray = fenshi2
                        self.timeView.setNeedsDisplay()
                        // 这里加addview
                        self.view.addSubview(self.timeView)
                        
                    })
                    
                }
                
            }
            
        }catch let error {
            print("请求失败: \(error)")
        }
        
    }
    /*
     获取分时数据
     **/
    
    func getFenshiData1(){
        do{
            
            let opt = try HTTP.GET(GloStr.fenshi+code!+".json")
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    self.fenshi = GloMethod.fromJsonToFenshi(result.text!)
                    let fenshi2 = self.fenshi
                    
                    if fenshi2?.data?.count > 10{
                        fenshi2!.data?.removeAtIndex(0)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.buttonleftgo.enabled=true
                        self.buttonrightgo.enabled=true
                        
                        self.timeView.timeLineArray = fenshi2
                        self.timeView.setNeedsDisplay()
                        
                    })
                    
                }
                
            }
            
        }catch let error {
            print("请求失败: \(error)")
        }
        
    }
    
    
    func getRiKData(){
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        var datas:[JSON] = []
        do {
            for i in GloStr.K_ri_start...GloStr.K_ri_end{
                let url = GloStr.rikURL+String(i)+"/"+code!+".json"
                
                let opt = try HTTP.New(url, method: .GET)
                opt.onFinish = { response in
                    
                    var dataTemp:[JSON]
                    self.rik = GloMethod.fromJsonTok(response.text!)
                    if self.rik?.data == nil{
                        dataTemp=[]
                    }else{
                        dataTemp = (self.rik?.data)!
                    }
                    
                    datas = datas + dataTemp
                    
                    if i == GloStr.K_ri_end{
                        self.rik?.data = datas
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            if i == GloStr.K_ri_end{
                                self.riView.KLineArray = self.rik
                                self.riView.setNeedsDisplay()
                                self.buttonleftgo.enabled=true
                                self.buttonrightgo.enabled=true
                                if self.riView.KLineArray.data?.count == 0{
                                    
                                }else{
                                    self.view.addSubview(self.riView)
                                }
                            }
                            
                        })
                        
                    }
                    
                }
                
                operationQueue.addOperation(opt)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func addordelete(button:UIButton){
        let addgp:GupiaoBean=GupiaoBean ()
        addgp.name = name
        addgp.symbol = symbol
        addgp.code = code
        let title = button.currentTitle
        if title=="添加自选"{
            if GloMethod.isAdd(self.code!){
                return
                //                    buttonaddsub.setTitle("删除自选", forState:UIControlState.Normal)
            }
            GloMethod.insertGupiaoBean(addgp)
            buttonaddsub.setTitle("删除自选", forState:UIControlState.Normal)
            buttonaddsubpic.setTitle("删除自选", forState:UIControlState.Normal)
            buttonaddsubpic.setBackgroundImage(UIImage(named:"sub_net"),forState:.Normal)
            
            
        }else if title=="删除自选"{
            
            GloMethod.deleteGupiaoBean(self.code!)
            buttonaddsub.setTitle("添加自选", forState:UIControlState.Normal)
            buttonaddsubpic.setTitle("添加自选", forState:UIControlState.Normal)
            buttonaddsubpic.setBackgroundImage(UIImage(named:"add_net"),forState:.Normal)
        }
        
    }
    
    func getZhouKData(){
        
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        var datas:[JSON] = []
        do {
            for i in GloStr.K_zhou_start...GloStr.K_zhou_end{
                let url = GloStr.zhoukURL+String(i)+"/"+code!+".json"
                
                let opt = try HTTP.New(url, method: .GET)
                opt.onFinish = { response in
                    
                    var dataTemp:[JSON]
                    self.zhouk = GloMethod.fromJsonTok(response.text!)
                    if self.zhouk?.data == nil{
                        dataTemp=[]
                    }else{
                        dataTemp = (self.zhouk?.data)!
                    }
                    
                    datas = datas + dataTemp
                    
                    if i == GloStr.K_zhou_end{
                        self.zhouk?.data = datas
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            if i == GloStr.K_zhou_end{
                                self.zhouView.KLineArray = self.zhouk
                                self.zhouView.setNeedsDisplay()
                                
                                self.buttonleftgo.enabled=true
                                self.buttonrightgo.enabled=true
                                if self.zhouView.KLineArray.data?.count == 0{
                                    
                                }else{
                                    self.view.addSubview(self.zhouView)
                                }
                            }
                            
                        })
                        
                    }
                    
                }
                
                operationQueue.addOperation(opt)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    func getYueKData(){
        
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        var datas:[JSON] = []
        do {
            for i in GloStr.K_yue_start...GloStr.K_yue_end{
                let url = GloStr.yuekURL+String(i)+"/"+code!+".json"
                
                let opt = try HTTP.New(url, method: .GET)
                opt.onFinish = { response in
                    
                    var dataTemp:[JSON]
                    self.yuek = GloMethod.fromJsonTok(response.text!)
                    if self.yuek?.data == nil{
                        dataTemp=[]
                    }else{
                        dataTemp = (self.yuek?.data)!
                    }
                    
                    datas = datas + dataTemp
                    
                    if i == GloStr.K_yue_end{
                        self.yuek?.data = datas
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            if i == GloStr.K_yue_end{
                                self.yueView.KLineArray = self.yuek
                                self.yueView.setNeedsDisplay()
                                self.buttonleftgo.enabled=true
                                self.buttonrightgo.enabled=true
                                if self.yueView.KLineArray.data?.count == 0{
                                    
                                }else{
                                    self.view.addSubview(self.yueView)
                                }
                                
                            }
                            
                        })
                        
                    }
                }
                operationQueue.addOperation(opt)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    
    
    func getCode(){
        //获取code
        searchCode=(AppDelegate.delegate as! AppDelegate).searchcode
        if searchCode != nil {
            name = searchCode![0]
            symbol = searchCode![1]
            code = searchCode![2]
            gpAndSymbol.text = name!+"("+symbol!+")"
            //             (AppDelegate.delegate as! AppDelegate).searchcode = nil
        }
        
        
    }
    func setButton(){
        
        buttonzhibiao.frame=CGRectMake(UIScreen.mainScreen().bounds.width - 120, UIScreen.mainScreen().bounds.height - 35, 80, 29)
        buttonzhibiao.setTitleColor(UIColor.grayColor() , forState: UIControlState.Normal)
        buttonzhibiao.setTitle("K线设置", forState:UIControlState.Normal)
        buttonzhibiao.titleLabel?.font = UIFont.systemFontOfSize(12)
        buttonzhibiao.titleLabel?.textAlignment = NSTextAlignment.Center
        buttonzhibiao.tintColor = UIColor.grayColor()
        buttonzhibiao.addTarget(self,action:#selector(buttonKlineSet(_:)),forControlEvents:.TouchUpInside)
        self.view.addSubview(buttonzhibiao);
        
        
        segmented = UISegmentedControl(items:items)
        segmented.center = self.view.center
        segmented.selectedSegmentIndex = 1
        segmented.addTarget(self, action: #selector(segmentDidchange(_:)),
                            forControlEvents: UIControlEvents.ValueChanged)
        segmented.frame=CGRectMake(50, UIScreen.mainScreen().bounds.height - 35, 200, 29)
        segmented.tintColor = UIColor.grayColor()
        segmented.layer.masksToBounds = true
        segmented.layer.borderColor = UIColor.grayColor().CGColor
        segmented.layer.borderWidth = 1
        segmented.layer.cornerRadius = 15
        self.view.addSubview(segmented)
        

        
        
        
        buttonback.frame=CGRectMake(10, 5, 40, 40)
        buttonback.setBackgroundImage(UIImage(named:"backs100"),forState:.Normal)
        self.view.addSubview(buttonback);
        buttonback.addTarget(self,action:#selector(tapped),forControlEvents:.TouchUpInside)
        


        buttonleftgo.frame=CGRectMake(UIScreen.mainScreen().bounds.width/11, 5, 40, 40)
        buttonleftgo.setBackgroundImage(UIImage(named:"lefts100"),forState:.Normal)
        buttonleftgo.addTarget(self,action:#selector(btleftgo),forControlEvents:.TouchUpInside)
        
        buttonrightgo.frame=CGRectMake(UIScreen.mainScreen().bounds.width*3.25/11, 5, 40, 40)
        buttonrightgo.setBackgroundImage(UIImage(named:"rights100"),forState:.Normal)
        buttonrightgo.addTarget(self,action:#selector(btrightgo),forControlEvents:.TouchUpInside)
        
        if c1.listdo{
            self.view.addSubview(buttonleftgo);
            self.view.addSubview(buttonrightgo);
        }else if c2.listdo{
            self.view.addSubview(buttonleftgo);
            self.view.addSubview(buttonrightgo);
        }else{
            
        }
        
        

        buttonmacd.frame=CGRectMake(UIScreen.mainScreen().bounds.width - 200, UIScreen.mainScreen().bounds.height - 35, 80, 29)
        buttonmacd.setTitleColor(UIColor.grayColor() , forState: UIControlState.Normal)
        buttonmacd.setTitle("成交量 ⇧", forState:UIControlState.Normal)
        buttonmacd.titleLabel?.font = UIFont.systemFontOfSize(12)
        buttonmacd.titleLabel?.textAlignment = NSTextAlignment.Center
        buttonmacd.tintColor = UIColor.grayColor()
        buttonmacd.layer.masksToBounds = true
        buttonmacd.layer.borderColor = UIColor.grayColor().CGColor
        buttonmacd.layer.borderWidth = 1
        buttonmacd.layer.cornerRadius = 15
        buttonmacd.addTarget(self,action:#selector(buttonViewVisible(_:)),forControlEvents:.TouchUpInside)
        
        self.view.addSubview(buttonmacd);
        

        
        
        
        
        

        buttonaddsub.frame=CGRectMake(UIScreen.mainScreen().bounds.width - 90, 45, 100, 30)
        buttonaddsubpic.frame=CGRectMake(UIScreen.mainScreen().bounds.width - 50, 5, 40, 40)
        buttonaddsub.setTitleColor(UIColor.whiteColor() , forState: UIControlState.Normal)
        buttonaddsubpic.setTitleColor(UIColor.clearColor() , forState: UIControlState.Normal)
        if GloMethod.isAdd(self.code!) {
            buttonaddsub.setTitle("删除自选", forState:UIControlState.Normal)
            buttonaddsubpic.setTitle("删除自选", forState:UIControlState.Normal)
            buttonaddsubpic.setBackgroundImage(UIImage(named:"sub_net"),forState:.Normal)
        }
        else {
            buttonaddsub.setTitle("添加自选", forState:UIControlState.Normal)
            buttonaddsubpic.setTitle("添加自选", forState:UIControlState.Normal)
            buttonaddsubpic.setBackgroundImage(UIImage(named:"add_net"),forState:.Normal)
        }
        buttonaddsub.addTarget(self,action:#selector(addordelete(_:)),forControlEvents:.TouchUpInside)
//        self.view.addSubview(buttonaddsub);
        buttonaddsubpic.addTarget(self,action:#selector(addordelete(_:)),forControlEvents:.TouchUpInside)
        self.view.addSubview(buttonaddsubpic);
    }
    
    func segmentDidchange(segmented:UISegmentedControl){
        switch segmented.selectedSegmentIndex
        {
            


        case 1:

            buttonmacd.hidden=false

            timeView.hidden = true
            riView.hidden = false
            zhouView.hidden = true
            yueView.hidden = true
            getRiKData()
        case 2:

            buttonmacd.hidden=false

            timeView.hidden = true
            riView.hidden = true
            zhouView.hidden = false
            yueView.hidden = true
            getZhouKData()
        case 3:
            buttonmacd.hidden=false
            
            timeView.hidden = true
            riView.hidden = true
            zhouView.hidden = true
            yueView.hidden = false
            getYueKData()
//        timeline
        case 0:

            buttonmacd.hidden=true

            timeView.hidden = false
            riView.hidden = true
            zhouView.hidden = true
            yueView.hidden = true

            getFenshiData()
            
            
        default:
            break;
        }
    }
    
    
    
    func setHengtiao(){
        //横条设置
                page1.backgroundColor = gray1
                page1.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.width , 50)
                self.view.addSubview(page1)
                self.view.sendSubviewToBack(page1)
        
                page2.backgroundColor = bule1
                page2.frame = CGRectMake(0,50, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height-90)
                self.view.addSubview(page2)
                self.view.sendSubviewToBack(page2)
        
                page3.backgroundColor = gray1
                page3.frame = CGRectMake(0,UIScreen.mainScreen().bounds.height-40, UIScreen.mainScreen().bounds.width , 40)
                self.view.addSubview(page3)
                self.view.sendSubviewToBack(page3)
        
        screenViewController.cjlview.cjl="-"
        screenViewController.cjlview.cje="-"
        screenViewController.cjlview.backgroundColor = UIColor.clearColor()
        screenViewController.cjlview.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7.25/11 + 25, 0, UIScreen.mainScreen().bounds.width*2/11, 60)//(UIScreen.mainScreen().bounds.width*4/6 + 30, 150, UIScreen.mainScreen().bounds.width*2/6 - 30 , 60)
        self.view.addSubview(screenViewController.cjlview)
        

        
        
    }
    
    
    func setGP(){
        gpname.frame = CGRectMake(UIScreen.mainScreen().bounds.width*1.75/11, 5, UIScreen.mainScreen().bounds.width*1.5/11, 20)
        gpname.text = "股票名字"
        gpname.textColor = UIColor.whiteColor()
        gpname.font = UIFont.systemFontOfSize(15)
        gpname.textAlignment=NSTextAlignment.Center
        self.view.addSubview(gpname)

        gpsymbol.frame = CGRectMake(UIScreen.mainScreen().bounds.width*1.75/11, 25, UIScreen.mainScreen().bounds.width*1.5/11, 20)
        gpsymbol.text = "股票代码"
        gpsymbol.textColor = UIColor.whiteColor()
        gpsymbol.font = UIFont.systemFontOfSize(15)
        gpsymbol.textAlignment=NSTextAlignment.Center
        self.view.addSubview(gpsymbol)

        price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/11, 5, UIScreen.mainScreen().bounds.width*1.5/11, 20)
        price.text = "当前价"
        price.textColor = UIColor.whiteColor()
        price.font = UIFont.systemFontOfSize(15)
        price.adjustsFontSizeToFitWidth=true
        price.textAlignment=NSTextAlignment.Center
        self.view.addSubview(price)

        upDownMoney.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/11, 25, UIScreen.mainScreen().bounds.width/11, 20)
        upDownMoney.text = "涨额"
        upDownMoney.textColor = UIColor.whiteColor()
        upDownMoney.font = UIFont.systemFontOfSize(10)
        upDownMoney.textAlignment=NSTextAlignment.Left
        self.view.addSubview(upDownMoney)

        upDownPer.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4.75/11, 25, UIScreen.mainScreen().bounds.width/11, 20)
        upDownPer.text = "涨幅"
        upDownPer.textColor = UIColor.whiteColor()
        upDownPer.font = UIFont.systemFontOfSize(10)
        upDownPer.textAlignment=NSTextAlignment.Left
        self.view.addSubview(upDownPer)

        hightext.frame = CGRectMake(UIScreen.mainScreen().bounds.width*5.5/11, 5, UIScreen.mainScreen().bounds.width/11, 20)
        hightext.text = "高:"
        hightext.textColor = UIColor.whiteColor()
        hightext.font = UIFont.systemFontOfSize(12)
        hightext.textAlignment=NSTextAlignment.Left
        self.view.addSubview(hightext)

        lowtext.frame = CGRectMake(UIScreen.mainScreen().bounds.width*5.5/11, 25, UIScreen.mainScreen().bounds.width/11, 20)
        lowtext.text = "低:"
        lowtext.textColor = UIColor.whiteColor()
        lowtext.font = UIFont.systemFontOfSize(12)
        lowtext.textAlignment=NSTextAlignment.Left
        self.view.addSubview(lowtext)

        todayOpentext.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/11, 5, UIScreen.mainScreen().bounds.width/11, 20)
        todayOpentext.text = "开:"
        todayOpentext.textColor = UIColor.whiteColor()
        todayOpentext.font = UIFont.systemFontOfSize(12)
        todayOpentext.textAlignment=NSTextAlignment.Left
        self.view.addSubview(todayOpentext)

        changeHandPertext.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/11, 25, UIScreen.mainScreen().bounds.width/11, 20)
        changeHandPertext.text = "换:"
        changeHandPertext.textColor = UIColor.whiteColor()
        changeHandPertext.font = UIFont.systemFontOfSize(12)
        changeHandPertext.textAlignment=NSTextAlignment.Left
        self.view.addSubview(changeHandPertext)

        dealNumtext.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8.5/11, 5, UIScreen.mainScreen().bounds.width/11, 20)
        dealNumtext.text = "量:"
        dealNumtext.textColor = UIColor.whiteColor()
        dealNumtext.font = UIFont.systemFontOfSize(12)
        dealNumtext.textAlignment=NSTextAlignment.Left
        self.view.addSubview(dealNumtext)

        dealMoneytext.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8.5/11, 25, UIScreen.mainScreen().bounds.width/11, 20)
        dealMoneytext.text = "额:"
        dealMoneytext.textColor = UIColor.whiteColor()
        dealMoneytext.font = UIFont.systemFontOfSize(12)
        dealMoneytext.textAlignment=NSTextAlignment.Left
        self.view.addSubview(dealMoneytext)

        high.frame = CGRectMake(UIScreen.mainScreen().bounds.width*5.5/11 + 25, 5, UIScreen.mainScreen().bounds.width/11, 20)
        high.text = "0.0"
        high.textColor = UIColor.whiteColor()
        high.font = UIFont.systemFontOfSize(12)
        high.adjustsFontSizeToFitWidth=true
        high.textAlignment=NSTextAlignment.Left
        self.view.addSubview(high)

        low.frame = CGRectMake(UIScreen.mainScreen().bounds.width*5.5/11 + 25, 25, UIScreen.mainScreen().bounds.width/11, 20)
        low.text = "0.0"
        low.textColor = UIColor.whiteColor()
        low.font = UIFont.systemFontOfSize(12)
        low.adjustsFontSizeToFitWidth=true
        low.textAlignment=NSTextAlignment.Left
        self.view.addSubview(low)

        todayOpen.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/11 + 25, 5, UIScreen.mainScreen().bounds.width/11, 20)
        todayOpen.text = "0.0"
        todayOpen.textColor = UIColor.whiteColor()
        todayOpen.font = UIFont.systemFontOfSize(12)
        todayOpen.adjustsFontSizeToFitWidth=true
        todayOpen.textAlignment=NSTextAlignment.Left
        self.view.addSubview(todayOpen)

        changeHandPer.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/11 + 25, 25, UIScreen.mainScreen().bounds.width/11, 20)
        changeHandPer.text = "0.0"
        changeHandPer.textColor = UIColor.whiteColor()
        changeHandPer.font = UIFont.systemFontOfSize(12)
        changeHandPer.adjustsFontSizeToFitWidth=true
        changeHandPer.textAlignment=NSTextAlignment.Left
        self.view.addSubview(changeHandPer)
        
        

        bspr.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5,50, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 90)/12)
        bspr.text = "五档"
        bspr.textColor = UIColor.whiteColor()
        bspr.font = UIFont.systemFontOfSize(buySellTextSize)
        bspr.textAlignment=NSTextAlignment.Center
        self.view.addSubview(bspr)
        
        //分割线
        fiveline.backgroundColor = gray1
        fiveline.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 3,45 + (UIScreen.mainScreen().bounds.height - 90)*1/11, UIScreen.mainScreen().bounds.width/5 - 6 , 1)
        self.view.addSubview(fiveline)
        
        fiveline2.backgroundColor = gray1
        fiveline2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 3,45 + (UIScreen.mainScreen().bounds.height - 90)*6/11, UIScreen.mainScreen().bounds.width/5 - 6 , 1)
        self.view.addSubview(fiveline2)
        
        
        sell5.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*1/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell5.text = "卖5   "
        sell5.textColor = UIColor.whiteColor()
        sell5.font = UIFont.systemFontOfSize(buySellTextSize)
        sell5.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell5)
        
        sell4.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*2/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell4.text = "卖4   "
        sell4.textColor = UIColor.whiteColor()
        sell4.font = UIFont.systemFontOfSize(buySellTextSize)
        sell4.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell4)
        
        sell3.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*3/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell3.text = "卖3   "
        sell3.textColor = UIColor.whiteColor()
        sell3.font = UIFont.systemFontOfSize(buySellTextSize)
        sell3.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell3)
        
        sell2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*4/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell2.text = "卖2   "
        sell2.textColor = UIColor.whiteColor()
        sell2.font = UIFont.systemFontOfSize(buySellTextSize)
        sell2.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell2)
        
        sell1.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*5/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell1.text = "卖1  "
        sell1.textColor = UIColor.whiteColor()
        sell1.font = UIFont.systemFontOfSize(buySellTextSize)
        sell1.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell1)
        
        
        buy1.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*6/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy1.text = "买1   "
        buy1.textColor = UIColor.whiteColor()
        buy1.font = UIFont.systemFontOfSize(buySellTextSize)
        buy1.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy1)
        
        buy2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*7/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy2.text = "买2   "
        buy2.textColor = UIColor.whiteColor()
        buy2.font = UIFont.systemFontOfSize(buySellTextSize)
        buy2.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy2)
        
        buy3.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*8/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy3.text = "买3   "
        buy3.textColor = UIColor.whiteColor()
        buy3.font = UIFont.systemFontOfSize(buySellTextSize)
        buy3.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy3)
        
        buy4.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*9/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy4.text = "买4   "
        buy4.textColor = UIColor.whiteColor()
        buy4.font = UIFont.systemFontOfSize(buySellTextSize)
        buy4.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy4)
        
        buy5.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/5 + 5,50 + (UIScreen.mainScreen().bounds.height - 90)*10/11, UIScreen.mainScreen().bounds.width/5, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy5.text = "买5   "
        buy5.textColor = UIColor.whiteColor()
        buy5.font = UIFont.systemFontOfSize(buySellTextSize)
        buy5.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy5)
        
        sell5price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*1/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell5price.text = "－"
        sell5price.textColor = UIColor.whiteColor()
        sell5price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell5price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell5price)
        
        sell4price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*2/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell4price.text = "－"
        sell4price.textColor = UIColor.whiteColor()
        sell4price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell4price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell4price)
        
        sell3price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*3/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell3price.text = "－"
        sell3price.textColor = UIColor.whiteColor()
        sell3price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell3price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell3price)
        
        sell2price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*4/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell2price.text = "－"
        sell2price.textColor = UIColor.whiteColor()
        sell2price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell2price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell2price)
        
        sell1price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*5/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell1price.text = "－"
        sell1price.textColor = UIColor.whiteColor()
        sell1price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell1price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell1price)
        
        
        buy1price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*6/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy1price.text = "－"
        buy1price.textColor = UIColor.whiteColor()
        buy1price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy1price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy1price)
        
        buy2price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*7/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy2price.text = "－"
        buy2price.textColor = UIColor.whiteColor()
        buy2price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy2price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy2price)
        
        buy3price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*8/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy3price.text = "－"
        buy3price.textColor = UIColor.whiteColor()
        buy3price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy3price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy3price)
        
        buy4price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*9/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy4price.text = "－"
        buy4price.textColor = UIColor.whiteColor()
        buy4price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy4price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy4price)
        
        buy5price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*13/15,50 + (UIScreen.mainScreen().bounds.height - 90)*10/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy5price.text = "－"
        buy5price.textColor = UIColor.whiteColor()
        buy5price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy5price.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy5price)
        
        
        sell5num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*1/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell5num.text = "－"
        sell5num.textColor = UIColor.whiteColor()
        sell5num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell5num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell5num)
        
        sell4num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*2/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell4num.text = "－"
        sell4num.textColor = UIColor.whiteColor()
        sell4num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell4num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell4num)
        
        sell3num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*3/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell3num.text = "－"
        sell3num.textColor = UIColor.whiteColor()
        sell3num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell3num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell3num)
        
        sell2num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*4/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell2num.text = "－"
        sell2num.textColor = UIColor.whiteColor()
        sell2num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell2num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell2num)
        
        sell1num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*5/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell1num.text = "－"
        sell1num.textColor = UIColor.whiteColor()
        sell1num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell1num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(sell1num)
        
        
        buy1num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*6/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy1num.text = "－"
        buy1num.textColor = UIColor.whiteColor()
        buy1num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy1num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy1num)
        
        buy2num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*7/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy2num.text = "－"
        buy2num.textColor = UIColor.whiteColor()
        buy2num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy2num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy2num)
        
        buy3num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*8/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy3num.text = "－"
        buy3num.textColor = UIColor.whiteColor()
        buy3num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy3num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy3num)
        
        buy4num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*9/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy4num.text = "－"
        buy4num.textColor = UIColor.whiteColor()
        buy4num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy4num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy4num)
        
        buy5num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*14/15,50 + (UIScreen.mainScreen().bounds.height - 90)*10/11, UIScreen.mainScreen().bounds.width/15, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy5num.text = "－"
        buy5num.textColor = UIColor.whiteColor()
        buy5num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy5num.textAlignment=NSTextAlignment.Center //
        self.view.addSubview(buy5num)
        
    }
    
    
    //button方法
    
    func buttonKlineSet(button:UIButton){
        self.presentViewController(KlineSetvc, animated: false, completion: nil)
        
    }
    
    func tapped(){
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")        
        
        screenViewController.SVCtimer.invalidate()
        buttonmacd.hidden=true
        
        timeView.hidden = true
        riView.hidden = false
        zhouView.hidden = true
        yueView.hidden = true
        
        getFenshiData()
        
         segmented.selectedSegmentIndex = 1
        
        if (AppDelegate.delegate as! AppDelegate).listGP?.count > 0{
        screenViewController.scviewlrdo2=true
        }
        self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
        
        
//        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
//        self.presentViewController(anotherView, animated: false, completion: nil)
        
        
        
        

 

//        c1.listdo=false
//        c2.listdo=false
//        g1.g1code = nil
//        g2.g2code = nil
////        g1.g1timer.invalidate()
////        g1.g1timeraddsub.invalidate()
////        g2.g2timer.invalidate()
////        g2.g2timeraddsub.invalidate()
//
//        
//        if c1.isDoc1{
//            c1.isDo=true
//            c1.isDoc1=false
//            g1.isDo=false
//            g2.isDo=false
//            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
//        }else if c2.isDoc2{
//            c2.isDo=true
//            c2.isDoc2=false
//            g1.isDo=false
//            g2.isDo=false
//            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
//        }else{
//            g1.isDo=false
//            g2.isDo=false
//            c1.isDo=true
//            c2.isDo=true
//            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
//        }
//        
//        //        timer.invalidate()
//        //        timeraddsub.invalidate()
    }
    
    

    func buttonViewVisible(button:UIButton){
        if !buttonviewisDo{
            
            self.buttonview = btview()
            self.buttonview.setChange(self)
            
            var ksetList=GloMethod.selectAllKset();
            
            for kset in ksetList {
                if kset.name == "成交量" {
                    if kset.isUse=="1" {
                        self.buttonview.contents.append("0")
                    }
                    
                }
                if kset.name == "MACD"{
                    if kset.isUse=="1" {
                        self.buttonview.contents.append("1")
                    }
                }
                if kset.name == "KDJ" {
                    if kset.isUse=="1" {
                        self.buttonview.contents.append("2")
                    }
                }
            }
        }

        
        
        if !buttonviewisDo{
            
            self.buttonview.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - 70, UIScreen.mainScreen().bounds.width, 30)
            self.buttonview.backgroundColor = bule1
            buttonview.layer.masksToBounds = true
            buttonview.layer.borderColor = UIColor.grayColor().CGColor
            
            
            self.view.addSubview(self.buttonview)
            buttonviewisDo=true
        }else if buttonviewisDo{
            self.buttonview.removeFromSuperview()
            
            buttonviewisDo=false
        }
        
    }
    func changeKViewLine(page:Int){
        
        riView.setsz(page)
        zhouView.setsz(page)
        yueView.setsz(page)
        switch page {
        case 1:
            self.buttonmacd.titleLabel?.text = "成交量 ⇧"
            buttonmacd.setTitle("成交量 ⇧", forState:UIControlState.Normal)
        case 2:
            self.buttonmacd.titleLabel?.text = "MACD ⇧"
            buttonmacd.setTitle("MACD ⇧", forState:UIControlState.Normal)
        //                btname = "MACD"
        case 3:
            self.buttonmacd.titleLabel?.text = "KDJ ⇧"
            buttonmacd.setTitle("KDJ ⇧", forState:UIControlState.Normal)
        //                btname = "KDJ"
        default: break
        }
        self.buttonview.removeFromSuperview()
        buttonviewisDo=false
        
        
        
    }
    
    
    
    func btleftgo(){
        screenViewController.scviewlrdo=true
        
        //        g1.g1code = nil
        buttonleftgo.enabled=false
        
        //        if btlrgo{
        //             btlrgo = false
        
        var list:[ListBean]=(AppDelegate.delegate as! AppDelegate).listGP!
        var index:Int!
        for i in 0...list.count-1 {
            if code==list[i].code {
                index=i
                break
            }
        }
        if index>0 {
            index=index-1
        }else{
            index=list.count-1
        }
        let bean=list[index]
        
        (AppDelegate.delegate as! AppDelegate).searchcode = nil
        (AppDelegate.delegate as! AppDelegate).searchcode = [bean.name!,bean.symbol!,bean.code!]
        
        getCode()
        g2.g2code = nil
        g2.g2code = searchCode![2]
        g2.g2codego = true
        
        g1.g1code = nil
        g1.g1code = searchCode![2]
        g1.g1codego = true

        
        getFenshiData1()
        
        self.riView.removeFromSuperview()
        self.zhouView.removeFromSuperview()
        self.yueView.removeFromSuperview()
        rivdo=riView.hidden
        zhouvdo=zhouView.hidden
        yuevdo=yueView.hidden
        riView = KlineView()
        zhouView = KlineView()
        yueView = KlineView()
        self.riView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)//(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        self.zhouView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
        self.yueView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
        riView.buttonopen.hidden = true
        zhouView.buttonopen.hidden = true
        yueView.buttonopen.hidden = true
        riView.hidden=rivdo
        zhouView.hidden=zhouvdo
        yueView.hidden=yuevdo
//        setViewProtrol()
        
//        setButton()
//        setHengtiao()
//        setGP()
        
        
        
        gpAndSymbol.text = name!+"("+symbol!+")"
        gpname.text = name
        gpsymbol.text = symbol
        
        
        getDetail()
        
        if riView.hidden == false{
            
            riView.hidden = false
            zhouView.hidden = true
            yueView.hidden = true
            getRiKData()
        
        }else if zhouView.hidden == false{

            riView.hidden = true
            zhouView.hidden = false
            yueView.hidden = true
            getZhouKData()
            
        }else if yueView.hidden == false{

            riView.hidden = true
            zhouView.hidden = true
            yueView.hidden = false
            getYueKData()
        }
        
        //            btlrgo = true
        //        }
        //
    }
    
    
    func btrightgo(){
        
        screenViewController.scviewlrdo=true
        //        g1.g1code = nil
        buttonrightgo.enabled=false
        
        var list:[ListBean]=(AppDelegate.delegate as! AppDelegate).listGP!
        var index:Int!
        for i in 0...list.count-1 {
            if code==list[i].code {
                index=i
                break
            }
        }
        if index<list.count-1 {
            index=index+1
        }else{
            index=0
        }
        let bean=list[index]
        
        (AppDelegate.delegate as! AppDelegate).searchcode = nil
        (AppDelegate.delegate as! AppDelegate).searchcode = [bean.name!,bean.symbol!,bean.code!]
        
        getCode()
        g2.g2code = nil
        g2.g2code = searchCode![2]
        g2.g2codego = true
        
        g1.g1code = nil
        g1.g1code = searchCode![2]
        g1.g1codego = true
        
        
        getFenshiData1()
        
        
        

        self.riView.removeFromSuperview()
        self.zhouView.removeFromSuperview()
        self.yueView.removeFromSuperview()
        rivdo=riView.hidden
        zhouvdo=zhouView.hidden
        yuevdo=yueView.hidden
        riView = KlineView()
        zhouView = KlineView()
        yueView = KlineView()
        self.riView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)//(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        self.zhouView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
        self.yueView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
        riView.buttonopen.hidden = true
        zhouView.buttonopen.hidden = true
        yueView.buttonopen.hidden = true
        riView.hidden=rivdo
        zhouView.hidden=zhouvdo
        yueView.hidden=yuevdo
        
//        setViewProtrol()
//        setButton()
//        setHengtiao()
//        setGP()
        
        
        
        gpAndSymbol.text = name!+"("+symbol!+")"
        gpname.text = name
        gpsymbol.text = symbol
        
        
        getDetail()
        
        
        if riView.hidden == false{

            riView.hidden = false
            zhouView.hidden = true
            yueView.hidden = true
            getRiKData()
        }else if zhouView.hidden == false{

            riView.hidden = true
            zhouView.hidden = false
            yueView.hidden = true
            getZhouKData()
            
        }else if yueView.hidden == false{
  
            riView.hidden = true
            zhouView.hidden = true
            yueView.hidden = false
            getYueKData()
        }
        //

    }
    
    
    
    func ticktimeraddsub()
    {
//        
//        
//        if g1.g1code != nil{
//            //            if code != g1.g1code{
//            if g1.g1codego{
//                
//                
//                g1.g1codego = false
//                
//                var list:[ListBean]=(AppDelegate.delegate as! AppDelegate).listGP!
//                var index:Int!
//                for i in 0...list.count-1 {
//                    if g1.g1code==list[i].code {
//                        index=i
//                        break
//                    }
//                }
//                
//                
//                let bean=list[index]
//                
//                (AppDelegate.delegate as! AppDelegate).searchcode = [bean.name!,bean.symbol!,bean.code!]
//                
//                getCode()
//                
//                
//                
//
//                self.riView.removeFromSuperview()
//                self.zhouView.removeFromSuperview()
//                self.yueView.removeFromSuperview()
//                rivdo=riView.hidden
//                zhouvdo=zhouView.hidden
//                yuevdo=yueView.hidden
//                riView = KlineView()
//                zhouView = KlineView()
//                yueView = KlineView()
//                self.riView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)//(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
//                self.zhouView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
//                self.yueView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
//                riView.hidden=rivdo
//                zhouView.hidden=zhouvdo
//                yueView.hidden=yuevdo
//                
//                
//                setButton()
//                setHengtiao()
//                setGP()
//                
//                
//                
//                gpAndSymbol.text = name!+"("+symbol!+")"
//                gpname.text = name
//                gpsymbol.text = symbol
//                
//                
//                getDetail()
//                
//                if riView.hidden == false{
//                    riView.hidden = false
//                    zhouView.hidden = true
//                    yueView.hidden = true
//                    getRiKData()
//                }else if zhouView.hidden == false{
//                    riView.hidden = true
//                    zhouView.hidden = false
//                    yueView.hidden = true
//                    getZhouKData()
//                    
//                }else if yueView.hidden == false{
//                    riView.hidden = true
//                    zhouView.hidden = true
//                    yueView.hidden = false
//                    getYueKData()
//                }
//                
//            }
//            //            }
//        }else if g2.g2code != nil{
//            //            if name != g2.g2code{
//            if g2.g2codego{
//                
//                g2.g2codego = false
//                
//                let list:[ListBean]=(AppDelegate.delegate as! AppDelegate).listGP!
//                var index:Int!
//                for i in 0...list.count-1 {
//                    if list[i].code == g2.g2code {
//                        index=i
//                        break
//                    }
//                }
//                let bean=list[index]
//                
//                (AppDelegate.delegate as! AppDelegate).searchcode = [bean.name!,bean.symbol!,bean.code!]
//                
//                getCode()
//                
//                
//                
//                
//                self.riView.removeFromSuperview()
//                self.zhouView.removeFromSuperview()
//                self.yueView.removeFromSuperview()
//                rivdo=riView.hidden
//                zhouvdo=zhouView.hidden
//                yuevdo=yueView.hidden
//                riView = KlineView()
//                zhouView = KlineView()
//                yueView = KlineView()
//                self.riView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)//(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
//                self.zhouView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
//                self.yueView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
//                riView.hidden=rivdo
//                zhouView.hidden=zhouvdo
//                yueView.hidden=yuevdo
//                
//                
//                setButton()
//                setHengtiao()
//                setGP()
//                
//                
//                
//                gpAndSymbol.text = name!+"("+symbol!+")"
//                gpname.text = name
//                gpsymbol.text = symbol
//                
//                
//                getDetail()
//                
//                if riView.hidden == false{
//                    riView.hidden = false
//                    zhouView.hidden = true
//                    yueView.hidden = true
//                    getRiKData()
//                }else if zhouView.hidden == false{
//                    riView.hidden = true
//                    zhouView.hidden = false
//                    yueView.hidden = true
//                    getZhouKData()
//                    
//                }else if yueView.hidden == false{
//                    riView.hidden = true
//                    zhouView.hidden = true
//                    yueView.hidden = false
//                    getYueKData()
//                }
//            }
//        }
        
    }
    
    
    func tickDown()
    {
        getCode()
 
        setViewProtrol()
        gpAndSymbol.text = name!+"("+symbol!+")"
        gpname.text = name
        gpsymbol.text = symbol
        
        if screenViewController.isDo {
            
            
            getDetail()
            getFenshiData1()
            
            if g1.g1doSVC == true {
                
                g1.g1doSVC = false
                self.riView.removeFromSuperview()
                self.zhouView.removeFromSuperview()
                self.yueView.removeFromSuperview()
                rivdo=riView.hidden
                zhouvdo=zhouView.hidden
                yuevdo=yueView.hidden
                riView = KlineView()
                zhouView = KlineView()
                yueView = KlineView()
//                self.riView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)//(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
//                self.zhouView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
//                self.yueView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
                riView.buttonopen.hidden = true
                zhouView.buttonopen.hidden = true
                yueView.buttonopen.hidden = true
                riView.hidden=rivdo
                zhouView.hidden=zhouvdo
                yueView.hidden=yuevdo

                if riView.hidden == false{

                    riView.hidden = false
                    zhouView.hidden = true
                    yueView.hidden = true
                    getRiKData()
                }else if zhouView.hidden == false{

                    riView.hidden = true
                    zhouView.hidden = false
                    yueView.hidden = true
                    getZhouKData()
                    
                }else if yueView.hidden == false{

                    riView.hidden = true
                    zhouView.hidden = true
                    yueView.hidden = false
                    getYueKData()
                }
            }else if g2.g2doSVC == true{
                
                g2.g2doSVC = false
                self.riView.removeFromSuperview()
                self.zhouView.removeFromSuperview()
                self.yueView.removeFromSuperview()
                rivdo=riView.hidden
                zhouvdo=zhouView.hidden
                yuevdo=yueView.hidden
                riView = KlineView()
                zhouView = KlineView()
                yueView = KlineView()
//                self.riView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)//(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
//                self.zhouView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
//                self.yueView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
                riView.buttonopen.hidden = true
                zhouView.buttonopen.hidden = true
                yueView.buttonopen.hidden = true
                riView.hidden=rivdo
                zhouView.hidden=zhouvdo
                yueView.hidden=yuevdo
                
                if riView.hidden == false{

                    riView.hidden = false
                    zhouView.hidden = true
                    yueView.hidden = true
                    getRiKData()
                }else if zhouView.hidden == false{

                    riView.hidden = true
                    zhouView.hidden = false
                    yueView.hidden = true
                    getZhouKData()
                    
                }else if yueView.hidden == false{

                    riView.hidden = true
                    zhouView.hidden = true
                    yueView.hidden = false
                    getYueKData()
                }
            }
            if screenViewController.kviewisno{
                screenViewController.kviewisno = false
                self.riView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)//(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
                self.zhouView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
                self.yueView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
                riView.buttonopen.hidden = true
                zhouView.buttonopen.hidden = true
                yueView.buttonopen.hidden = true
            }
         
        }
        
    }
    
    
    func searchss(){
        if g1.ssdo{
            timeView.frame = CGRectMake(5,50, UIScreen.mainScreen().bounds.width - 10, UIScreen.mainScreen().bounds.height-90)
            g1.ssdo=false
        }else{
            timeView.frame = CGRectMake(5,50, (UIScreen.mainScreen().bounds.width - 10)*4/5, UIScreen.mainScreen().bounds.height-90)
            g1.ssdo=true
        }
        
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
//
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.LandscapeRight
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


