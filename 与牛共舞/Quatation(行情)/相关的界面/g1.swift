
//
//  g1.swift
//  dancewithcow
//
//  Created by 章如强 on 16/5/10.
//  Copyright © 2016年 章如强. All rights reserved.
//

import UIKit
import SwiftHTTP

class g1: UIViewController ,Chage{
    func chage() {
        searchss()
    }
    
    static var g1doSVC:Bool=false
    static var g1timer:NSTimer!
    static var g1timeraddsub:NSTimer!
    static var isDo:Bool=true
    static var isDog1:Bool=false
    
    var cjldo:Bool=true
    var ktdo:Bool=true
    
    var searchvc = searchViewController()
    let buttonaddsub:UIButton = UIButton(type:.System)
    let buttonaddsubpic:UIButton = UIButton(type:.System)
    
    
    let buttonback:UIButton = UIButton(type:.System)
    let buttonsearch:UIButton = UIButton(type:.System)
    
    

    let buttonss:UIButton = UIButton(type:.System)
    static var ssdo:Bool=true
    let buttonleftgo:UIButton = UIButton(type:.System)
    let buttonrightgo:UIButton = UIButton(type:.System)
    static var g1code:String!
    static var g1codego:Bool=false
    
    
    var buttonkt:UIButton = UIButton(type:.System)
    
    var buySellTextSize=CGFloat(10)
    
    
    //颜色
    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
    var red2=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 0.5)
    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
    var bule1=UIColor(red: 19/255, green: 20/255, blue: 29/255, alpha: 1)
    var gray1=UIColor(red: 26/255, green: 25/255, blue: 32/255, alpha: 1)
    var greed2=UIColor(red: 17/255, green: 124/255, blue: 3/255, alpha: 1)
    var colorrg = Int()
    
    //背景模块
    var page1 = UIView()
    var page2 = UIView()
    var page3 = UIView()
    var page4 = UIView()
    var page5 = UIView()
    
    var pages = UIView()
    
    
    var fiveline = UIView()
    var fiveline2 = UIView()
    
    //文字
    var gpAndSymbol = UILabel()
    var gpname = UILabel()
    var gpsymbol = UILabel()
    var price = UILabel()
    var upDownMoney = UILabel()
    var upDownPer = UILabel()
    var s3 = UILabel()
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
    
    
    var xw1 = UILabel()
    var gg1 = UILabel()
    var yb1 = UILabel()
    
    
    var bs5d = UILabel()
    var bspr = UILabel()
    var bsm = UILabel()
    
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
    
    
    
    
    
    
    var todayOpen = UILabel()
    var high = UILabel()
    var changeHandPer = UILabel()
    var low = UILabel()

    

    var cjlnum = UILabel()
    var cjlnumchinese = UILabel()
    var cjlmoney = UILabel()
    var cjlaaa:Int=1
    var cjlview = dealnumview()
    
    
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
    
    
    
    var searchCode:[String]?
    
    
    var gupiaonew:GPBean=GPBean()
    
    var name:String?
    var symbol:String?
    var code:String?
    
    var fenshi:FenshiBean?
    let timeView = TimeLine()
    

    
    
    var pagess = UIView()
    

    
    var isShow:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCode()
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
        
        g1.isDo=true
        
        self.view.backgroundColor = bule1
        
        
        setButton()
        setHengtiao()
        setBuySell()
        setGP()
        
        
        gpAndSymbol.text = name!+"("+symbol!+")"
        gpname.text = name
        gpsymbol.text = symbol
        
        getDetail()
        

        
        
        

        if code == "0000001" {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
        }
        else if code == "1399006" {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
        }
        else if code == "1399001" {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
        }
            
        else {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width*2/3 , UIScreen.mainScreen().bounds.height - 260)
        }
        
        getFenshiData()
        
        

        g1.g1timer = NSTimer.scheduledTimerWithTimeInterval(2,target:self,selector:#selector(g1.tickDown),userInfo:nil,repeats:true)
        g1.g1timeraddsub = NSTimer.scheduledTimerWithTimeInterval(0.5,target:self,selector:#selector(g1.ticktimeraddsub),userInfo:nil,repeats:true)
        
        
        // Do any additional setup after loading the view.
    }
    
    func getCode(){

        searchCode=(AppDelegate.delegate as! AppDelegate).searchcode
        if searchCode != nil {
            name = searchCode![0]
            symbol = searchCode![1]
            code = searchCode![2]
            gpAndSymbol.text = name!+"("+symbol!+")"
//             (AppDelegate.delegate as! AppDelegate).searchcode = nil
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
        if g2.g2timer != nil{
        g2.g2timer.invalidate()
        g2.g2timeraddsub.invalidate()
        }
        
        if c1.isDoc1{
            c1.isDo=true
            c1.isDoc1=false
            g1.isDo=false
            g2.isDo=false
            self.dismissViewControllerAnimated(false, completion:nil)
        }else if c2.isDoc2{
            c2.isDo=true
            c2.isDoc2=false
            g1.isDo=false
            g2.isDo=false
            self.dismissViewControllerAnimated(false, completion:nil)
        }else{
            g1.isDo=false
            g2.isDo=false
            c1.isDo=true
            c2.isDo=true
            self.dismissViewControllerAnimated(false, completion:nil)
        }

        g1.g1timer.invalidate()
        g1.g1timeraddsub.invalidate()
    }
    
    func searchbt(){
        g1.isDo=false
        g2.isDo=false
        g1.isDog1=true
        c1.isDoc1=false
        c2.isDoc2=false
        self.presentViewController(searchvc, animated: false, completion: nil)
    }
    
    func searchss(){
        if g1.ssdo{
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
            g1.ssdo=false
        }else{
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width*2/3 , UIScreen.mainScreen().bounds.height - 260)
            g1.ssdo=true
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                        
                        self.timeView.timeLineArray = fenshi2
                        self.timeView.setNeedsDisplay()
                        
                    })
                    
                }
                
            }
            
        }catch let error {
            print("请求失败: \(error)")
        }
        
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
//                        self.upDownMoney.textColor = self.red1
                        self.upDownMoney.text="+"+self.gupiaonew._27updown!
                        self.upDownPer.text="+"+self.gupiaonew._29updownpercent!+"%"
