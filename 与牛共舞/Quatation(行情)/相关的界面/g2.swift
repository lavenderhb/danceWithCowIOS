//
//  g2.swift
//  dancewithcow
//
//  Created by 章如强 on 16/5/10.
//  Copyright © 2016年 章如强. All rights reserved.
//

import UIKit
import SwiftHTTP

class g2: UIViewController,ChangeLine,ChangeTop,JumpToHeng {
    func jump() {
        self.presentViewController(openvc, animated: false, completion: nil)
    }
    
    func change(page: Int) {
        changeKViewLine(page)
    }
    func changeTopData(top: Double, low: Double, cjl: Double, Open: Double, close: Double) {
        self.price.text=String(close)
        g2.todayOpen.text=String(Open)
        self.high.text=String(top)
        self.low.text=String(low)
        //        self.dealNum.text=String(cjl)
        
        //        cjlview.cjl=GloMethod.changeStrToShou(String(cjl))
    }
    
    static var g2doSVC:Bool=false
    static var g2timer:NSTimer!
    static var g2timeraddsub:NSTimer!
    static var isDo:Bool=true
    static var isDog2:Bool=false
    
    //横屏页面左右跳转后页面刷新
    static var scviewlrgo:NSTimer!

    
    var searchvc = searchViewController()
    var openvc = screenViewController()
    
    var KlineSetvc = KlineSetViewController()//k线设置页面
    
    
    let buttonaddsub:UIButton = UIButton(type:.System)
    let buttonaddsubpic:UIButton = UIButton(type:.System)
    
    
    var list:[ListBean]=[]
    let buttonleftgo:UIButton = UIButton(type:.System)
    let buttonrightgo:UIButton = UIButton(type:.System)
    static var g2code:String!
    static var g2codego:Bool=false
    //    var btlrgo:Bool=true
    
    let buttonback:UIButton = UIButton(type:.System)
    let buttonsearch:UIButton = UIButton(type:.System)
    let buttonkadd:UIButton = UIButton(type:.System)
    
    
    let buttonmacd:UIButton = UIButton(type:.System)
    let buttonkdj:UIButton = UIButton(type:.System)
    let buttonv:UIButton = UIButton(type:.System)
    let buttonzhibiao:UIButton = UIButton(type:.System)
    
    var buttonview = btview()
    
    var buttonviewisDo:Bool=false
    
    
    let buttonkt:UIButton = UIButton(type:.System)
    
    
    @IBOutlet weak var seg: UISegmentedControl!
    
    
    
    var rik:KBean?
    var riView = KlineView()
    var rivdo:Bool=true
    
    var zhouk:KBean?
    var zhouView = KlineView()
    var zhouvdo:Bool=true
    
