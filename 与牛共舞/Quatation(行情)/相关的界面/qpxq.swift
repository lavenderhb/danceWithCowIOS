//
//  qpxq.swift
//  two
//
//  Created by 雷伊潇 on 16/5/7.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit
import SwiftHTTP



class qpxq: UIViewController {
    var itemString:[String]?
    
    var gupiaonew:GPBean=GPBean()
    
    
    var name:String?
    var symbol:String?
    var code:String?
    
    var fenshi:FenshiBean?
    let timeView = TimeLine()
    
    var rik:KBean?
    let rikView = KlineView()
    
    var zhouk:KBean?
    let zhoukView = KlineView()
    
    var yuek:KBean?
    let yuekView = KlineView()
    
    
    @IBOutlet weak var sell5: UILabel!
    @IBOutlet weak var sell4: UILabel!
    @IBOutlet weak var sell3: UILabel!
    @IBOutlet weak var sell2: UILabel!
    @IBOutlet weak var sell1: UILabel!
    @IBOutlet weak var sell5num: UILabel!
    @IBOutlet weak var sell4num: UILabel!
    @IBOutlet weak var sell3num: UILabel!
    @IBOutlet weak var sell2num: UILabel!
    @IBOutlet weak var sell1num: UILabel!
    
    @IBOutlet weak var buy1: UILabel!
    @IBOutlet weak var buy2: UILabel!
    @IBOutlet weak var buy3: UILabel!
    @IBOutlet weak var buy4: UILabel!
    @IBOutlet weak var buy5: UILabel!
    @IBOutlet weak var buy1num: UILabel!
    @IBOutlet weak var buy2num: UILabel!
    @IBOutlet weak var buy3num: UILabel!
    @IBOutlet weak var buy4num: UILabel!
    @IBOutlet weak var buy5num: UILabel!
    
    
    
    
    @IBOutlet weak var backtolast: UIButton!
    @IBOutlet weak var btnAddOrDelete: UIButton!
    
    
    
    @IBAction func addOrdelete(sender: AnyObject) {
        
        
        let addgp:GupiaoBean=GupiaoBean ()
        addgp.name = itemString![0]
        addgp.symbol = itemString![1]
        addgp.code = itemString![2]
        
        if GloMethod.isAdd(self.code!) {
            
            GloMethod.deleteGupiaoBean(self.code!)
            btnAddOrDelete.setBackgroundImage(UIImage(named: "add"), forState: UIControlState.Normal)
        }
        else {
            GloMethod.insertGupiaoBean(addgp)
            btnAddOrDelete.setBackgroundImage(UIImage(named: "扩大行情"), forState: UIControlState.Normal)
        }
        
        
        
    }
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var updown: UILabel!
    
    @IBOutlet weak var todayOpen: UILabel!
    
    @IBOutlet weak var yestClose: UILabel!
    
