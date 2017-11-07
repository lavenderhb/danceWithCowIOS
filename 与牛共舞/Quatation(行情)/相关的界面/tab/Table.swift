//
//  Table.swift
//  danceWithCowIOS
//
//  Created by 雷伊潇 on 16/5/31.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit
import SwiftHTTP

class Table: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    let buttonback:UIButton = UIButton(type:.System)
    //颜色
    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
    var bule1=UIColor(red: 19/255, green: 20/255, blue: 29/255, alpha: 1)
    var gray1=UIColor(red: 26/255, green: 25/255, blue: 32/255, alpha: 1)
    //背景模块
    var page1 = UIView()
    var page2 = UIView()
    
    //文字
    var zs1 = UILabel()
    var zs2 = UILabel()
    var zs3 = UILabel()
    
    var sz1 = UILabel()
    var sz2 = UILabel()
    var sz3 = UILabel()
    
    var tableView:UITableView?
    
    var bdbeanAll:Dictionary<Int, [BDBean]>?
    
    var Headers:[String]?
    
    //    let urls=[GloStr.ZFUrl,GloStr.DFUrl,GloStr.HSLUrl,GloStr.ZFBUrl]
    
    
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //设置按钮位置和大小
        buttonback.frame=CGRectMake(0, 35, 60, 30)
        //设置按钮文字
        buttonback.setTitleColor(UIColor.whiteColor() , forState: UIControlState.Normal)
        buttonback.setTitle("返回", forState:UIControlState.Normal)
        self.view.addSubview(buttonback);
        
        buttonback.addTarget(self,action:#selector(tapped),forControlEvents:.TouchUpInside)
        
        
        self.view.backgroundColor = bule1
        //横条设置
        page1.backgroundColor = red1
        page1.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.width , 70)
        self.view.addSubview(page1)
        self.view.sendSubviewToBack(page1)//置于底层
        
        page2.backgroundColor = black1
        page2.frame = CGRectMake(0,70, UIScreen.mainScreen().bounds.width , 90)
        self.view.addSubview(page2)
        
        //指数名称位置
        zs1.frame = CGRectMake(0, 70, UIScreen.mainScreen().bounds.width/3, 30)
        zs1.text = "深圳成指"
        zs1.textColor = UIColor.whiteColor()
        zs1.font = UIFont(name:"Zapfino", size:10)
        zs1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(zs1)
        
        zs2.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, 70, UIScreen.mainScreen().bounds.width/3, 30)
        zs2.text = "上证指数"
        zs2.textColor = UIColor.whiteColor()
        zs2.font = UIFont(name:"Zapfino", size:10)
        zs2.textAlignment=NSTextAlignment.Center
        self.view.addSubview(zs2)
        
        zs3.frame = CGRectMake(UIScreen.mainScreen().bounds.width/1.5, 70, UIScreen.mainScreen().bounds.width/3, 30)
        zs3.text = "创业板指"
        zs3.textColor = UIColor.whiteColor()
        zs3.font = UIFont(name:"Zapfino", size:10)
        zs3.textAlignment=NSTextAlignment.Center
        self.view.addSubview(zs3)
        
        //指数指数位置
        sz1.frame = CGRectMake(0, 90, UIScreen.mainScreen().bounds.width/3, 30)
        sz1.text = "10891.96"
        sz1.textColor = UIColor.whiteColor()
        sz1.font = UIFont.systemFontOfSize(15)
        sz1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(sz1)
        
        sz2.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, 90, UIScreen.mainScreen().bounds.width/3, 30)
        sz2.text = "2204.96"
        sz2.textColor = red1
        sz2.font = UIFont.systemFontOfSize(15)
        sz2.textAlignment=NSTextAlignment.Center
        self.view.addSubview(sz2)
        
        sz3.frame = CGRectMake(UIScreen.mainScreen().bounds.width/1.5, 90, UIScreen.mainScreen().bounds.width/3, 30)
        sz3.text = "3102.56"
        sz3.textColor = greed1
        sz3.font = UIFont.systemFontOfSize(15)
        sz3.textAlignment=NSTextAlignment.Center
        self.view.addSubview(sz3)
        
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.bdbeanAll =  [
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
        
        //创建表视图
        self.tableView = UITableView(frame:CGRectMake(0,160,(UIScreen.mainScreen().bounds.width),(UIScreen.mainScreen().bounds.height - 70)), style:UITableViewStyle.Grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.backgroundColor = bule1
        //创建一个重用的单元格
        self.tableView!.registerNib(UINib(nibName:"BDTableCell", bundle:nil),
                                    forCellReuseIdentifier:"bdcell")
        self.view.addSubview(self.tableView!)
        
        //创建表头标签
        //        let headerLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, 30))
        //        headerLabel.backgroundColor = UIColor.blackColor()
        //        headerLabel.textColor = UIColor.whiteColor()
        //        headerLabel.numberOfLines = 0
        //        headerLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //        headerLabel.text = "高级 UIKit 控件"
        //        headerLabel.font = UIFont.italicSystemFontOfSize(20)
        //        self.tableView!.tableHeaderView = headerLabel
        
        
        getData()
        
        
    }
    func getData(){
        
        
        
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        
        do {
            let opt0 = try HTTP.New(GloStr.ZFUrl, method: .GET)
            opt0.onFinish = { response in
                let jsons=GloMethod.formJsonToBD(response.text!)
               
                for i in 0...jsons.count-1{
                    let array:[String]=jsons[i].string!.componentsSeparatedByString(",")
                    let bdBean:BDBean=BDBean()
                    
                    bdBean.name=array[2]
                    bdBean.symbol=array[1]
                    
                    bdBean.code = GloMethod.changeDFCFWTo126(array[0], symbol: bdBean.symbol!)
                    bdBean.price = array[5]
                    bdBean.percent = array[11]
                    self.bdbeanAll![0]?.append(bdBean)
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView?.reloadData()
                    
                })
                
            }
            
            let opt1 = try HTTP.New(GloStr.DFUrl, method: .GET)
            opt1.onFinish = { response in
                let jsons=GloMethod.formJsonToBD(response.text!)
                for i in 0...jsons.count-1{
                    let array:[String]=jsons[i].string!.componentsSeparatedByString(",")
                    let bdBean:BDBean=BDBean()
                    
                    bdBean.name=array[2]
                    bdBean.symbol=array[1]
                    
                    bdBean.code = GloMethod.changeDFCFWTo126(array[0], symbol: bdBean.symbol!)
                    bdBean.price = array[5]
                    bdBean.percent = array[11]
                    self.bdbeanAll![1]?.append(bdBean)
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView?.reloadData()
                    
                })
                
            }
            
            let opt2 = try HTTP.New(GloStr.HSLUrl, method: .GET)
            opt2.onFinish = { response in
                let jsons=GloMethod.formJsonToBD(response.text!)
                for i in 0...jsons.count-1{
                    let array:[String]=jsons[i].string!.componentsSeparatedByString(",")
                    let bdBean:BDBean=BDBean()
                    
                    bdBean.name=array[2]
                    bdBean.symbol=array[1]
                    
                    bdBean.code = GloMethod.changeDFCFWTo126(array[0], symbol: bdBean.symbol!)
                    bdBean.price = array[5]
                    bdBean.percent = array[23]
                    self.bdbeanAll![2]?.append(bdBean)
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView?.reloadData()
                    
                })
                
            }
            
            let opt3 = try HTTP.New(GloStr.ZFBUrl, method: .GET)
            opt3.onFinish = { response in
                let jsons=GloMethod.formJsonToBD(response.text!)
                for i in 0...jsons.count-1{
                    let array:[String]=jsons[i].string!.componentsSeparatedByString(",")
                    let bdBean:BDBean=BDBean()
                    
                    bdBean.name=array[2]
                    bdBean.symbol=array[1]
                    
                    bdBean.code = GloMethod.changeDFCFWTo126(array[0], symbol: bdBean.symbol!)
                    bdBean.price = array[5]
                    bdBean.percent = array[13]
                    self.bdbeanAll![3]?.append(bdBean)
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
    
    
    func tapped(){
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //在本例中，有2个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (bdbeanAll?.count)!;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.bdbeanAll?[section]
        return data!.count
    }
    
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            var headers =  self.Headers!;
            return headers[section];
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的尾部
    //    func tableView(tableView:UITableView, titleForFooterInSection
    //        section:Int)->String?
    //    {
    //        let data = self.allnames?[section]
    //        return "有\(data!.count)个控件"
    //    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        //        let identify:String = "SwiftCell"
        //        //同一形式的单元格重复使用，在声明时已注册
        //        let cell = tableView.dequeueReusableCellWithIdentifier(
        //            identify, forIndexPath: indexPath) as UITableViewCell
        
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
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        (AppDelegate.delegate as! AppDelegate).searchcode = [self.bdbeanAll![indexPath.section]![indexPath.row].name!,self.bdbeanAll![indexPath.section]![indexPath.row].symbol!,self.bdbeanAll![indexPath.section]![indexPath.row].code!]
        
        
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("qpxq") as! qpxq
        self.presentViewController(anotherView, animated: true, completion: nil)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

////
////  c1.swift
////  hqnew
////
////  Created by 雷伊潇 on 16/8/29.
////  Copyright © 2016年 515. All rights reserved.
////
//
//import UIKit
//
//class c1: UIViewController,UITableViewDelegate,
//UITableViewDataSource {
//    
//    
//    
//    let buttonback:UIButton = UIButton(type:.System)
//    //颜色
//    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
//    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
//    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
//    var bule1=UIColor(red: 19/255, green: 20/255, blue: 29/255, alpha: 1)
//    var gray1=UIColor(red: 26/255, green: 25/255, blue: 32/255, alpha: 1)
//    //背景模块
//    var page1 = UIView()
//    var page2 = UIView()
//    
//    //文字
//    var zs1 = UILabel()
//    var zs2 = UILabel()
//    var zs3 = UILabel()
//    
//    var sz1 = UILabel()
//    var sz2 = UILabel()
//    var sz3 = UILabel()
//    
//    //列表表格
//    var tableView:UITableView?
//    
//    
//    var ctrlnames:[String] = ["涨幅榜","跌幅榜","快速涨幅",
//                              "换手率","量比"]
//    
//    var selectedCellIndexPaths:[NSIndexPath] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        //设置按钮位置和大小
//        buttonback.frame=CGRectMake(0, 35, 60, 30)
//        //设置按钮文字
//        buttonback.setTitleColor(UIColor.whiteColor() , forState: UIControlState.Normal)
//        buttonback.setTitle("返回", forState:UIControlState.Normal)
//        self.view.addSubview(buttonback);
//        
//        buttonback.addTarget(self,action:#selector(tapped),forControlEvents:.TouchUpInside)
//        
//        
//        self.view.backgroundColor = bule1
//        //横条设置
//        page1.backgroundColor = red1
//        page1.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.width , 70)
//        self.view.addSubview(page1)
//        self.view.sendSubviewToBack(page1)//置于底层
//        
//        page2.backgroundColor = black1
//        page2.frame = CGRectMake(0,70, UIScreen.mainScreen().bounds.width , 90)
//        self.view.addSubview(page2)
//        
//        //指数名称位置
//        zs1.frame = CGRectMake(0, 70, UIScreen.mainScreen().bounds.width/3, 30)
//        zs1.text = "深圳成指"
//        zs1.textColor = UIColor.whiteColor()
//        zs1.font = UIFont(name:"Zapfino", size:10)
//        zs1.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(zs1)
//        
//        zs2.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, 70, UIScreen.mainScreen().bounds.width/3, 30)
//        zs2.text = "上证指数"
//        zs2.textColor = UIColor.whiteColor()
//        zs2.font = UIFont(name:"Zapfino", size:10)
//        zs2.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(zs2)
//        
//        zs3.frame = CGRectMake(UIScreen.mainScreen().bounds.width/1.5, 70, UIScreen.mainScreen().bounds.width/3, 30)
//        zs3.text = "创业板指"
//        zs3.textColor = UIColor.whiteColor()
//        zs3.font = UIFont(name:"Zapfino", size:10)
//        zs3.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(zs3)
//        
//        //指数指数位置
//        sz1.frame = CGRectMake(0, 90, UIScreen.mainScreen().bounds.width/3, 30)
//        sz1.text = "10891.96"
//        sz1.textColor = UIColor.whiteColor()
//        sz1.font = UIFont.systemFontOfSize(15)
//        sz1.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(sz1)
//        
//        sz2.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, 90, UIScreen.mainScreen().bounds.width/3, 30)
//        sz2.text = "2204.96"
//        sz2.textColor = red1
//        sz2.font = UIFont.systemFontOfSize(15)
//        sz2.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(sz2)
//        
//        sz3.frame = CGRectMake(UIScreen.mainScreen().bounds.width/1.5, 90, UIScreen.mainScreen().bounds.width/3, 30)
//        sz3.text = "3102.56"
//        sz3.textColor = greed1
//        sz3.font = UIFont.systemFontOfSize(15)
//        sz3.textAlignment=NSTextAlignment.Center
//        self.view.addSubview(sz3)
//        
//        
//        //创建表视图
//        self.tableView = UITableView(frame: CGRectMake(0, 160, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 160),
//                                     style:UITableViewStyle.Plain)
//        self.tableView!.delegate = self
//        self.tableView!.dataSource = self
//        
//        //创建一个重用的单元格
//        self.tableView!.registerClass(UITableViewCell.self,
//                                      forCellReuseIdentifier: "SwiftCell")
//        
//        self.tableView?.backgroundColor = bule1 //空白cell颜色
//        self.view.addSubview(self.tableView!)
//    }
//    
//    func tapped(){
//        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    
//    //在本例中，只有一个分区
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1;
//    }
//    
//    //返回表格行数（也就是返回控件数）
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.ctrlnames.count
//    }
//    
//    //创建各单元显示内容(创建参数indexPath指定的单元）
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
//        -> UITableViewCell
//    {
//        let label =  UILabel(frame:CGRectZero)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = self.ctrlnames[indexPath.row]
//        label.textColor = UIColor.whiteColor() //榜单名字颜色
//        
//        
//        
//        let textview=UITextView(frame:CGRectZero)
//        textview.translatesAutoresizingMaskIntoConstraints = false
//        textview.textColor = UIColor.grayColor()
//        //演示效果，暂时写死
//        textview.text = "榜单"
//        textview.textColor = UIColor.whiteColor() //榜单详细字颜色
//        textview.backgroundColor = gray1 //cell颜色
//        
//        
//        
//        
//        let identify:String = "SwiftCell"
//        let cell = UITableViewCell(style: .Default, reuseIdentifier:identify)
//        //自动遮罩不可见区域,超出的不显示
//        cell.layer.masksToBounds = true
//        cell.contentView.addSubview(label)
//        cell.contentView.addSubview(textview)
//        cell.backgroundColor = bule1 //cell颜色
//        
//        //创建一个控件数组
//        let views = ["label":label, "textview":textview]
//        cell.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
//            "H:|-15-[label]-15-|", options: [], metrics: nil, views: views))
//        cell.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
//            "H:|-15-[textview]-15-|", options: [], metrics: nil, views: views))
//        cell.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
//            "V:|[label(40)]", options: [], metrics: nil, views: views))
//        cell.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
//            "V:|-40-[textview(80)]", options: [], metrics: nil, views: views))
//        
//        return cell
//    }
//    
//    // UITableViewDelegate 方法，处理列表项的选中事件
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        self.tableView!.deselectRowAtIndexPath(indexPath, animated: false)
//        if let index = selectedCellIndexPaths.indexOf(indexPath) {
//            selectedCellIndexPaths.removeAtIndex(index)
//        }else{
//            selectedCellIndexPaths.append(indexPath)
//        }
//        // Forces the table view to call heightForRowAtIndexPath
//        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }
//    
//    //点击单元格会引起cell高度的变化，所以要重新设置
//    func tableView(tableView: UITableView,
//                   heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if selectedCellIndexPaths.contains(indexPath) {
//            return 120
//        }
//        return 40
//    }
//}