    var yuek:KBean?
    var yueView = KlineView()
    var yuevdo:Bool=true
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch seg.selectedSegmentIndex
        {
        case 0:
            
            
            riView.hidden = false
            zhouView.hidden = true
            yueView.hidden = true
            
            getRiKData()
            
        case 1:
            
            
            riView.hidden = true
            zhouView.hidden = false
            yueView.hidden = true
            getZhouKData()
        case 2:
            
            
            riView.hidden = true
            zhouView.hidden = true
            yueView.hidden = false
            getYueKData()
            
            
        default:
            break;
        }
    }
    
    
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
    var page4 = UIView()
    var page5 = UIView()
    
    var pages = UIView()
    
    //文字
    var gpAndSymbol = UILabel()
    var gpname = UILabel()
    var gpsymbol = UILabel()
    var price = UILabel()
    var upDownMoney = UILabel()
    var upDownPer = UILabel()
    static var s3 = UILabel()
    var s4 = UILabel()
    var s5 = UILabel()
    var s6 = UILabel()
    var s7 = UILabel()
    var s8 = UILabel()
    var s9 = UILabel()
    var s10 = UILabel()
    var s11 = UILabel()
    var s12 = UILabel()
    var s13 = UILabel()
    var s14 = UILabel()
    var s15 = UILabel()
    
    var ma = UILabel()
    var ma5 = UILabel()
    var ma10 = UILabel()
    var ma20 = UILabel()
    
    static var todayOpen = UILabel()
    var high = UILabel()
    var dealNum = UILabel()
    var changeHandPer = UILabel()
    var low = UILabel()
    var dealMoney = UILabel()
    var dealaaa=1
    
    static var cjlview = dealnumview()
    
    var searchCode:[String]?
    
    var gupiaonew:GPBean=GPBean()
    
    var name:String?
    var symbol:String?
    var code:String?
    
    var pagess = UIView()
    func setViewProtrol(){
        riView.setChangeTop(self)
        zhouView.setChangeTop(self)
        yueView.setChangeTop(self)
    }
    
    func settoSVC() {
        riView.setJump(self)
        zhouView.setJump(self)
        yueView.setJump(self)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        buttonview.setChange(self)
        //12.12 调用协议
        settoSVC()
        getCode()
        g2.isDo=true
        
        self.view.backgroundColor = bule1
        
        
        self.riView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        self.zhouView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        self.yueView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        
        
        
        setButton()
        setHengtiao()
        setGP()
        
        
        gpAndSymbol.text = name!+"("+symbol!+")"
        gpname.text = name
        gpsymbol.text = symbol
        
        riView.hidden = false
        zhouView.hidden = true
        yueView.hidden = true
        getDetail()
        getRiKData()
        
        
        g2.scviewlrgo = NSTimer.scheduledTimerWithTimeInterval(0.2,target:self,selector:#selector(g2.btscviewlrgo),userInfo:nil,repeats:true)
        g2.g2timer = NSTimer.scheduledTimerWithTimeInterval(2,target:self,selector:#selector(g2.tickDown),userInfo:nil,repeats:true)
        g2.g2timeraddsub = NSTimer.scheduledTimerWithTimeInterval(0.5,target:self,selector:#selector(g2.ticktimeraddsub),userInfo:nil,repeats:true)
        

        
        
        
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
                        self.upDownMoney.text=self.gupiaonew._27updown!
                        self.upDownPer.text=self.gupiaonew._29updownpercent!+"%"
                        //                        self.upDownMoney.textColor = self.greed1
                        //                        self.upDownPer.textColor = self.greed1
                        self.pages.backgroundColor = self.greed2
                    }
                    else{
                        self.price.textColor = self.red1
                        self.upDownMoney.text="+"+self.gupiaonew._27updown!
                        self.upDownPer.text="+"+self.gupiaonew._29updownpercent!+"%"
                        //                        self.upDownMoney.textColor = self.red1
                        //                        self.upDownPer.textColor = self.red1
                        self.pages.backgroundColor = self.red2
                    }
                    
                    if todayopeno < yest0{
                        g2.todayOpen.textColor = self.greed1
                    }
                    else {
                        g2.todayOpen.textColor = self.red1
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
                    g2.todayOpen.text=self.gupiaonew._28todayopen
                    
                    
                    
                    g2.cjlview.cjl=GloMethod.changeStrToShou(self.gupiaonew._31sumhand!)
                    g2.cjlview.cje=self.gupiaonew._35dealmoney!
                    
                    
                    
//                    self.pages.frame = CGRectMake(-10,120, UIScreen.mainScreen().bounds.width/2 , 30)
//                    self.pages.layer.masksToBounds = true
//                    self.pages.layer.cornerRadius = 10
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.high.setNeedsDisplay()
                        self.low.setNeedsDisplay()
                        self.changeHandPer.setNeedsDisplay()
                        self.price.setNeedsDisplay()
                        self.upDownMoney.setNeedsDisplay()
                        self.upDownPer.setNeedsDisplay()
                        g2.todayOpen.setNeedsDisplay()
                        self.dealNum.setNeedsDisplay()
                        self.dealMoney.setNeedsDisplay()
                        
                        self.view.addSubview(self.pages)
                        self.view.insertSubview(self.pages, aboveSubview: self.page2)
                        g2.cjlview.setNeedsDisplay()
                        
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
        
        
        
        buttonback.frame=CGRectMake(8, 28, 40, 40)
        buttonback.setBackgroundImage(UIImage(named:"backs100"),forState:.Normal)
        self.view.addSubview(buttonback);
        buttonback.addTarget(self,action:#selector(tapped),forControlEvents:.TouchUpInside)
        
        
        
        buttonsearch.frame=CGRectMake(UIScreen.mainScreen().bounds.width - 50, 28, 40, 40)
        buttonsearch.setBackgroundImage(UIImage(named:"searchs100"),forState:.Normal)
        self.view.addSubview(buttonsearch);
        buttonsearch.addTarget(self,action:#selector(searchbt),forControlEvents:.TouchUpInside)
        
        
        buttonleftgo.frame=CGRectMake(UIScreen.mainScreen().bounds.width/2 - 80, 28, 40, 40)
        buttonleftgo.setBackgroundImage(UIImage(named:"lefts100"),forState:.Normal)
        buttonleftgo.addTarget(self,action:#selector(btleftgo),forControlEvents:.TouchUpInside)
        
        buttonrightgo.frame=CGRectMake(UIScreen.mainScreen().bounds.width/2 + 40, 28, 40, 40)
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
        
        
        
        buttonmacd.frame=CGRectMake(UIScreen.mainScreen().bounds.width - 160, UIScreen.mainScreen().bounds.height - 38, 80, 29)
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
        
        buttonzhibiao.frame=CGRectMake(UIScreen.mainScreen().bounds.width - 80, UIScreen.mainScreen().bounds.height - 38, 80, 29)
        buttonzhibiao.setTitleColor(UIColor.grayColor() , forState: UIControlState.Normal)
        buttonzhibiao.setTitle("K线设置", forState:UIControlState.Normal)
        buttonzhibiao.titleLabel?.font = UIFont.systemFontOfSize(12)
        buttonzhibiao.titleLabel?.textAlignment = NSTextAlignment.Center
        buttonzhibiao.tintColor = UIColor.grayColor()
        buttonzhibiao.addTarget(self,action:#selector(buttonKlineSet(_:)),forControlEvents:.TouchUpInside)
        self.view.addSubview(buttonzhibiao);
        
        
        
        
        
        
        buttonaddsub.frame=CGRectMake(UIScreen.mainScreen().bounds.width-100, 120, 100, 30)
        buttonaddsubpic.frame=CGRectMake(UIScreen.mainScreen().bounds.width-70, 80, 40, 40)
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
        self.view.addSubview(buttonaddsub);
        buttonaddsubpic.addTarget(self,action:#selector(addordelete(_:)),forControlEvents:.TouchUpInside)
        self.view.addSubview(buttonaddsubpic);
    }
    func setHengtiao(){
        //横条设置
        page1.backgroundColor = red1
        page1.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.width , 70)
        self.view.addSubview(page1)
        self.view.sendSubviewToBack(page1)
        
        page2.backgroundColor = bule1
        page2.frame = CGRectMake(0,70, UIScreen.mainScreen().bounds.width , 80)
        self.view.addSubview(page2)
        self.view.sendSubviewToBack(page2)
        
        page3.backgroundColor = gray1
        page3.frame = CGRectMake(0,150, UIScreen.mainScreen().bounds.width , 60)
        self.view.addSubview(page3)
        
        g2.cjlview.cjl="-"
        g2.cjlview.cje="-"
        g2.cjlview.backgroundColor = UIColor.clearColor()
        g2.cjlview.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/6 + 30, 150, UIScreen.mainScreen().bounds.width*2/6 - 30 , 60)
        self.view.addSubview(g2.cjlview)
        
        
        page5.backgroundColor = gray1
        page5.frame = CGRectMake(0,UIScreen.mainScreen().bounds.height - 50, UIScreen.mainScreen().bounds.width , 50)
        self.view.addSubview(page5)
        self.view.sendSubviewToBack(page5)
        
        self.pages.frame = CGRectMake(-10,120, UIScreen.mainScreen().bounds.width/2 , 30)
        self.pages.layer.masksToBounds = true
        self.pages.layer.cornerRadius = 10
        
        
        pagess.backgroundColor = bule1
        pagess.frame = CGRectMake(-10,120, 10 , 30)
        self.view.addSubview(pagess)
        
        seg.tintColor = UIColor.grayColor()
        seg.layer.masksToBounds = true
        seg.layer.borderColor = UIColor.grayColor().CGColor
        seg.layer.borderWidth = 1
        seg.layer.cornerRadius = 15
        
        
    }
    
    
    func setGP(){
        
        
        gpname.frame = CGRectMake(0, 25, UIScreen.mainScreen().bounds.width, 30)
        gpname.text = "浦发银行"
        gpname.textColor = UIColor.whiteColor()
        gpname.font = UIFont.systemFontOfSize(18)
        gpname.textAlignment=NSTextAlignment.Center
        self.view.addSubview(gpname)
        
        gpsymbol.frame = CGRectMake(0, 44, UIScreen.mainScreen().bounds.width, 30)
        gpsymbol.text = "600000"
        gpsymbol.textColor = UIColor.whiteColor()
        gpsymbol.font = UIFont.systemFontOfSize(12)
        gpsymbol.textAlignment=NSTextAlignment.Center
        self.view.addSubview(gpsymbol)
        
        
        price.frame = CGRectMake(30, 80, UIScreen.mainScreen().bounds.width, 30)
        price.text = "-.-"
        price.textColor = UIColor.whiteColor()
        price.font =  UIFont.systemFontOfSize(36)
        price.textAlignment=NSTextAlignment.Left
        self.view.addSubview(price)
        
        upDownMoney.frame = CGRectMake(20, 120, UIScreen.mainScreen().bounds.width/4, 30)
        upDownMoney.text = "-.-"
        upDownMoney.textColor = UIColor.whiteColor()
        upDownMoney.font =  UIFont.systemFontOfSize(12)
        upDownMoney.textAlignment=NSTextAlignment.Left
        self.view.addSubview(upDownMoney)
        
        upDownPer.frame = CGRectMake(UIScreen.mainScreen().bounds.width/4 - 30, 120, UIScreen.mainScreen().bounds.width/4, 30)
        upDownPer.text = "-.-%"
        upDownPer.textColor = UIColor.whiteColor()
        upDownPer.font =  UIFont.systemFontOfSize(12)
        upDownPer.textAlignment=NSTextAlignment.Right
        self.view.addSubview(upDownPer)
        
        
        
        g2.s3.frame = CGRectMake(0, 150, UIScreen.mainScreen().bounds.width/6, 30)
        g2.s3.text = "今开:   "
        g2.s3.textColor = UIColor.whiteColor()
        g2.s3.font = UIFont.systemFontOfSize(12)
        g2.s3.textAlignment=NSTextAlignment.Center
        self.view.addSubview(g2.s3)
        
        g2.todayOpen.frame = CGRectMake(UIScreen.mainScreen().bounds.width/6 - 10, 150, UIScreen.mainScreen().bounds.width/6, 30)
        g2.todayOpen.text = "-"
        g2.todayOpen.textColor = UIColor.whiteColor()
        g2.todayOpen.font = UIFont.systemFontOfSize(12)
        g2.todayOpen.adjustsFontSizeToFitWidth=true
        g2.todayOpen.minimumScaleFactor=0.6
        g2.todayOpen.textAlignment=NSTextAlignment.Center
        self.view.addSubview(g2.todayOpen)
        
        s4.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3 - 10, 150, UIScreen.mainScreen().bounds.width/6, 30)
        s4.text = "最高:   "
        s4.textColor = UIColor.whiteColor()
        s4.font = UIFont.systemFontOfSize(12)
        s4.textAlignment=NSTextAlignment.Center
        self.view.addSubview(s4)
        
        high.frame = CGRectMake(UIScreen.mainScreen().bounds.width*1/2 - 20, 150, UIScreen.mainScreen().bounds.width/6, 30)
        high.text = "-"
        high.textColor = UIColor.whiteColor()
        high.font = UIFont.systemFontOfSize(12)
        high.adjustsFontSizeToFitWidth=true
        high.minimumScaleFactor=0.6
        high.textAlignment=NSTextAlignment.Center
        self.view.addSubview(high)
        
        s5.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 - 20, 150, UIScreen.mainScreen().bounds.width/6, 30)
        s5.text = "成交量:    "
        s5.textColor = UIColor.whiteColor()
        s5.font = UIFont.systemFontOfSize(12)
        s5.textAlignment=NSTextAlignment.Center
        self.view.addSubview(s5)
        
        
        
        s6.frame = CGRectMake(0, 180, UIScreen.mainScreen().bounds.width/6, 30)
        s6.text = "换手率:   "
        s6.textColor = UIColor.whiteColor()
        s6.font = UIFont.systemFontOfSize(12)
        s6.textAlignment=NSTextAlignment.Center
        self.view.addSubview(s6)
        
        changeHandPer.frame = CGRectMake(UIScreen.mainScreen().bounds.width/6 - 10, 180, UIScreen.mainScreen().bounds.width/6, 30)
        changeHandPer.text = "-"
        changeHandPer.textColor = UIColor.whiteColor()
        changeHandPer.font = UIFont.systemFontOfSize(12)
        changeHandPer.adjustsFontSizeToFitWidth=true
        changeHandPer.minimumScaleFactor=0.6
        changeHandPer.textAlignment=NSTextAlignment.Center
        self.view.addSubview(changeHandPer)
        
        s7.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3 - 10, 180, UIScreen.mainScreen().bounds.width/6, 30)
        s7.text = "最低:   "
        s7.textColor = UIColor.whiteColor()
        s7.font = UIFont.systemFontOfSize(12)
        s7.textAlignment=NSTextAlignment.Center
        self.view.addSubview(s7)
        
        low.frame = CGRectMake(UIScreen.mainScreen().bounds.width*1/2 - 20, 180, UIScreen.mainScreen().bounds.width/6, 30)
        low.text = "-"
        low.textColor = UIColor.whiteColor()
        low.font = UIFont.systemFontOfSize(12)
        low.adjustsFontSizeToFitWidth=true
        low.minimumScaleFactor=0.6
        low.textAlignment=NSTextAlignment.Center
        self.view.addSubview(low)
        
        
        s8.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 - 20, 180, UIScreen.mainScreen().bounds.width/6, 30)
        s8.text = "成交额:    "
        s8.textColor = UIColor.whiteColor()
        s8.font = UIFont.systemFontOfSize(12)
        s8.textAlignment=NSTextAlignment.Center
        self.view.addSubview(s8)
        
    }
    
    
    //button方法
    
    //横屏页面左右跳转后页面刷新
    func btscviewlrgo(){
//        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        
        if screenViewController.scviewlrdo == true && screenViewController.scviewlrdo2 == true && (AppDelegate.delegate as! AppDelegate).listGP?.count > 0{
            
 
            var list:[ListBean]=(AppDelegate.delegate as! AppDelegate).listGP!


            var index:Int!
            for i in 0...list.count-1 {
                if symbol==list[i].symbol {
                    index=i
                    break
                }
            }
            
            let bean=list[index]

            (AppDelegate.delegate as! AppDelegate).searchcode = nil
            (AppDelegate.delegate as! AppDelegate).searchcode = [bean.name!,bean.symbol!,bean.code!]
            
//            let bean = (AppDelegate.delegate as! AppDelegate).searchcode
//            (AppDelegate.delegate as! AppDelegate).searchcode = nil
//            (AppDelegate.delegate as! AppDelegate).searchcode = bean
            getCode()
            g2.g2code = nil//本身的刷新
            g2.g2code = searchCode![2]
            g2.g2codego = true//g1的刷新
            
//            print(g2.g2code)
            
            
            
            
            self.riView.removeFromSuperview()
            self.zhouView.removeFromSuperview()
            self.yueView.removeFromSuperview()
            rivdo=riView.hidden
            zhouvdo=zhouView.hidden
            yuevdo=yueView.hidden
            riView = KlineView()
            zhouView = KlineView()
            yueView = KlineView()
            self.riView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
            self.zhouView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
            self.yueView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
            riView.hidden=rivdo
            zhouView.hidden=zhouvdo
            yueView.hidden=yuevdo
            //        setViewProtrol()
            settoSVC()
            setButton()
            setHengtiao()
            setGP()
            
            
            
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
            
            screenViewController.scviewlrdo = false
            screenViewController.scviewlrdo2 = false
        }
        
        
    }
    
    func tapped(){
        code = nil
        screenViewController.scviewlrdo = false
        (AppDelegate.delegate as! AppDelegate).listGP? = []
        g1.g1doSVC = false
        g1.isDo = false
        g1.isDog1 = false
        g1.ssdo = false
        g1.g1codego = false
        g2.g2doSVC = false
        g2.isDo = false
        g2.isDog2 = false
        
        
        
        c1.listdo=false
        c2.listdo=false
        g1.g1code = nil
        g2.g2code = nil
        g1.g1timer.invalidate()
        g1.g1timeraddsub.invalidate()
        g2.g2timer.invalidate()
        g2.g2timeraddsub.invalidate()
        
        if c1.isDoc1{
            c1.isDo=true
            c1.isDoc1=false
            g1.isDo=false
            g2.isDo=false
            self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
        }else if c2.isDoc2{
            c2.isDo=true
            c2.isDoc2=false
            g1.isDo=false
            g2.isDo=false
            self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
        }else{
            g1.isDo=false
            g2.isDo=false
            c1.isDo=true
            c2.isDo=true
            self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
        }
        
        g2.g2timer.invalidate()
        g2.g2timeraddsub.invalidate()
        g2.scviewlrgo.invalidate()
    }
    
    
    func searchbt(){
        
        g1.isDo=false
        g2.isDo=false
        g2.isDog2=true
        c1.isDoc1=false
        c2.isDoc2=false
        self.presentViewController(searchvc, animated: false, completion: nil)
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
            
            self.buttonview.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - 80, UIScreen.mainScreen().bounds.width, 30)
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
    
    func buttonKlineSet(button:UIButton){
        self.presentViewController(KlineSetvc, animated: false, completion: nil)
        
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
        
        
        
        g2.g2doSVC = true
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
        
        
        
        
        self.riView.removeFromSuperview()
        self.zhouView.removeFromSuperview()
        self.yueView.removeFromSuperview()
        rivdo=riView.hidden
        zhouvdo=zhouView.hidden
        yuevdo=yueView.hidden
        riView = KlineView()
        zhouView = KlineView()
        yueView = KlineView()
        self.riView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        self.zhouView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        self.yueView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        riView.hidden=rivdo
        zhouView.hidden=zhouvdo
        yueView.hidden=yuevdo
        //        setViewProtrol()
        settoSVC()
        setButton()
        setHengtiao()
        setGP()
        
        
        
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
        
 
    }
    
    
    func btrightgo(){
        g2.g2doSVC = true
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
        
        
        
        
        self.riView.removeFromSuperview()
        self.zhouView.removeFromSuperview()
        self.yueView.removeFromSuperview()
        rivdo=riView.hidden
        zhouvdo=zhouView.hidden
        yuevdo=yueView.hidden
        riView = KlineView()
        zhouView = KlineView()
        yueView = KlineView()
        self.riView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        self.zhouView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        self.yueView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
        riView.hidden=rivdo
        zhouView.hidden=zhouvdo
        yueView.hidden=yuevdo
        //        setViewProtrol()
        settoSVC()
        setButton()
        setHengtiao()
        setGP()
        
        
        
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
        
        
        if g1.g1code != nil{
            //            if code != g1.g1code{
            if g1.g1codego{
                
                
                g1.g1codego = false
                
                var list:[ListBean]=(AppDelegate.delegate as! AppDelegate).listGP!
                var index:Int!
                for i in 0...list.count-1 {
                    if g1.g1code==list[i].code {
                        index=i
                        break
                    }
                }
                
                
                let bean=list[index]
                
                (AppDelegate.delegate as! AppDelegate).searchcode = [bean.name!,bean.symbol!,bean.code!]
                
                getCode()
                
                
                
                
                self.riView.removeFromSuperview()
                self.zhouView.removeFromSuperview()
                self.yueView.removeFromSuperview()
                rivdo=riView.hidden
                zhouvdo=zhouView.hidden
                yuevdo=yueView.hidden
                riView = KlineView()
                zhouView = KlineView()
                yueView = KlineView()
                self.riView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
                self.zhouView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
                self.yueView.frame = CGRectMake(5,210, UIScreen.mainScreen().bounds.width-10 , UIScreen.mainScreen().bounds.height - 260)
                riView.hidden=rivdo
                zhouView.hidden=zhouvdo
                yueView.hidden=yuevdo
                
                
                setButton()
                setHengtiao()
                setGP()
                
                
                
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
                
            }
            //            }
        }
        
    }
    
    
    func tickDown()
    {
        
        
       
        settoSVC()
        setViewProtrol()
        if g2.isDo {
            
            
            getDetail()
            if g2.g2code != nil{
            }
            
            
        }
        
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
