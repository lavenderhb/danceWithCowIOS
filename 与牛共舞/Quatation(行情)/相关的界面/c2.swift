import UIKit
import SwiftHTTP

class c2: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var timer:NSTimer!
    static var isDo:Bool=false
    static var isDoc2:Bool=false
    static var listdo:Bool=false

    var searchvc = searchViewController()
    let buttonback:UIButton = UIButton(type:.System)
    let buttonsearch:UIButton = UIButton(type:.System)
    
    let buttoninto1:UIButton = UIButton(type:.System)
    let buttoninto2:UIButton = UIButton(type:.System)
    let buttoninto3:UIButton = UIButton(type:.System)
    
    //颜色
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
    var line3 = UIView()
    var line4 = UIView()
    
    //文字
    var zs1 = UILabel()
    var zs2 = UILabel()
    var zs3 = UILabel()
    
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
    
    var xw1 = UILabel()
    var gg1 = UILabel()
    var yb1 = UILabel()
    var zde = UILabel()
    
    var tableview:UITableView!
    
    var gupiaoBeans:[GupiaoBean] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        c2.isDo=true
        
        self.view.backgroundColor = bule1
        
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
        

        buttonback.frame=CGRectMake(8, 28, 40, 40)
        buttonback.setBackgroundImage(UIImage(named:"backs100"),forState:.Normal)