    @IBOutlet weak var dealNum: UILabel!
    
    
    @IBOutlet weak var dealMoney: UILabel!
    
    
    
    
    @IBAction func back(segue: UIStoryboardSegue) {
        //self.dismissViewControllerAnimated(true, completion:nil)//关闭当前页面
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)//返回上一页面
        
    }
    @IBOutlet weak var dm: UILabel!//标题栏
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fourview: UIView!
    
    var cssj1:[String]?
    
    var height:CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor =
            UIColor.redColor()
        //        self.navigationController?.navigationBar.setBackgr(UIImage(named: "bg5"), forBarMetrics: .Default)
        height = self.view.frame.size.height-self.segmentedControl.frame.size.height-self.segmentedControl.frame.maxY
        
        //        segmentedControl.tintColor=UIColor.redColor()
        
        //搜索页面进入
        cssj1=(AppDelegate.delegate as! AppDelegate).searchcode
        if cssj1 != nil {
            itemString = cssj1
            (AppDelegate.delegate as! AppDelegate).searchcode = nil
            
        }
        name = itemString![0]
        symbol = itemString![1]
        code = itemString![2]
        dm.text = name!+"("+symbol!+")"
        
        
        
        //判断添加按钮
        if GloMethod.isAdd(self.code!) {
            btnAddOrDelete.setBackgroundImage(UIImage(named: "返回行情"), forState: UIControlState.Normal)
        }
        else {
            btnAddOrDelete.setBackgroundImage(UIImage(named: "add"), forState: UIControlState.Normal)
        }
        
        
        
        backtolast.setBackgroundImage(UIImage(named: "扩大行情"), forState: UIControlState.Normal)
        
        getDetail()
        
        firstView.hidden = false
        secondView.hidden = true
        threeView.hidden = true
        fourview.hidden = true
        
        //        self.timeView.frame = CGRect(x: 0, y: 0, width: firstView.frame.size.width , height: secondView.frame.size.height )
        if code == "0000001" {
            timeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: height!) // 分时整图
        }
        else if code == "1399006" {
            timeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: height!) // 分时整图
        }
        else if code == "1399001" {
            timeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: height!) // 分时整图
        }
            
        else {
            timeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: height!*0.6) // 分时整图
        }
        
        getFenshiData()
    }
    
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
                    
                    let bjxj = Double(self.gupiaonew._25price!)// 现价文本颜色
                    let bjkj = Double(self.gupiaonew._28todayopen!)
                    let bjsj = Double(self.gupiaonew._34yestclose!)
                    if bjxj < bjsj{
                        self.price.textColor = UIColor.greenColor()
                        self.updown.textColor = UIColor.greenColor()
                    }
                    else{
                        self.price.textColor = UIColor.redColor()
                        self.updown.textColor = UIColor.redColor()
                    }
                    
                    if bjkj < bjsj{
                        self.todayOpen.textColor = UIColor.greenColor()
                    }
                    else {
                        self.todayOpen.textColor = UIColor.redColor()
                    }
                    
                    
                    self.updown.text=self.gupiaonew._27updown!+" | "+self.gupiaonew._29updownpercent!+"%"
                    self.todayOpen.text=self.gupiaonew._28todayopen
                    self.yestClose.text=self.gupiaonew._34yestclose
                    self.dealNum.text=GloMethod.changeStrToShou(self.gupiaonew._31sumhand!)
                    self.dealMoney.text=self.gupiaonew._35dealmoney
                    
                    //                   print((gupiaonew._31sumhand! as NSString).length)
                    
                    //买卖价及买卖量
                    self.sell5.text=self.gupiaonew._12sell5!
                    self.sell4.text=self.gupiaonew._11sell4!
                    self.sell3.text=self.gupiaonew._10sell3!
                    self.sell2.text=self.gupiaonew._9sell2!
                    self.sell1.text=self.gupiaonew._8sell1!
                    self.buy1.text=self.gupiaonew._3buy1!
                    self.buy2.text=self.gupiaonew._4buy2!
                    self.buy3.text=self.gupiaonew._5buy3!
                    self.buy4.text=self.gupiaonew._6buy4!
                    self.buy5.text=self.gupiaonew._7buy5!
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
                    if bjb1 < bjsj{
                        self.buy1.textColor = UIColor.greenColor()
                    }
                    else {
                        self.buy1.textColor = UIColor.redColor()
                    }
                    if bjb2 < bjsj{
                        self.buy2.textColor = UIColor.greenColor()
                    }
                    else {
                        self.buy2.textColor = UIColor.redColor()
                    }
                    if bjb3 < bjsj{
                        self.buy3.textColor = UIColor.greenColor()
                    }
                    else {
                        self.buy3.textColor = UIColor.redColor()
                    }
                    if bjb4 < bjsj{
                        self.buy4.textColor = UIColor.greenColor()
                    }
                    else {
                        self.buy4.textColor = UIColor.redColor()
                    }
                    if bjb5 < bjsj{
                        self.buy5.textColor = UIColor.greenColor()
                    }
                    else {
                        self.buy5.textColor = UIColor.redColor()
                    }
                    if bjs1 < bjsj{
                        self.sell1.textColor = UIColor.greenColor()
                    }
                    else {
                        self.sell1.textColor = UIColor.redColor()
                    }
                    if bjs2 < bjsj{
                        self.sell2.textColor = UIColor.greenColor()
                    }
                    else {
                        self.sell2.textColor = UIColor.redColor()
                    }
                    if bjs3 < bjsj{
                        self.sell3.textColor = UIColor.greenColor()
                    }
                    else {
                        self.sell3.textColor = UIColor.redColor()
                    }
                    if bjs4 < bjsj{
                        self.sell4.textColor = UIColor.greenColor()
                    }
                    else {
                        self.sell4.textColor = UIColor.redColor()
                    }
                    if bjs5 < bjsj{
                        self.sell5.textColor = UIColor.greenColor()
                    }
                    else {
                        self.sell5.textColor = UIColor.redColor()
                    }
                    
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.price.setNeedsDisplay()
                        self.updown.setNeedsDisplay()
                        self.todayOpen.setNeedsDisplay()
                        self.yestClose.setNeedsDisplay()
                        self.dealNum.setNeedsDisplay()
                        self.dealMoney.setNeedsDisplay()
                        self.sell5.setNeedsDisplay()
                        self.sell4.setNeedsDisplay()
                        self.sell3.setNeedsDisplay()
                        self.sell2.setNeedsDisplay()
                        self.sell1.setNeedsDisplay()
                        self.buy5.setNeedsDisplay()
                        self.buy4.setNeedsDisplay()
                        self.buy3.setNeedsDisplay()
                        self.buy2.setNeedsDisplay()
                        self.buy1.setNeedsDisplay()
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
                    })
                }
            }
            
        }catch let error {
            print("请求失败: \(error)")
            
        }
        
        
    }
    
    
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        if !self.gupiaonew.statu!{
            return}
        switch segmentedControl.selectedSegmentIndex
        {
            
        case 0:
            firstView.hidden = false
            secondView.hidden = true
            threeView.hidden = true
            fourview.hidden = true
            
            if code == "0000001" {
                self.timeView.frame = CGRect(x: 0, y: 0, width: firstView.frame.size.width , height: height!)
            }
            else if code == "1399006" {
                self.timeView.frame = CGRect(x: 0, y: 0, width: firstView.frame.size.width , height: height!)
            }
            else if code == "1399001" {
                self.timeView.frame = CGRect(x: 0, y: 0, width: firstView.frame.size.width , height: height!)
            }
                
            else {
                self.timeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height:height!*0.6)
            }
            
            
            //            self.timeView.frame = CGRect(x: 0, y: 0, width: firstView.frame.size.width , height: firstView.frame.size.height)
            getFenshiData()
            
            
            
            
        case 1:
            firstView.hidden = true
            secondView.hidden = false
            threeView.hidden = true
            fourview.hidden = true
            self.rikView.frame = CGRect(x: 0, y: 0, width: secondView.frame.size.width , height: secondView.frame.size.height )
            getRiKData()
        case 2:
            firstView.hidden = true
            secondView.hidden = true
            threeView.hidden = false
            fourview.hidden = true
            self.zhoukView.frame = CGRect(x: 0, y: 0, width: threeView.frame.size.width , height: threeView.frame.size.height )
            getZhouKData()
        case 3:
            firstView.hidden = true
            secondView.hidden = true
            threeView.hidden = true
            fourview.hidden = false
            self.yuekView.frame = CGRect(x: 0, y: 0, width: fourview.frame.size.width , height: fourview.frame.size.height )
            getYueKData()
        default:
            break;
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                                self.rikView.KLineArray = self.rik
                                self.secondView.addSubview(self.rikView)
                            }
                            
                        })
                        
                    }
                    
                }
                
                operationQueue.addOperation(opt)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        
        
        //        do{
        //
        //            let opt = try HTTP.GET(GloStr.rikURL+"2016/"+code!+".json")
        //            opt.start{ result in
        //                if let error = result.error{
        //                    print(error)
        //
        //                }
        //                else{
        //                    //                   print(result.text!)
        //                    self.rik = GloMethod.fromJsonTok(result.text!)
        //
        //
        //                    dispatch_async(dispatch_get_main_queue(),{
        //                        self.rikView.KLineArray = self.rik
        //                        self.secondView.addSubview(self.rikView)
        //                    })
        //
        //                }
        //
        //            }
        //
        //        }catch let error {
        //            print("请求失败: \(error)")
        //        }
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
                                self.zhoukView.KLineArray = self.zhouk
                                self.threeView.addSubview(self.zhoukView)
                            }
                            
                        })
                        
                    }
                    
                }
                
                operationQueue.addOperation(opt)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        //        do{
        //
        //            var datas:[JSON] = []
        //            for i in GloStr.K_zhou_start...GloStr.K_zhou_end{
        //                var url = GloStr.zhoukURL+String(i)+"/"+code!+".json"
        //
        //                let opt0 = try HTTP.GET(url)
        //                opt0.start{ result in
        //                    if let error = result.error{
        //                    }else{
        //                        var dataTemp:[JSON]
        //                        self.zhouk = GloMethod.fromJsonTok(result.text!)
        //                        dataTemp = (self.zhouk?.data)!
        //                        datas = datas + dataTemp
        //
        //                        if i == GloStr.K_zhou_end{
        //                            self.zhouk?.data = datas
        //
        //                            dispatch_async(dispatch_get_main_queue(),{
        //                                if i == GloStr.K_zhou_end{
        //                                    self.zhoukView.KLineArray = self.zhouk
        //                                    self.threeView.addSubview(self.zhoukView)
        //                                }
        //
        //                            })
        //
        //                        }
        //                    }
        //                }
        //            }
        //        }catch let error {
        //            print("请求失败: \(error)")
        //
        //        }
        
        
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
                                self.yuekView.KLineArray = self.yuek
                                self.fourview.addSubview(self.yuekView)
                            }
                            
                        })
                        
                    }
                }
                operationQueue.addOperation(opt)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        
        
        
        
        //        do{
        //
        //            var datas:[JSON] = []
        //            for i in GloStr.K_yue_start...GloStr.K_yue_end{
        //                var url = GloStr.yuekURL+String(i)+"/"+code!+".json"
        //
        //                let opt0 = try HTTP.GET(url)
        //                opt0.start{ result in
        //                    if let error = result.error{
        //                    }else{
        //                        var dataTemp:[JSON]
        //                        self.yuek = GloMethod.fromJsonTok(result.text!)
        //                        dataTemp = (self.yuek?.data)!
        //                        datas = datas + dataTemp
        //
        //                        if i == GloStr.K_yue_end{
        //                            self.yuek?.data = datas
        //
        //                            dispatch_async(dispatch_get_main_queue(),{
        //                                if i == GloStr.K_yue_end{
        //                                    self.yuekView.KLineArray = self.yuek
        //                                    self.fourview.addSubview(self.yuekView)
        //                                }
        //
        //                            })
        //
        //                        }
        //                    }
        //                }
        //
        //
        //            }
        //
        //        }catch let error {
        //            print("请求失败: \(error)")
        //
        //        }
        
        
    }
    
    
    
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
                        self.firstView.addSubview(self.timeView)
                        
                        //                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        //                            sleep(3)
                        //                            for i in 1...fenshi2!.data!.count/2{
                        //                                self.timeView.timeLineArray.data?.removeLast()
                        //
                        //                            }
                        //                            dispatch_sync(dispatch_get_main_queue(),{
                        //                                // do something
                        //                                self.timeView.setNeedsDisplay()
                        //                            })
                        //                        })
                        
                        
                        
                    })
                    
                }
                
            }
            
        }catch let error {
            print("请求失败: \(error)")
            
        }
        
    }
    
    
}