//                        self.upDownPer.textColor = self.red1
                        self.pages.backgroundColor = self.red2

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
                    self.todayOpen.text=self.gupiaonew._28todayopen

                    

                    self.cjlview.cjl=GloMethod.changeStrToShou(self.gupiaonew._31sumhand!)
                    self.cjlview.cje=self.gupiaonew._35dealmoney!
                    

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
                    

                    self.pages.frame = CGRectMake(-10,120, UIScreen.mainScreen().bounds.width/2 , 30)
                    self.pages.layer.masksToBounds = true
                    self.pages.layer.cornerRadius = 10

                    
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(),{
                       
                        self.high.setNeedsDisplay()
                        self.low.setNeedsDisplay()
                        self.changeHandPer.setNeedsDisplay()
                        self.price.setNeedsDisplay()
                        self.upDownMoney.setNeedsDisplay()
                        self.upDownPer.setNeedsDisplay()
                        self.todayOpen.setNeedsDisplay()
                        
                        
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
                        
                        self.view.addSubview(self.pages)
                        self.view.insertSubview(self.pages, aboveSubview: self.page2)
                        self.cjlview.setNeedsDisplay()

                    })
                }
            }
            
        }catch let error {
            print("请求失败: \(error)")
            
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
        
        cjlview.cjl="-"
        cjlview.cje="-"
        cjlview.backgroundColor = UIColor.clearColor()
        cjlview.frame = CGRectMake(UIScreen.mainScreen().bounds.width*4/6 + 30, 150, UIScreen.mainScreen().bounds.width*2/6 - 30 , 60)
        self.view.addSubview(cjlview)
        
        

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
    func addordelete(button:UIButton){
        let addgp:GupiaoBean=GupiaoBean ()
        addgp.name = name
        addgp.symbol = symbol
        addgp.code = code
        let title = button.currentTitle
        if title=="添加自选"{
            if GloMethod.isAdd(self.code!){
                return
                
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
    func setBuySell(){

        page4.backgroundColor = bule1
        page4.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3,210, UIScreen.mainScreen().bounds.width/3 , UIScreen.mainScreen().bounds.height - 260)
        self.view.addSubview(page4)
        
        page5.backgroundColor = gray1
        page5.frame = CGRectMake(0,UIScreen.mainScreen().bounds.height - 50, UIScreen.mainScreen().bounds.width , 50)
        self.view.addSubview(page5)
        

        
        pagess.backgroundColor = gray1
        pagess.frame = CGRectMake(-10,120, 10 , 30)
        self.view.addSubview(pagess)
        

        fiveline.backgroundColor = gray1
        fiveline.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 3,210 + (UIScreen.mainScreen().bounds.height - 260)*1/11, UIScreen.mainScreen().bounds.width/3 - 6 , 1)
        self.view.addSubview(fiveline)
        
        fiveline2.backgroundColor = gray1
        fiveline2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 3,210 + (UIScreen.mainScreen().bounds.height - 260)*6/11, UIScreen.mainScreen().bounds.width/3 - 6 , 1)
        self.view.addSubview(fiveline2)
        
        
        
        
        bspr.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9,210, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        bspr.text = "五档"
        bspr.textColor = UIColor.whiteColor()
        bspr.font = UIFont.systemFontOfSize(buySellTextSize)
        bspr.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(bspr)
        
        
        
        sell5.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*1/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell5.text = "卖5   "
        sell5.textColor = UIColor.whiteColor()
        sell5.font = UIFont.systemFontOfSize(buySellTextSize)
        sell5.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell5)
        
        sell4.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*2/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell4.text = "卖4   "
        sell4.textColor = UIColor.whiteColor()
        sell4.font = UIFont.systemFontOfSize(buySellTextSize)
        sell4.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell4)
        
        sell3.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*3/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell3.text = "卖3   "
        sell3.textColor = UIColor.whiteColor()
        sell3.font = UIFont.systemFontOfSize(buySellTextSize)
        sell3.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell3)
        
        sell2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*4/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell2.text = "卖2   "
        sell2.textColor = UIColor.whiteColor()
        sell2.font = UIFont.systemFontOfSize(buySellTextSize)
        sell2.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell2)
        
        sell1.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*5/11 , UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell1.text = "卖1  "
        sell1.textColor = UIColor.whiteColor()
        sell1.font = UIFont.systemFontOfSize(buySellTextSize)
        sell1.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell1)
        
        
        buy1.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*6/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy1.text = "买1   "
        buy1.textColor = UIColor.whiteColor()
        buy1.font = UIFont.systemFontOfSize(buySellTextSize)
        buy1.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy1)
        
        buy2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*7/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy2.text = "买2   "
        buy2.textColor = UIColor.whiteColor()
        buy2.font = UIFont.systemFontOfSize(buySellTextSize)
        buy2.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy2)
        
        buy3.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*8/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy3.text = "买3   "
        buy3.textColor = UIColor.whiteColor()
        buy3.font = UIFont.systemFontOfSize(buySellTextSize)
        buy3.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy3)
        
        buy4.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*9/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy4.text = "买4   "
        buy4.textColor = UIColor.whiteColor()
        buy4.font = UIFont.systemFontOfSize(buySellTextSize)
        buy4.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy4)
        
        buy5.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3 + 5,210 + (UIScreen.mainScreen().bounds.height - 260)*10/11 , UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy5.text = "买5   "
        buy5.textColor = UIColor.whiteColor()
        buy5.font = UIFont.systemFontOfSize(buySellTextSize)
        buy5.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy5)
        
        sell5price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9 ,210 + (UIScreen.mainScreen().bounds.height - 260)*1/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell5price.text = "－"
        sell5price.textColor = UIColor.whiteColor()
        sell5price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell5price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell5price)
        
        sell4price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9 ,210 + (UIScreen.mainScreen().bounds.height - 260)*2/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell4price.text = "－"
        sell4price.textColor = UIColor.whiteColor()
        sell4price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell4price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell4price)
        
        sell3price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9,210 + (UIScreen.mainScreen().bounds.height - 260)*3/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell3price.text = "－"
        sell3price.textColor = UIColor.whiteColor()
        sell3price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell3price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell3price)
        
        sell2price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9,210 + (UIScreen.mainScreen().bounds.height - 260)*4/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell2price.text = "－"
        sell2price.textColor = UIColor.whiteColor()
        sell2price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell2price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell2price)
        
        sell1price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9,210 + (UIScreen.mainScreen().bounds.height - 260)*5/11 , UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell1price.text = "－"
        sell1price.textColor = UIColor.whiteColor()
        sell1price.font = UIFont.systemFontOfSize(buySellTextSize)
        sell1price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell1price)
        
        
        buy1price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9,210 + (UIScreen.mainScreen().bounds.height - 260)*6/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy1price.text = "－"
        buy1price.textColor = UIColor.whiteColor()
        buy1price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy1price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy1price)
        
        buy2price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9,210 + (UIScreen.mainScreen().bounds.height - 260)*7/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy2price.text = "－"
        buy2price.textColor = UIColor.whiteColor()
        buy2price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy2price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy2price)
        
        buy3price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9,210 + (UIScreen.mainScreen().bounds.height - 260)*8/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy3price.text = "－"
        buy3price.textColor = UIColor.whiteColor()
        buy3price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy3price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy3price)
        
        buy4price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9,210 + (UIScreen.mainScreen().bounds.height - 260)*9/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy4price.text = "－"
        buy4price.textColor = UIColor.whiteColor()
        buy4price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy4price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy4price)
        
        buy5price.frame = CGRectMake(UIScreen.mainScreen().bounds.width*7/9,210 + (UIScreen.mainScreen().bounds.height - 260)*10/11 , UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy5price.text = "－"
        buy5price.textColor = UIColor.whiteColor()
        buy5price.font = UIFont.systemFontOfSize(buySellTextSize)
        buy5price.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy5price)
        
        
        sell5num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9 ,210 + (UIScreen.mainScreen().bounds.height - 260)*1/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell5num.text = "－"
        sell5num.textColor = UIColor.whiteColor()
        sell5num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell5num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell5num)
        
        sell4num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9,210 + (UIScreen.mainScreen().bounds.height - 260)*2/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell4num.text = "－"
        sell4num.textColor = UIColor.whiteColor()
        sell4num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell4num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell4num)
        
        sell3num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9,210 + (UIScreen.mainScreen().bounds.height - 260)*3/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell3num.text = "－"
        sell3num.textColor = UIColor.whiteColor()
        sell3num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell3num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell3num)
        
        sell2num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9,210 + (UIScreen.mainScreen().bounds.height - 260)*4/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell2num.text = "－"
        sell2num.textColor = UIColor.whiteColor()
        sell2num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell2num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell2num)
        
        sell1num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9,210 + (UIScreen.mainScreen().bounds.height - 260)*5/11 , UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        sell1num.text = "－"
        sell1num.textColor = UIColor.whiteColor()
        sell1num.font = UIFont.systemFontOfSize(buySellTextSize)
        sell1num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(sell1num)
        
        
        buy1num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9,210 + (UIScreen.mainScreen().bounds.height - 260)*6/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy1num.text = "－"
        buy1num.textColor = UIColor.whiteColor()
        buy1num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy1num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy1num)
        
        buy2num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9,210 + (UIScreen.mainScreen().bounds.height - 260)*7/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy2num.text = "－"
        buy2num.textColor = UIColor.whiteColor()
        buy2num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy2num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy2num)
        
        buy3num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9,210 + (UIScreen.mainScreen().bounds.height - 260)*8/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy3num.text = "－"
        buy3num.textColor = UIColor.whiteColor()
        buy3num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy3num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy3num)
        
        buy4num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9,210 + (UIScreen.mainScreen().bounds.height - 260)*9/11, UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy4num.text = "－"
        buy4num.textColor = UIColor.whiteColor()
        buy4num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy4num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy4num)
        
        buy5num.frame = CGRectMake(UIScreen.mainScreen().bounds.width*8/9,210 + (UIScreen.mainScreen().bounds.height - 260)*10/11 , UIScreen.mainScreen().bounds.width/3, (UIScreen.mainScreen().bounds.height - 260)/12)
        buy5num.text = "－"
        buy5num.textColor = UIColor.whiteColor()
        buy5num.font = UIFont.systemFontOfSize(buySellTextSize)
        buy5num.textAlignment=NSTextAlignment.Left //
        self.view.addSubview(buy5num)
        

        xw1.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - 50, UIScreen.mainScreen().bounds.width/3, 30)
        xw1.text = "新闻"
        xw1.textColor = UIColor.whiteColor()
        xw1.font = UIFont.systemFontOfSize(12)
        xw1.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(xw1)
        
        gg1.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, UIScreen.mainScreen().bounds.height - 50, UIScreen.mainScreen().bounds.width/3, 30)
        gg1.text = "公告"
        gg1.textColor = UIColor.whiteColor()
        gg1.font = UIFont.systemFontOfSize(12)
        gg1.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(gg1)
        
        yb1.frame = CGRectMake(UIScreen.mainScreen().bounds.width/1.5, UIScreen.mainScreen().bounds.height - 50, UIScreen.mainScreen().bounds.width/3, 30)
        yb1.text = "研报"
        yb1.textColor = UIColor.whiteColor()
        yb1.font = UIFont.systemFontOfSize(12)
        yb1.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(yb1)
        
        
    }
    func setGP(){

        
        gpname.frame = CGRectMake(0, 25, UIScreen.mainScreen().bounds.width, 30)
        gpname.text = "－－"
        gpname.textColor = UIColor.whiteColor()
        gpname.font = UIFont.systemFontOfSize(18)
        gpname.textAlignment=NSTextAlignment.Center
        self.view.addSubview(gpname)
        
        gpsymbol.frame = CGRectMake(0, 44, UIScreen.mainScreen().bounds.width, 30)
        gpsymbol.text = "－－"
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
        
        s3.frame = CGRectMake(0, 150, UIScreen.mainScreen().bounds.width/6, 30)
        s3.text = "今开:   "
        s3.textColor = UIColor.whiteColor()
        s3.font = UIFont.systemFontOfSize(12)
        s3.textAlignment=NSTextAlignment.Center
        self.view.addSubview(s3)
        
        todayOpen.frame = CGRectMake(UIScreen.mainScreen().bounds.width/6 - 10, 150, UIScreen.mainScreen().bounds.width/6, 30)
        todayOpen.text = "-"
        todayOpen.textColor = UIColor.whiteColor()
        todayOpen.font = UIFont.systemFontOfSize(12)
        todayOpen.adjustsFontSizeToFitWidth=true
        todayOpen.minimumScaleFactor=0.6
        todayOpen.textAlignment=NSTextAlignment.Center
        self.view.addSubview(todayOpen)
        
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
    
    func btleftgo(){
        
        g1.g1codego = true
        g1.g1doSVC = true
        
        let list:[ListBean]=(AppDelegate.delegate as! AppDelegate).listGP!
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
        g1.g1code = nil
        g1.g1code = searchCode![2]


       
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
        setBuySell()
        setGP()

        
        gpAndSymbol.text = name!+"("+symbol!+")"
        gpname.text = name
        gpsymbol.text = symbol
        
        getDetail()
        
        
        
        
        

        if code == "0000001" {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
        }
        else if code == "1399006" {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
        }
        else if code == "1399001" {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
        }
            
        else {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width*2/3 , UIScreen.mainScreen().bounds.height - 260)
        }
        
        getFenshiData()
        timeView.displayXline.backgroundColor = UIColor.clearColor()
        timeView.displayYline.backgroundColor = UIColor.clearColor()
        timeView.djlabel.textColor = UIColor.clearColor()
        timeView.djprice.textColor = UIColor.clearColor()
        timeView.cjlprcStr.textColor = UIColor.clearColor()
        
    }
    
    
    func btrightgo(){

        g1.g1codego = true
        g1.g1doSVC = true
        
        
        let list:[ListBean]=(AppDelegate.delegate as! AppDelegate).listGP!
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
        g1.g1code = nil
        g1.g1code = searchCode![2]

        
        
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
        //        g1.isDo=true
        //
        //        self.view.backgroundColor = bule1
        //
        //
        setButton()
        setHengtiao()
        setBuySell()
        setGP()
        //
        
        gpAndSymbol.text = name!+"("+symbol!+")"
        gpname.text = name
        gpsymbol.text = symbol
        
        getDetail()
        
        
        
        

        if code == "0000001" {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
        }
        else if code == "1399006" {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
        }
        else if code == "1399001" {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
        }
            
        else {
            timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width*2/3 , UIScreen.mainScreen().bounds.height - 260)
        }
        
        getFenshiData()
        timeView.displayXline.backgroundColor = UIColor.clearColor()
        timeView.displayYline.backgroundColor = UIColor.clearColor()
        timeView.djlabel.textColor = UIColor.clearColor()
        timeView.djprice.textColor = UIColor.clearColor()
        timeView.cjlprcStr.textColor = UIColor.clearColor()
        
    }
    
    func ticktimeraddsub()
    {

        if g2.g2code != nil{
//            if name != g2.g2code{
                if g2.g2codego{

                    g2.g2codego = false
                    
                    let list:[ListBean]=(AppDelegate.delegate as! AppDelegate).listGP!
                    var index:Int!
                    for i in 0...list.count-1 {
                        if list[i].code == g2.g2code {
                            index=i
                            break
                        }
                    }
                    
                    
                    let bean=list[index]
                    
                    (AppDelegate.delegate as! AppDelegate).searchcode = nil
                    (AppDelegate.delegate as! AppDelegate).searchcode = [bean.name!,bean.symbol!,bean.code!]
                    
                    getCode()
                    
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
                    //        g1.isDo=true
                    //
                    //        self.view.backgroundColor = bule1
                    //
                    //
                    setButton()
                    setHengtiao()
                    setBuySell()
                    setGP()
                    //
                    
                    gpAndSymbol.text = name!+"("+symbol!+")"
                    gpname.text = name
                    gpsymbol.text = symbol
                    
                    getDetail()
                    
                   
                    
                    
                    
                    

                    if code == "0000001" {
                        timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
                    }
                    else if code == "1399006" {
                        timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
                    }
                    else if code == "1399001" {
                        timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height - 260)
                    }
                        
                    else {
                        timeView.frame = CGRectMake(0,210, UIScreen.mainScreen().bounds.width*2/3 , UIScreen.mainScreen().bounds.height - 260)
                    }
                    
                    getFenshiData()
                    timeView.displayXline.backgroundColor = UIColor.clearColor()
                    timeView.displayYline.backgroundColor = UIColor.clearColor()
                    timeView.djlabel.textColor = UIColor.clearColor()
                    timeView.djprice.textColor = UIColor.clearColor()
                    timeView.cjlprcStr.textColor = UIColor.clearColor()
                    
                }
//            }
        }
    }
    
    
    
    func tickDown()
    {
        if g1.isDo {
            



            if self.ktdo{
            getDetail()

            getFenshiData1()
                if g1.g1code != nil{
                }
            }

        }
        
    }

    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
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