//        self.view.addSubview(buttonback);
        
        buttonback.addTarget(self,action:#selector(tapped),forControlEvents:.TouchUpInside)
        
        buttonsearch.frame=CGRectMake(UIScreen.mainScreen().bounds.width - 50, 28, 40, 40)
        buttonsearch.setBackgroundImage(UIImage(named:"searchs100"),forState:.Normal)
        self.view.addSubview(buttonsearch);
        
        buttonsearch.addTarget(self,action:#selector(searchbt),forControlEvents:.TouchUpInside)
        
        // 指数分割竖线
        line1.backgroundColor = gray1
        line1.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3,95, 1 , 40)
        self.view.addSubview(line1)
        line2.backgroundColor = gray1
        line2.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3,95, 1 , 40)
        self.view.addSubview(line2)
        line3.backgroundColor = gray1
        line3.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3,165, 1 , 20)
        self.view.addSubview(line3)
        line4.backgroundColor = gray1
        line4.frame = CGRectMake(UIScreen.mainScreen().bounds.width*2/3,165, 1 , 20)
        self.view.addSubview(line4)
        
        //列表位置
        let rect = CGRectMake(0, 190, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 240)
        tableview = UITableView(frame: rect)
        tableview.backgroundColor = bule1
        tableview.delegate = self
        tableview.dataSource = self
        self.view.addSubview(tableview)
        self.tableview!.registerNib(UINib(nibName:"ZXTableViewCell", bundle:nil),
                                    forCellReuseIdentifier:"zxcell")
        
        
        //指数名称位置
        zs1.frame = CGRectMake(0, 75, UIScreen.mainScreen().bounds.width/3, 30)
        zs1.text = "上证指数"
        zs1.textColor = UIColor.whiteColor()
        zs1.font = UIFont(name:"Zapfino", size:13)
        zs1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(zs1)
        
        zs2.frame = CGRectMake(UIScreen.mainScreen().bounds.width/3, 75, UIScreen.mainScreen().bounds.width/3, 30)
        zs2.text = "深圳成指"
        zs2.textColor = UIColor.whiteColor()
        zs2.font = UIFont(name:"Zapfino", size:13)
        zs2.textAlignment=NSTextAlignment.Center
        self.view.addSubview(zs2)
        
        zs3.frame = CGRectMake(UIScreen.mainScreen().bounds.width/1.5, 75, UIScreen.mainScreen().bounds.width/3, 30)
        zs3.text = "创业板指"
        zs3.textColor = UIColor.whiteColor()
        zs3.font = UIFont.systemFontOfSize(13)
        zs3.textAlignment=NSTextAlignment.Center
        self.view.addSubview(zs3)
        
        //指数指数位置
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
        
        //指数涨跌位置
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
        
        //指数涨跌位置
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
        
        //指数竖线
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
        
        
        buttoninto1.frame=CGRectMake(0, 70, UIScreen.mainScreen().bounds.width/3, 90)
        self.view.addSubview(buttoninto1);
        buttoninto1.addTarget(self,action:#selector(buttoninto1fun),forControlEvents:.TouchUpInside)
        
        buttoninto2.frame=CGRectMake(UIScreen.mainScreen().bounds.width/3, 70, UIScreen.mainScreen().bounds.width/3, 90)
        self.view.addSubview(buttoninto2);
        buttoninto2.addTarget(self,action:#selector(buttoninto2fun),forControlEvents:.TouchUpInside)
        
        buttoninto3.frame=CGRectMake(UIScreen.mainScreen().bounds.width*2/3, 70, UIScreen.mainScreen().bounds.width/3, 90)
        self.view.addSubview(buttoninto3);
        buttoninto3.addTarget(self,action:#selector(buttoninto3fun),forControlEvents:.TouchUpInside)
        
        
        xw1.frame = CGRectMake(0, 160, UIScreen.mainScreen().bounds.width/4, 30)
        xw1.text = "名称"
        xw1.textColor = UIColor.whiteColor()
        xw1.font = UIFont.systemFontOfSize(12)
        xw1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(xw1)
        
        gg1.frame = CGRectMake(UIScreen.mainScreen().bounds.width/4, 160, UIScreen.mainScreen().bounds.width/4, 30)
        gg1.text = "最新"
        gg1.textColor = UIColor.whiteColor()
        gg1.font = UIFont.systemFontOfSize(12)
        gg1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(gg1)
        
        yb1.frame = CGRectMake(UIScreen.mainScreen().bounds.width/2, 160, UIScreen.mainScreen().bounds.width/4, 30)
        yb1.text = "涨跌幅"
        yb1.textColor = UIColor.whiteColor()
        yb1.font = UIFont.systemFontOfSize(12)
        yb1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(yb1)
        
        zde.frame = CGRectMake(UIScreen.mainScreen().bounds.width*3/4, 160, UIScreen.mainScreen().bounds.width/4, 30)
        zde.text = "涨跌额"
        zde.textColor = UIColor.whiteColor()
        zde.font = UIFont.systemFontOfSize(12)
        zde.textAlignment=NSTextAlignment.Center
        self.view.addSubview(zde)
        
        
        

        
        getDataFromDB()
        getDetail1()
        getDetail2()
        getDetail3()
        

        timer = NSTimer.scheduledTimerWithTimeInterval(2,target:self,selector:#selector(c2.tickDown),userInfo:nil,repeats:true)
        
        
    }
    
    /*
     从数据库中读取自选股的列表
    **/
    func getDataFromDB(){
        gupiaoBeans=GloMethod.selectGupiaos()
        
        do{
            for gp in gupiaoBeans {
                let code = GloMethod.change126CodeTo(gp.code!, symbol: gp.symbol!)
                let opt = try HTTP.GET(GloStr.gpURL2+code)
                opt.start{ result in
                    if let error = result.error{
                        print(error)
                    }
                    else{
                        //                    print(result.text)
                        let gupiaonew=GloMethod.fromJsonToDetail(result.text!)
                        gp.price=gupiaonew._25price
                        gp.percent=gupiaonew._29updownpercent
                        gp.updown=gupiaonew._27updown
                        dispatch_async(dispatch_get_main_queue(),{
                            self.tableview.reloadData()
                        })
                    }
                }
            }
            
        }catch let error {
            print("请求失败: \(error)")
            
        }
        
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print(gupiaoBeans.count)
        return gupiaoBeans.count
        
        
        
    }
    override func viewWillAppear(animated: Bool) {
        if animated {
            getDataFromDB()
            self.tableview.reloadData()
        }
    }
    

    func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        let cell:ZXTableViewCell = tableView.dequeueReusableCellWithIdentifier("zxcell")
            as! ZXTableViewCell
        
        cell.selectedBackgroundView!.backgroundColor = black1
        
        
        
        let name = cell.name
        let symbol = cell.symbol
        let price = cell.price
        let percent = cell.percent
        let percentup = cell.percentm
        name.textColor = UIColor.whiteColor()
        symbol.textColor = UIColor.whiteColor()
        name.text = gupiaoBeans [indexPath.row].name
        symbol.text = gupiaoBeans [indexPath.row].symbol
 
//        price.text = gupiaoBeans[indexPath.row].price
//        percent.text = gupiaoBeans[indexPath.row].percent
//        percentup.text = gupiaoBeans[indexPath.row].updown
        
        let percentString = gupiaoBeans[indexPath.row].percent
        if percentString != nil{
            if (percentString! as NSString).substringToIndex(1) == "-"{
                price.textColor = UIColor.greenColor()
                percent.textColor = UIColor.greenColor()
                percent.text = gupiaoBeans[indexPath.row].percent!+"%"
                price.text = gupiaoBeans[indexPath.row].price
                percentup.text = gupiaoBeans[indexPath.row].updown
                percentup.textColor = UIColor.greenColor()
            }else if percentString == "0.00"{
                price.textColor = UIColor.whiteColor()
                percent.textColor = UIColor.whiteColor()
                percentup.textColor = UIColor.whiteColor()
                percent.text = gupiaoBeans[indexPath.row].percent!+"%"
                price.text = gupiaoBeans[indexPath.row].price
                percentup.text = gupiaoBeans[indexPath.row].updown
            }else{
                price.textColor = UIColor.redColor()
                percent.textColor = UIColor.redColor()
                percentup.textColor = UIColor.redColor()
                percent.text = gupiaoBeans[indexPath.row].percent!+"%"
                price.text = gupiaoBeans[indexPath.row].price
                percentup.text = gupiaoBeans[indexPath.row].updown
            }
            
            
        }

        
        return cell

    }
    func tableView(tableView: UITableView,
                   commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                      forRowAtIndexPath indexPath: NSIndexPath) {
        print("删除\(indexPath.row)")
        let index = indexPath.row
        GloMethod.deleteGupiaoBean(gupiaoBeans[index].code!)
        self.gupiaoBeans.removeAtIndex(index)
        self.tableview?.deleteRowsAtIndexPaths([indexPath],
                                          withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        self.tabv!.deselectRowAtIndexPath(indexPath, animated: true)
        c2.isDo=false
        c2.isDoc2=true
        (AppDelegate.delegate as! AppDelegate).searchcode = [self.gupiaoBeans[indexPath.row].name!,self.gupiaoBeans[indexPath.row].symbol!,self.gupiaoBeans[indexPath.row].code!]
        
//        var listGP=[ListBean]()
        var listGP:[ListBean]=[]
        for gp in self.gupiaoBeans {
            var list=ListBean()
            list.name=gp.name
            list.symbol=gp.symbol
            list.code=gp.code
            c2.listdo = true
            listGP.append(list)
        }
        (AppDelegate.delegate as! AppDelegate).listGP = listGP
        //        print(itemString)
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
        self.presentViewController(anotherView, animated: false, completion: nil)

        
    }
    

    func tableView(tableView: UITableView,
                   editingStyleForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCellEditingStyle {
            
        
            return UITableViewCellEditingStyle.Delete
    }
    

    func tableView(tableView: UITableView,
                   titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath)
        -> String? {
            return "删除"
    }
    
    
    //buttton方法
    func buttoninto1fun(){
        c2.isDo=false
        c2.isDoc2=true
        (AppDelegate.delegate as! AppDelegate).searchcode = ["上证指数","000001","0000001"]
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
        self.presentViewController(anotherView, animated: false, completion: nil)
    }
    
    func buttoninto2fun(){
        c2.isDo=false
        c2.isDoc2=true
        (AppDelegate.delegate as! AppDelegate).searchcode = ["深圳成指","399001","1399001"]
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
        self.presentViewController(anotherView, animated: false, completion: nil)
    }
    
    func buttoninto3fun(){
        c2.isDo=false
        c2.isDoc2=true
        (AppDelegate.delegate as! AppDelegate).searchcode = ["创业板指","399006","1399006"]
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("pageViewController") as! PageViewController
        self.presentViewController(anotherView, animated: false, completion: nil)
    }
    
    
    func tapped(){
        c2.isDo=false
        self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func searchbt(){
        c2.isDo=false
        c2.isDoc2=true
        self.presentViewController(searchvc, animated: false, completion: nil)
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

                    self.upd1.text=self.gupiaonew1._27updown
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
                    self.upd3.text=self.gupiaonew3._27updown
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
        if c2.isDo {
            getDataFromDB()
            getDetail1()
            getDetail2()
            getDetail3()
            print("tickc2...")
            
        }
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
