//
//  KlineView.swift
//  KlineTest
//
//  Created by 雷伊潇 on 16/2/4.
//  Copyright © 2016年 雷伊潇. All rights reserved.
//

import UIKit


protocol ChangeTop {
    func changeTopData(top:Double,low:Double,cjl:Double,Open:Double,close:Double)
}
protocol JumpToHeng {
    func jump()
}

class KlineView: UIView {
    var changeTop:ChangeTop?
    func setChangeTop(changeTop:ChangeTop){
        self.changeTop=changeTop
    }
    
    var jumpToHeng:JumpToHeng?
    func setJump(jumpToHeng:JumpToHeng){
        self.jumpToHeng=jumpToHeng
    }
    
    var klineremoveset:NSTimer!
    var klineremovesetisDo:Bool=false
    
    var lefttimer:NSTimer!
    var righttimer:NSTimer!
    var timer = 0.02
    
    
    let buttonleft:UIButton = UIButton(type:.System)
    let buttonright:UIButton = UIButton(type:.System)
    let buttonadd:UIButton = UIButton(type:.System)
    let buttonsub:UIButton = UIButton(type:.System)
    let buttonall:UIButton = UIButton(type:.System)
    var buttonallisDo:Bool=true
    
    let buttonopen:UIButton = UIButton(type:.System)
    
    
    
    
    var djlabel = UILabel()
    var djkj = UILabel()
    var djsj = UILabel()
    var djzg = UILabel()
    var djzd = UILabel()
    var djcjl = UILabel()
    var djma5 = UILabel()
    var djma10 = UILabel()
    var djma20 = UILabel()
    var djma30 = UILabel()
    //颜色
    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
    var bule1=UIColor(red: 19/255, green: 20/255, blue: 29/255, alpha: 1)
    var gray1=UIColor(red: 26/255, green: 25/255, blue: 32/255, alpha: 1)
    var color10=UIColor(red: 232/255, green: 203/255, blue: 50/255, alpha: 1)
    var color20=UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
    var color30=UIColor(red: 162/255, green: 41/255, blue: 175/255, alpha: 1)
    
    
    //成交量第一次变化关闭
    var cjlbool:Bool=false
    
    var priceLineRect: CGRect!
    var volumeLineRect: CGRect!
    var maxPrice: Double!
    var minPrice: Double!
    var maxVolume: Double!
    var stepX: CGFloat!
    var stepY: CGFloat!
    var stepVolumeY: CGFloat!
    
    //macd线
    var maxmacd: Double!
    var minmacd: Double!
    var stepmacdY: CGFloat!
    //kdj线
    var maxkdj: Double!
    var minkdj: Double!
    var stepkdjY: CGFloat!
    
    var zbsz:Int=1
    
    func setsz(sz:Int){
        zbsz=sz
        setNeedsDisplay()
    }
    
    
    var KLineArray: KBean! {
        
        
        
        didSet {
            
            
            
            //            ma10=self.initMa(KLineArray.data!, day: 10)
            //            ma20=self.initMa(KLineArray.data!, day: 20)
            
            
            self.setNeedsDisplay()
            if self.KLineArray.data?.count == 0{
                
            }else {
                getAvgData()
                getAvgData10()
                getAvgData20()
                getAvgData30()
                getmacdData()
                getkdjData()
            }
            
        }
        
    }
    //指标相关数据
    //macd线
    var countmacd:Int!
    var ArraydEAs:[Double]=[]
    var ArraydIFs:[Double]=[]
    var ArraymACDs:[Double]=[]
    
    var macdArrayDEAs:[Double]=[]
    var macdArrayDIFs:[Double]=[]
    var macdArrayMACDs:[Double]=[]
    
    func getmacdData(){
        countmacd = KLineArray.data?.count
        var eMA12:Double=0.0
        var eMA26:Double=0.0
        var macdclose:Double=0.0
        var dIF:Double=0.0
        var dEA:Double=0.0
        var mACD:Double=0.0
        
        if KLineArray.data?.count > 0{
            
            for i in 0...countmacd-1{
                macdclose = Double(KLineArray.data![i][2].number!)
                if i == 0{
                    eMA12 = macdclose
                    eMA26 = macdclose
                }else{
                    eMA12 = eMA12 * 11 / 13 + macdclose * 2 / 13
                    eMA26 = eMA26 * 25 / 27 + macdclose * 2 / 27
                    dIF = eMA12 - eMA26
                    dEA = dEA * 8 / 10 + dIF * 2 / 10
                    mACD = (dIF - dEA)*2
                }
                macdArrayDEAs.append(dEA)
                macdArrayDIFs.append(dIF)
                macdArrayMACDs.append(mACD)
            }
        }
    }
    //kdj线
    var countkdj:Int!
    var Arrayks:[Double]=[]
    var Arrayds:[Double]=[]
    var Arrayjs:[Double]=[]
    
    func getkdjData(){
        countkdj = KLineArray.data?.count
        
        var k:Double=50.0
        var d:Double=50.0
        var j:Double=0.0
        var rsv:Double=0.0
        
        if KLineArray.data?.count > 0 {
            
            var high = Double(KLineArray.data![0][3].number!)
            var low = Double(KLineArray.data![0][4].number!)
            
            for i in 0...countkdj-1{
                let countkdjclose = Double(KLineArray.data![i][2].number!)
                if i > 0 && i < 5{
                    
                    if high < Double(KLineArray.data![i][3].number!){
                        high = Double(KLineArray.data![i][3].number!)
                    }
                    if low > Double(KLineArray.data![i][4].number!){
                        low = Double(KLineArray.data![i][4].number!)
                    }
                }else if i >= 5 && i <= countmacd - 5{
                    for ii in i-4 ... i+4{
                        if high < Double(KLineArray.data![ii][3].number!){
                            high = Double(KLineArray.data![ii][3].number!)
                        }
                        if low > Double(KLineArray.data![ii][4].number!){
                            low = Double(KLineArray.data![ii][4].number!)
                        }
                        
                    }
                    
                }else{
                    if high < Double(KLineArray.data![i][3].number!){
                        high = Double(KLineArray.data![i][3].number!)
                    }
                    if low > Double(KLineArray.data![i][4].number!){
                        low = Double(KLineArray.data![i][4].number!)
                    }
                }
                
                if high != low{
                    rsv = (countkdjclose - low)/(high - low) * 100
                    
                }
                if i == 0 {
                    k = rsv
                    d = k
                } else {
                    k = k * 2 / 3 + rsv / 3
                    d = d * 2 / 3 + k / 3
                }
                
                j = 3 * d - 2 * k
                
                Arrayks.append(k)
                Arrayds.append(d)
                Arrayjs.append(j)
                
                
            }
            
        }
    }
    
    
    
    //五日均线
    var count1:Int!
    var maValues:[Double]!
    var sum:Double=0
    var avg:Double=0
    var averageArray:[Double]=[]
    
    func getAvgData(){
        count1 = KLineArray.data?.count
        
        for j in 0...count1-1{
            let close = Double(KLineArray.data![j][2].number!)
            //            print(close)
            if j < 5 {
                sum=sum+close
                avg=sum/(Double)(j + 1)
            }else{
                sum = close + avg * (Double)(4)
                avg=sum/(Double)(5)
            }
            averageArray.append(avg)
            
        }
    }
    
    //10日均线
    var count10:Int!
    var maValues10:[Double]=[]
    var sum10:Double=0
    var avg10:Double=0
    var averageArray10:[Double]=[]
    
    func getAvgData10(){
        count10 = KLineArray.data?.count
        
        for j in 0...count10-1{
            let close10 = Double(KLineArray.data![j][2].number!)
            //            print(close)
            if j < 10 {
                sum10=sum10+close10
                avg10=sum10/(Double)(j + 1)
            }else{
                sum10 = close10 + avg10 * (Double)(9)
                avg10=sum10/(Double)(10)
            }
            averageArray10.append(avg10)
            
        }
    }
    
    
    //20日均线
    var count20:Int!
    var sum20:Double=0
    var avg20:Double=0
    var averageArray20:[Double]=[]
    
    func getAvgData20(){
        count20 = KLineArray.data?.count
        
        for j in 0...count20-1{
            let close20 = Double(KLineArray.data![j][2].number!)
            //            print(close)
            if j < 20 {
                sum20=sum20+close20
                avg20=sum20/(Double)(j + 1)
            }else{
                sum20 = close20 + avg20 * (Double)(19)
                avg20=sum20/(Double)(20)
            }
            averageArray20.append(avg20)
            
        }
    }
    
    //30日均线
    var count30:Int!
    var sum30:Double=0
    var avg30:Double=0
    var averageArray30:[Double]=[]
    
    func getAvgData30(){
        count30 = KLineArray.data?.count
        
        for j in 0...count30-1{
            let close30 = Double(KLineArray.data![j][2].number!)
            //            print(close)
            if j < 30 {
                sum30=sum30+close30
                avg30=sum30/(Double)(j + 1)
            }else{
                sum30 = close30 + avg30 * (Double)(29)
                avg30=sum30/(Double)(30)
            }
            averageArray30.append(avg30)
            
        }
    }
    
    
    
    
    
    
    //    func initMa(kBeanData:[JSON],day:Int)->[Double]{
    //        if day < 2 || kBeanData.count<=0 {
    //            return []
    //        }
    //        var maValues:[Double]!
    //
    //
    //        var sum:Double=0
    //        var avg:Double=0
    //        //        for var index = 0; index < 3; ++index {
    //        for var i=kBeanData.count-1;i>0;i -= 1 {
    //            let close=kBeanData[i][2].double
    //            print(i)
    //            if i>kBeanData.count-day {
    //                sum=sum+close!
    //                avg=sum/(Double)(kBeanData.count-i)
    //            }
    //            else{
    //                sum = close! + avg * (Double)(day - 1)
    //                avg=sum/(Double)(day)
    //            }
    //            maValues.append(avg)
    //        }
    //        var resule:[Double]!
    //        for var j = maValues.count-1;j>0;j-=1 {
    //            resule.append(maValues[j])
    //        }
    //        return resule
    //
    //    }
    
    var longPressGesture:UILongPressGestureRecognizer!
    
    var displayRange: NSRange!
    init() //初始定义
    {
        super.init(frame: CGRectZero)
        self.backgroundColor = bule1
        self.contentMode = .Redraw
        self.displayRange = NSRange(location: 0, length: 60)
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureAction))
        self.addGestureRecognizer(longPressGesture)
        
        //        let tapSingle=UITapGestureRecognizer(target:self,action:#selector(tapSingleDid))
        //        tapSingle.numberOfTapsRequired=1
        //        tapSingle.numberOfTouchesRequired=1
        
        //        let swipeUp = UISwipeGestureRecognizer(target:self, action:#selector(swipe(_:)))
        //        swipeUp.direction = UISwipeGestureRecognizerDirection.Left
        //        self.addGestureRecognizer(swipeUp)
        //
        //        let swipeDown = UISwipeGestureRecognizer(target:self, action:#selector(swipe(_:)))
        //        swipeDown.direction = UISwipeGestureRecognizerDirection.Right
        //        self.addGestureRecognizer(swipeDown)
    }
    
    func swipe(recognizer:UISwipeGestureRecognizer){
        if recognizer.direction == UISwipeGestureRecognizerDirection.Left{
            if count<=60{
            }else if (end+30)<=(count-1){
                end=end+30
                begin=begin+30
            }else {
                end=count-1
                begin=count-60
            }
            setNeedsDisplay()
            
            
        }else if recognizer.direction == UISwipeGestureRecognizerDirection.Right{
            if count<=60{
            }
            else if begin>=30 {
                begin=begin-30
                end=end-30
            }else {
                begin=0
                end=60-1
                
            }
            setNeedsDisplay()
        }
        
        //        let point=recognizer.locationInView(self)
        //
        //
        //        //这个点是滑动的起点
        //        print(point.x)
        //        print(point.y)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var currentKLineArray: [JSON]!  //定义一个当前数组
    var currentKLineArraydj: [JSON]!
    var currentAverageArray:[Double]!
    var currentAverageArray10:[Double]!
    var currentAverageArray20:[Double]!
    var currentAverageArray30:[Double]!
    //macd线
    var currentmacd:[Double]!
    var currentdea:[Double]!
    var currentdif:[Double]!
    var currentks:[Double]!
    var currentds:[Double]!
    var currentjs:[Double]!
    //displayrange 长度为60
    var count:Int!
    var begin:Int!
    var end:Int!
    
    
    var touchPoint1:CGPoint!
    
    //k线图区域分区设置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        
        let spaceX: CGFloat = 0 //空白x条
        let spaceY: CGFloat = 12 //空白y条
        //0.65 0.35 各自所占比例
        self.priceLineRect = CGRect(x: spaceX, y: spaceY*2, width: self.frame.width - spaceX * 2, height: (self.frame.height - spaceY * 4) * 0.65)
        self.volumeLineRect = CGRect(x: spaceX, y: self.priceLineRect.maxY + spaceY, width: self.frame.width - spaceX * 2, height: (self.frame.height - spaceY * 4) * 0.35)
        
        
        //        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureAction))
        //        self.addGestureRecognizer(longPressGesture)
        //        let tapSingle=UITapGestureRecognizer(target:self,action:#selector(tapSingleDid))
        //        tapSingle.numberOfTapsRequired=1
        //        tapSingle.numberOfTouchesRequired=1
        
        //初版ma均线及十字星日期时间及开高低收
        //        djma5.frame=CGRectMake(0, 0, 80, 10)
        //        djma5.text = "ma5"
        //        djma5.textColor = UIColor.clearColor()
        //        djma5.font = UIFont.systemFontOfSize(8)
        //        djma5.textAlignment=NSTextAlignment.Left
        //        addSubview(djma5)
        //
        //        djma10.frame=CGRectMake(80, 0, 70, 10)
        //        djma10.text = "ma10"
        //        djma10.textColor = UIColor.clearColor()
        //        djma10.font = UIFont.systemFontOfSize(8)
        //        djma10.textAlignment=NSTextAlignment.Left
        //        addSubview(djma10)
        //
        //        djma20.frame=CGRectMake(150, 0, 70, 10)
        //        djma20.text = "ma20"
        //        djma20.textColor = UIColor.clearColor()
        //        djma20.font = UIFont.systemFontOfSize(8)
        //        djma20.textAlignment=NSTextAlignment.Left
        //        addSubview(djma20)
        //
        //        djma30.frame=CGRectMake(220, 0, 70, 10)
        //        djma30.text = "ma30"
        //        djma30.textColor = UIColor.clearColor()
        //        djma30.font = UIFont.systemFontOfSize(8)
        //        djma30.textAlignment=NSTextAlignment.Left
        //        addSubview(djma30)
        //
        //        djlabel.frame=CGRectMake(0, spaceY, 60, 10)
        //        djlabel.text = "日期"
        //        djlabel.textColor = UIColor.clearColor()
        //        djlabel.font = UIFont.systemFontOfSize(10)
        //        djlabel.textAlignment=NSTextAlignment.Left
        //        addSubview(djlabel)
        //
        //        djkj.frame=CGRectMake(70, spaceY, self.frame.width, 10)
        //        djkj.text = "开价"
        //        djkj.textColor = UIColor.clearColor()
        //        djkj.font = UIFont.systemFontOfSize(10)
        //        djkj.textAlignment=NSTextAlignment.Left
        //        addSubview(djkj)
        
        djma5.frame=CGRectMake(UIScreen.mainScreen().bounds.width/5, spaceY/2, UIScreen.mainScreen().bounds.width/5, 20)
        djma5.text = "ma5"
        djma5.textColor = UIColor.clearColor()
        djma5.font = UIFont.systemFontOfSize(10)
        djma5.adjustsFontSizeToFitWidth=true
        djma5.textAlignment=NSTextAlignment.Left
        addSubview(djma5)
        
        djma10.frame=CGRectMake(UIScreen.mainScreen().bounds.width*2/5, spaceY/2, UIScreen.mainScreen().bounds.width/5, 20)
        djma10.text = "ma10"
        djma10.textColor = UIColor.clearColor()
        djma10.font = UIFont.systemFontOfSize(10)
        djma10.adjustsFontSizeToFitWidth=true
        djma10.textAlignment=NSTextAlignment.Left
        addSubview(djma10)
        
        djma20.frame=CGRectMake(UIScreen.mainScreen().bounds.width*3/5, spaceY/2, UIScreen.mainScreen().bounds.width/5, 20)
        djma20.text = "ma20"
        djma20.textColor = UIColor.clearColor()
        djma20.font = UIFont.systemFontOfSize(10)
        djma20.adjustsFontSizeToFitWidth=true
        djma20.textAlignment=NSTextAlignment.Left
        addSubview(djma20)
        
        djma30.frame=CGRectMake(UIScreen.mainScreen().bounds.width*4/5, spaceY/2, UIScreen.mainScreen().bounds.width/5, 20)
        djma30.text = "ma30"
        djma30.textColor = UIColor.clearColor()
        djma30.font = UIFont.systemFontOfSize(10)
        djma30.adjustsFontSizeToFitWidth=true
        djma30.textAlignment=NSTextAlignment.Left
        addSubview(djma30)
        
        djlabel.frame=CGRectMake(0, spaceY/2, UIScreen.mainScreen().bounds.width/5, 20)
        djlabel.text = "日期"
        djlabel.textColor = UIColor.clearColor()
        djlabel.font = UIFont.systemFontOfSize(10)
        djlabel.adjustsFontSizeToFitWidth=true
        djlabel.textAlignment=NSTextAlignment.Left
        addSubview(djlabel)
        
        djkj.frame=CGRectMake(70, spaceY, self.frame.width, 10)
        djkj.text = "开价"
        djkj.textColor = UIColor.clearColor()
        djkj.font = UIFont.systemFontOfSize(10)
        djkj.textAlignment=NSTextAlignment.Left
        addSubview(djkj)
        
        
        displayXline.backgroundColor = UIColor.clearColor()
        addSubview(displayXline)
        
        displayYline.backgroundColor = UIColor.clearColor()
        addSubview(displayYline)
        
        
        djsj.frame=CGRectMake(110, 0, 60, 10)
        djsj.text = "收价"
        djsj.textColor = UIColor.clearColor()
        djsj.font = UIFont.systemFontOfSize(10)
        djsj.textAlignment=NSTextAlignment.Left
        addSubview(djsj)
        
        djzg.frame=CGRectMake(170, 0, 60, 10)
        djzg.text = "最高"
        djzg.textColor = UIColor.clearColor()
        djzg.font = UIFont.systemFontOfSize(10)
        djzg.textAlignment=NSTextAlignment.Left
        addSubview(djzg)
        
        djzd.frame=CGRectMake(230, 0, 60, 10)
        djzd.text = "最低"
        djzd.textColor = UIColor.clearColor()
        djzd.font = UIFont.systemFontOfSize(10)
        djzd.textAlignment=NSTextAlignment.Left
        addSubview(djzd)
        
        djcjl.frame=CGRectMake(self.frame.width - 150 , self.volumeLineRect.minY, 150, 10)
        djcjl.text = "成交量"
        djcjl.textColor = UIColor.clearColor()
        djcjl.font = UIFont.systemFontOfSize(10)
        djcjl.textAlignment=NSTextAlignment.Right
        self.addSubview(djcjl)
        
        buttonall.frame=CGRectMake(0, self.priceLineRect.maxY - 50, 50, 50)
        //设置按钮文字
        buttonall.setBackgroundImage(UIImage(named:"btclose"),forState:.Normal)
        addSubview(buttonall)
        buttonall.addTarget(self,action:#selector(btall),forControlEvents:.TouchUpInside)
        
        
        buttonopen.frame=CGRectMake(self.frame.width/6*5, self.priceLineRect.maxY - 50, 50, 50)
        //设置按钮文字
        buttonopen.setBackgroundImage(UIImage(named:"opentoH"),forState:.Normal)
        addSubview(buttonopen)
        buttonopen.addTarget(self,action:#selector(btopen),forControlEvents:.TouchUpInside)
        
        
        
        buttonleft.frame=CGRectMake(self.frame.width/6, self.priceLineRect.maxY - 50, 50, 50)
        //设置按钮文字
        buttonleft.setBackgroundImage(UIImage(named:"newlefts100"),forState:.Normal)
        addSubview(buttonleft)
        buttonleft.addTarget(self,action:#selector(btleftdown),forControlEvents:.TouchDown)
        buttonleft.addTarget(self,action:#selector(btleft),forControlEvents:.TouchUpInside)
        //
        buttonright.frame=CGRectMake(self.frame.width/6*2, self.priceLineRect.maxY - 50, 50, 50)
        //设置按钮文字
        buttonright.setBackgroundImage(UIImage(named:"newrights100"),forState:.Normal)
        addSubview(buttonright);
        buttonright.addTarget(self,action:#selector(btrightdown),forControlEvents:.TouchDown)
        buttonright.addTarget(self,action:#selector(btright),forControlEvents:.TouchUpInside)
        
        buttonadd.frame=CGRectMake(self.frame.width/6*3, self.priceLineRect.maxY - 50, 50, 50)
        //        设置按钮文字
        buttonadd.setBackgroundImage(UIImage(named:"adds100"),forState:.Normal)
        addSubview(buttonadd);
        buttonadd.addTarget(self,action:#selector(btadd),forControlEvents:.TouchUpInside)
        
        buttonsub.frame=CGRectMake(self.frame.width/6*4, self.priceLineRect.maxY - 50, 50, 50)
        //设置按钮文字
        buttonsub.setBackgroundImage(UIImage(named:"subs100"),forState:.Normal)
        addSubview(buttonsub);
        buttonsub.addTarget(self,action:#selector(btsub),forControlEvents:.TouchUpInside)
        
        
        
        currentKLineArray=[]
        currentAverageArray=[]
        currentAverageArray10=[]
        currentAverageArray20=[]
        currentAverageArray30=[]
        //macd数据
        currentmacd=[]//macd线
        currentdea=[]
        currentdif=[]
        currentks=[]
        currentds=[]
        currentjs=[]
        
        
        if self.KLineArray == nil {
            
            return
        }
        count=self.KLineArray.data?.count
        begin=0
        end=0
        if count == 0 {
            
            
            return
            
        }
        if count < self.displayRange.length {
            begin=0
            end=count-1
            
            for i in begin...end{
                currentKLineArray.append(self.KLineArray.data![i])
                currentAverageArray.append(self.averageArray[i])
                currentAverageArray10.append(self.averageArray10[i])
                currentAverageArray20.append(self.averageArray20[i])
                currentAverageArray30.append(self.averageArray30[i])
                currentmacd.append(self.macdArrayMACDs[i])//macd线
                currentdea.append(self.macdArrayDEAs[i])
                currentdif.append(self.macdArrayDIFs[i])
                
                currentks.append(self.Arrayks[i])
                currentds.append(self.Arrayds[i])
                currentjs.append(self.Arrayjs[i])
                
            }
            
            
        }else{
            begin=count-60
            end=count-1
            
            for i in begin...end{
                currentKLineArray.append(self.KLineArray.data![i])
                currentAverageArray.append(self.averageArray[i])
                currentAverageArray10.append(self.averageArray10[i])
                currentAverageArray20.append(self.averageArray20[i])
                currentAverageArray30.append(self.averageArray30[i])
                currentmacd.append(self.macdArrayMACDs[i])//macd线
                currentdea.append(self.macdArrayDEAs[i])
                currentdif.append(self.macdArrayDIFs[i])
                
                currentks.append(self.Arrayks[i])
                currentds.append(self.Arrayds[i])
                currentjs.append(self.Arrayjs[i])
                
            }
            
            
        }
        
        
    }
    func tapSingleDid(){
        print("单击了")
    }
    
    
    
    
    
    //    var allklineArray:[JSON]!
    
    //绘制矩形
    override func drawRect(rect: CGRect) {
        
        
        
        if currentKLineArray.count==0{
            return}
        currentKLineArray.removeAll()
        currentAverageArray.removeAll()
        currentAverageArray10.removeAll()
        currentAverageArray20.removeAll()
        currentAverageArray30.removeAll()
        currentmacd.removeAll()//macd线
        currentdea.removeAll()
        currentdif.removeAll()
        currentks.removeAll()
        currentds.removeAll()
        currentjs.removeAll()
        for i in begin...end{
            currentKLineArray.append(self.KLineArray.data![i])
            currentAverageArray.append(self.averageArray[i])
            currentAverageArray10.append(self.averageArray10[i])
            currentAverageArray20.append(self.averageArray20[i])
            currentAverageArray30.append(self.averageArray30[i])
            currentmacd.append(self.macdArrayMACDs[i])//macd线
            currentdea.append(self.macdArrayDEAs[i])
            currentdif.append(self.macdArrayDIFs[i])
            currentks.append(self.Arrayks[i])
            currentds.append(self.Arrayds[i])
            currentjs.append(self.Arrayjs[i])
        }
        
        
        
        
        
        self.maxPrice = 0
        self.minPrice = Double(MAXFLOAT)
        
        
        self.maxVolume = 0
        //macd线
        self.maxmacd = 0
        self.minmacd = 0
        self.maxkdj = 0
        self.minkdj = 0
        self.maxkdj = Double(currentks[0])
        self.minkdj = Double(currentks[0])
        
        
        
        for index in 0..<currentKLineArray.count {
            
            //            let dataString = currentKLineArray[index][0].string!
            //            let kLineDic = getKLineDicFromString(dataString) //调用接口数据
            
            let maxPrice = Double(currentKLineArray[index][3].number!)
            
            let minPrice = Double(currentKLineArray[index][4].number!)
            let volume = Double(currentKLineArray[index][5].number!)
            //macd线
            let maxmacdvolume = Double(currentmacd[index])
            let minmacdvolume = Double(currentmacd[index])
            let maxdea = Double(currentdea[index])
            let mindea = Double(currentdea[index])
            let maxdif = Double(currentdif[index])
            let mindif = Double(currentdif[index])
            
            let maxks = Double(currentks[index])
            let minks = Double(currentks[index])
            let maxds = Double(currentds[index])
            let minds = Double(currentds[index])
            let maxjs = Double(currentjs[index])
            let minjs = Double(currentjs[index])
            //            self.maxkdj = Double(currentks[0])
            //            self.minkdj = Double(currentks[0])
            
            
            let maxaver = Double(currentAverageArray[index])
            let minaver = Double(currentAverageArray[index])
            let maxaver10 = Double(currentAverageArray10[index])
            let minaver10 = Double(currentAverageArray10[index])
            let maxaver20 = Double(currentAverageArray20[index])
            let minaver20 = Double(currentAverageArray20[index])
            let maxaver30 = Double(currentAverageArray30[index])
            let minaver30 = Double(currentAverageArray30[index])
            //重新定义最大价格值
            if maxPrice > self.maxPrice {
                
                self.maxPrice = maxPrice
                
            }
            if maxaver>self.maxPrice {
                self.maxPrice = maxaver
            }
            if maxaver10>self.maxPrice {
                self.maxPrice = maxaver10
            }
            if maxaver20>self.maxPrice {
                self.maxPrice = maxaver20
            }
            if maxaver30>self.maxPrice {
                self.maxPrice = maxaver30
            }
            //重新定义最小价格值
            if minPrice < self.minPrice {
                
                self.minPrice = minPrice
                
            }
            if minaver<self.minPrice {
                self.minPrice=minaver
            }
            if minaver10<self.minPrice {
                self.minPrice=minaver10
            }
            if minaver20<self.minPrice {
                self.minPrice=minaver20
            }
            if minaver30<self.minPrice {
                self.minPrice=minaver30
            }
            //重新定义最大量值
            if volume > self.maxVolume {
                self.maxVolume = volume
            }
            //macd线
            if maxmacdvolume > self.maxmacd {
                self.maxmacd = maxmacdvolume
            }
            if maxdea > self.maxmacd {
                self.maxmacd = maxdea
            }
            if maxdif > self.maxmacd {
                self.maxmacd = maxdif
            }
            if minmacdvolume < self.minmacd {
                self.minmacd = minmacdvolume
            }
            if mindea < self.minmacd {
                self.minmacd = mindea
            }
            if mindif < self.minmacd {
                self.minmacd = mindif
            }
            
            if maxks > self.maxkdj {
                self.maxkdj = maxks
            }
            if maxds > self.maxkdj {
                self.maxkdj = maxds
            }
            if maxjs > self.maxkdj {
                self.maxkdj = maxjs
            }
            if minks < self.minkdj {
                self.minkdj = minks
            }
            if minds < self.minkdj {
                self.minkdj = minds
            }
            if minjs < self.minkdj {
                self.minkdj = minjs
            }
            
            
        }
        
        if self.maxPrice == self.minPrice{
            self.maxPrice = self.maxPrice*3/2
            self.minPrice = self.minPrice/2
        }
        
        self.stepX = self.priceLineRect.width / CGFloat(self.displayRange.length)
        self.stepY = self.priceLineRect.height / CGFloat(self.maxPrice - self.minPrice)
        self.stepVolumeY = self.volumeLineRect.height / CGFloat(self.maxVolume)
        //macd线
        self.stepmacdY = self.volumeLineRect.height / CGFloat(self.maxmacd - self.minmacd)
        self.stepkdjY = self.volumeLineRect.height / CGFloat(self.maxkdj - self.minkdj)
        
        
        let accessroyLinePath = UIBezierPath() //开始绘图 框架
        let accessroyLinePath1 = UIBezierPath() //开始绘图 框架
        accessroyLinePath.moveToPoint(CGPoint(x: 0, y: self.priceLineRect.minY))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width, y: self.priceLineRect.minY))
        
        accessroyLinePath.moveToPoint(CGPoint(x: 0, y: (self.priceLineRect.minY + self.priceLineRect.midY)/2))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width, y: (self.priceLineRect.minY + self.priceLineRect.midY)/2))
        
        accessroyLinePath.moveToPoint(CGPoint(x: 0, y: self.priceLineRect.midY))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width, y: self.priceLineRect.midY))
        
        accessroyLinePath.moveToPoint(CGPoint(x: 0, y: (self.priceLineRect.maxY + self.priceLineRect.midY)/2))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width, y: (self.priceLineRect.maxY + self.priceLineRect.midY)/2))
        
        accessroyLinePath.moveToPoint(CGPoint(x: 0, y: self.priceLineRect.maxY))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width, y: self.priceLineRect.maxY))
        
        accessroyLinePath.moveToPoint(CGPoint(x: 0, y: self.volumeLineRect.minY))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width, y: self.volumeLineRect.minY))
        
        accessroyLinePath.moveToPoint(CGPoint(x: 0, y: self.volumeLineRect.maxY))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width, y: self.volumeLineRect.maxY))
        
        accessroyLinePath.moveToPoint(CGPoint(x: 0, y: (self.volumeLineRect.minY + self.volumeLineRect.maxY)/2))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width, y: (self.volumeLineRect.minY + self.volumeLineRect.maxY)/2))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: 0, y: self.priceLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: 0, y: self.priceLineRect.maxY))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: self.priceLineRect.maxX, y: self.priceLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: self.priceLineRect.maxX, y: self.priceLineRect.maxY))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: 0, y: self.volumeLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: 0, y: self.volumeLineRect.maxY))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: self.priceLineRect.maxX, y: self.volumeLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: self.priceLineRect.maxX, y: self.volumeLineRect.maxY))
        //
        //        accessroyLinePath.moveToPoint(CGPoint(x: rect.width / 4, y: self.priceLineRect.minY))
        //        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width / 4, y: self.volumeLineRect.maxY))
        //
        //        accessroyLinePath.moveToPoint(CGPoint(x: rect.width / 4 * 2, y: self.priceLineRect.minY))
        //        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width / 4 * 2, y: self.volumeLineRect.maxY))
        //
        //        accessroyLinePath.moveToPoint(CGPoint(x: rect.width / 4 * 3, y: self.priceLineRect.minY))
        //        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width / 4 * 3, y: self.volumeLineRect.maxY))
        UIColor.darkGrayColor().setStroke()//框架颜色grayColor
        accessroyLinePath.stroke()
        UIColor.darkGrayColor().setStroke()//框架颜色grayColor
        accessroyLinePath1.lineWidth = 2*accessroyLinePath.lineWidth
        accessroyLinePath1.stroke()
        
        
        
        //总文字信息
        let dateTextAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UIColor.whiteColor()]//下方时间数字字体信息 字体大小 字体颜色lightGrayColor
        
        //左下方日期
        var dateText1 = currentKLineArray[0][0].string!
        let indexdateText1=dateText1.startIndex.advancedBy(4)
        let indexdateText11=dateText1.startIndex.advancedBy(7)
        dateText1.insert("/",atIndex:indexdateText1)
        dateText1.insert("/",atIndex:indexdateText11)
        //let dateTextSize1 = dateText1.sizeWithAttributes(dateTextAttrs) //文本长度
        let dateText1Point = CGPoint(x: 0, y: self.priceLineRect.maxY)
        dateText1.drawAtPoint(dateText1Point, withAttributes: dateTextAttrs)
        
        //右下方日期
        var dateText2 = currentKLineArray[currentKLineArray.count-1][0].string!
        let indexdateText2=dateText2.startIndex.advancedBy(4)
        let indexdateText22=dateText2.startIndex.advancedBy(7)
        dateText2.insert("/",atIndex:indexdateText2)
        dateText2.insert("/",atIndex:indexdateText22)
        let dateTextSize2 = dateText2.sizeWithAttributes(dateTextAttrs)  //文本长度，需要再放置位置减去
        let dateText2Point = CGPoint(x: rect.width  - dateTextSize2.width / 2 - 30, y: self.priceLineRect.maxY)
        dateText2.drawAtPoint(dateText2Point, withAttributes: dateTextAttrs)
        
        //成交量及成交额
        var cjl = ""
        if zbsz == 1{
            cjl = "成交量"
        }else if zbsz == 2{
            cjl = "MACD"
        }else if zbsz == 3{
            cjl = "KDJ"
        }
        //        let cjl = "成交量"
        let cjlPoint = CGPoint(x: 0, y: self.volumeLineRect.minY)
        cjl.drawAtPoint(cjlPoint, withAttributes: dateTextAttrs)
        
        
        
        // 左方价格分割点的位置及显示
        let pric1 = String(format: "%.2f", maxPrice)
        let pric1Point = CGPoint(x: 0, y: self.priceLineRect.minY)
        pric1.drawAtPoint(pric1Point, withAttributes: dateTextAttrs)
        
        let pric15 = String(format: "%.2f", (maxPrice + (minPrice+maxPrice)/2)/2)
        let pric15Point = CGPoint(x: 0, y: (self.priceLineRect.minY + (self.priceLineRect.maxY + self.priceLineRect.minY)/2)/2)
        pric15.drawAtPoint(pric15Point, withAttributes: dateTextAttrs)
        
        let pric3 = String(format: "%.2f", (minPrice+maxPrice)/2)
        let pric3Point = CGPoint(x: 0, y: (self.priceLineRect.maxY + self.priceLineRect.minY)/2)
        pric3.drawAtPoint(pric3Point, withAttributes: dateTextAttrs)
        
        let pric25 = String(format: "%.2f", (minPrice + (minPrice+maxPrice)/2)/2)
        let pric25Point = CGPoint(x: 0, y: (self.priceLineRect.maxY + (self.priceLineRect.maxY + self.priceLineRect.minY)/2)/2)
        pric25.drawAtPoint(pric25Point, withAttributes: dateTextAttrs)
        
        let pric2 = String(format: "%.2f", minPrice)
        let pric2Point = CGPoint(x: 0, y: self.priceLineRect.maxY - 12)
        pric2.drawAtPoint(pric2Point, withAttributes: dateTextAttrs)
        
        
        
        
        let priceLinePath = UIBezierPath()
        priceLinePath.lineWidth = 0.5
        var avgprice5 = Double(self.currentAverageArray[0])
        var avgprice5X = self.priceLineRect.minX + self.stepX / 2
        var avgprice5Y = self.priceLineRect.minY + CGFloat(self.maxPrice - avgprice5) * self.stepY
        priceLinePath.moveToPoint(CGPoint(x: avgprice5X, y: avgprice5Y))
        
        let priceLinePath10 = UIBezierPath()
        priceLinePath10.lineWidth = 0.5
        var avgprice10 = Double(self.currentAverageArray10[0])
        var avgprice10X = self.priceLineRect.minX + self.stepX / 2
        var avgprice10Y = self.priceLineRect.minY + CGFloat(self.maxPrice - avgprice10) * self.stepY
        priceLinePath10.moveToPoint(CGPoint(x: avgprice10X, y: avgprice10Y))
        //
        let priceLinePath20 = UIBezierPath()
        priceLinePath20.lineWidth = 0.5
        var avgprice20 = Double(self.currentAverageArray20[0])
        var avgprice20X = self.priceLineRect.minX + self.stepX / 2
        var avgprice20Y = self.priceLineRect.minY + CGFloat(self.maxPrice - avgprice20) * self.stepY
        priceLinePath20.moveToPoint(CGPoint(x: avgprice20X, y: avgprice20Y))
        
        let priceLinePath30 = UIBezierPath()
        priceLinePath30.lineWidth = 0.5
        var avgprice30 = Double(self.currentAverageArray30[0])
        var avgprice30X = self.priceLineRect.minX + self.stepX / 2
        var avgprice30Y = self.priceLineRect.minY + CGFloat(self.maxPrice - avgprice30) * self.stepY
        priceLinePath30.moveToPoint(CGPoint(x: avgprice30X, y: avgprice30Y))
        
        //macd线
        //        let priceLinePathmacd = UIBezierPath()
        //        priceLinePathmacd.lineWidth = 0.5
        //        var macdline = Double(self.currentmacd[0])
        //        var macdlineX = self.volumeLineRect.minX + self.stepX / 2
        //        var macdlineY = self.volumeLineRect.minY + CGFloat(self.maxmacd - macdline) * self.stepmacdY
        //        priceLinePathmacd.moveToPoint(CGPoint(x: macdlineX, y: macdlineY))
        
        let priceLinePathdea = UIBezierPath()
        priceLinePathdea.lineWidth = 0.5
        var dealine = Double(self.currentdea[0])
        var dealineX = self.volumeLineRect.minX + self.stepX / 2
        var dealineY = self.volumeLineRect.minY + CGFloat(self.maxmacd - dealine) * self.stepmacdY
        priceLinePathdea.moveToPoint(CGPoint(x: dealineX, y: dealineY))
        
        let priceLinePathdif = UIBezierPath()
        priceLinePathdif.lineWidth = 0.5
        var difline = Double(self.currentdif[0])
        var diflineX = self.volumeLineRect.minX + self.stepX / 2
        var diflineY = self.volumeLineRect.minY + CGFloat(self.maxmacd - difline) * self.stepmacdY
        priceLinePathdif.moveToPoint(CGPoint(x: diflineX, y: diflineY))
        
        let priceLinePathks = UIBezierPath()
        priceLinePathks.lineWidth = 0.5
        var ksline = Double(self.currentks[0])
        var kslineX = self.volumeLineRect.minX + self.stepX / 2
        var kslineY = self.volumeLineRect.minY + CGFloat(self.maxkdj - ksline) * self.stepkdjY
        priceLinePathks.moveToPoint(CGPoint(x: kslineX, y: kslineY))
        
        let priceLinePathds = UIBezierPath()
        priceLinePathds.lineWidth = 0.5
        var dsline = Double(self.currentds[0])
        var dslineX = self.volumeLineRect.minX + self.stepX / 2
        var dslineY = self.volumeLineRect.minY + CGFloat(self.maxkdj - dsline) * self.stepkdjY
        priceLinePathds.moveToPoint(CGPoint(x: dslineX, y: dslineY))
        
        let priceLinePathjs = UIBezierPath()
        priceLinePathjs.lineWidth = 0.5
        var jsline = Double(self.currentjs[0])
        var jslineX = self.volumeLineRect.minX + self.stepX / 2
        var jslineY = self.volumeLineRect.minY + CGFloat(self.maxkdj - jsline) * self.stepkdjY
        priceLinePathjs.moveToPoint(CGPoint(x: jslineX, y: jslineY))
        
        
        //绘制日k数据 价格及量
        for index in 0..<currentKLineArray.count {
            
            //            let dataString = currentKLineArray[index] as! String
            //            let kLineDataDic = getKLineDicFromString(dataString)
            
            let maxPrice = Double(currentKLineArray[index][3].number!)
            avgprice5 = Double(currentAverageArray[index])
            avgprice10 = Double(currentAverageArray10[index])
            avgprice20 = Double(currentAverageArray20[index])
            avgprice30 = Double(currentAverageArray30[index])
            let minPrice = Double(currentKLineArray[index][4].number!)
            let openPrice = Double(currentKLineArray[index][1].number!)
            let closePrice = Double(currentKLineArray[index][2].number!)
            let volume = Double(currentKLineArray[index][5].number!)
            
            //macd线
            let macdline = Double(currentmacd[index])
            //            macdlineX = self.volumeLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            //            macdlineY = self.volumeLineRect.minY + CGFloat(self.maxmacd - macdline) * self.stepmacdY
            //            priceLinePathmacd.addLineToPoint(CGPoint(x: macdlineX, y: macdlineY))
            //            UIColor.redColor().setStroke()
            //            priceLinePathmacd.stroke()
            
            
            dealine = Double(currentdea[index])
            dealineX = self.volumeLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            dealineY = self.volumeLineRect.minY + CGFloat(self.maxmacd - dealine) * self.stepmacdY
            priceLinePathdea.addLineToPoint(CGPoint(x: dealineX, y: dealineY))
            UIColor.whiteColor().setStroke()
            if zbsz == 2{
                priceLinePathdea.stroke()
            }
            
            difline = Double(currentdif[index])
            diflineX = self.volumeLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            diflineY = self.volumeLineRect.minY + CGFloat(self.maxmacd - difline) * self.stepmacdY
            priceLinePathdif.addLineToPoint(CGPoint(x: diflineX, y: diflineY))
            color10.setStroke()
            if zbsz == 2{
                priceLinePathdif.stroke()
            }
            
            ksline = Double(currentks[index])
            kslineX = self.volumeLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            kslineY = self.volumeLineRect.minY + CGFloat(self.maxkdj - ksline) * self.stepkdjY
            priceLinePathks.addLineToPoint(CGPoint(x: kslineX, y: kslineY))
            UIColor.whiteColor().setStroke()
            if zbsz == 3{
                priceLinePathks.stroke()
            }
            
            dsline = Double(currentds[index])
            dslineX = self.volumeLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            dslineY = self.volumeLineRect.minY + CGFloat(self.maxkdj - dsline) * self.stepkdjY
            priceLinePathds.addLineToPoint(CGPoint(x: dslineX, y: dslineY))
            color10.setStroke()
            if zbsz == 3{
                priceLinePathds.stroke()
            }
            
            jsline = Double(currentjs[index])
            jslineX = self.volumeLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            jslineY = self.volumeLineRect.minY + CGFloat(self.maxkdj - jsline) * self.stepkdjY
            priceLinePathjs.addLineToPoint(CGPoint(x: jslineX, y: jslineY))
            color20.setStroke()
            if zbsz == 3{
                priceLinePathjs.stroke()
            }
            
            //绘制均线
            avgprice5X = self.priceLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            avgprice5Y = self.priceLineRect.minY + CGFloat(self.maxPrice - avgprice5) * self.stepY
            priceLinePath.addLineToPoint(CGPoint(x: avgprice5X, y: avgprice5Y))
            
            UIColor.whiteColor().setStroke()//5日均线颜色
            priceLinePath.stroke()
            
            avgprice10X = self.priceLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            avgprice10Y = self.priceLineRect.minY + CGFloat(self.maxPrice - avgprice10) * self.stepY
            priceLinePath10.addLineToPoint(CGPoint(x: avgprice10X, y: avgprice10Y))
            
            color10.setStroke()//10日均线颜色
            priceLinePath10.stroke()
            
            avgprice20X = self.priceLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            avgprice20Y = self.priceLineRect.minY + CGFloat(self.maxPrice - avgprice20) * self.stepY
            priceLinePath20.addLineToPoint(CGPoint(x: avgprice20X, y: avgprice20Y))
            
            color20.setStroke()//20日均线颜色
            priceLinePath20.stroke()
            
            avgprice30X = self.priceLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            avgprice30Y = self.priceLineRect.minY + CGFloat(self.maxPrice - avgprice30) * self.stepY
            priceLinePath30.addLineToPoint(CGPoint(x: avgprice30X, y: avgprice30Y))
            
            color30.setStroke()//30日均线颜色
            priceLinePath30.stroke()
            
            
            
            let currentX = self.priceLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            let maxPriceY = self.priceLineRect.minY + CGFloat(self.maxPrice - maxPrice) * self.stepY
            let minPriceY = self.priceLineRect.minY + CGFloat(self.maxPrice - minPrice) * self.stepY
            let openPriceY = self.priceLineRect.minY + CGFloat(self.maxPrice - openPrice) * self.stepY
            let closePriceY = self.priceLineRect.minY + CGFloat(self.maxPrice - closePrice) * self.stepY
            let volumeY = self.volumeLineRect.maxY - CGFloat(volume) * self.stepVolumeY
            //macd线
            let macdvolumezeroY = self.volumeLineRect.minY + CGFloat(self.maxmacd - 0) * self.stepmacdY
            let macdvolumeY = self.volumeLineRect.minY + CGFloat(self.maxmacd - macdline) * self.stepmacdY
            
            let macdvolumePath = UIBezierPath()
            macdvolumePath.moveToPoint(CGPoint(x: currentX, y: macdvolumeY))
            macdvolumePath.addLineToPoint(CGPoint(x: currentX, y: macdvolumezeroY))
            if self.stepX > 2{
                macdvolumePath.lineWidth = self.stepX - 1
            }else{
                macdvolumePath.lineWidth = self.stepX
            }
            if macdline > 0 {
                UP_COLOR.setStroke()
            }else{
                DOWN_COLOR.setStroke()
            }
            if zbsz == 2{
                macdvolumePath.stroke()
            }
            
            if openPrice > closePrice {
                
                DOWN_COLOR.setStroke()
                
                let upLinePath = UIBezierPath()
                upLinePath.moveToPoint(CGPoint(x: currentX, y: maxPriceY))
                upLinePath.addLineToPoint(CGPoint(x: currentX, y: openPriceY))
                upLinePath.stroke()
                
                let downLinePath = UIBezierPath()
                downLinePath.moveToPoint(CGPoint(x: currentX, y: closePriceY))
                downLinePath.addLineToPoint(CGPoint(x: currentX, y: minPriceY))
                downLinePath.stroke()
                
                let midPath = UIBezierPath()
                midPath.moveToPoint(CGPoint(x: currentX, y: openPriceY))
                midPath.addLineToPoint(CGPoint(x: currentX, y: closePriceY))
                midPath.lineWidth = self.stepX - SINGLE_LINE_WIDTH * 2
                midPath.stroke()
                
                let volumePath = UIBezierPath()
                volumePath.moveToPoint(CGPoint(x: currentX, y: volumeY))
                volumePath.addLineToPoint(CGPoint(x: currentX, y: self.volumeLineRect.maxY))
                if self.stepX > 2{
                    volumePath.lineWidth = self.stepX - 1
                }else{
                    volumePath.lineWidth = self.stepX
                }
                if zbsz == 1{
                    volumePath.stroke()
                }
                
            } else if openPrice < closePrice {
                
                UP_COLOR.setStroke()
                
                let upLinePath = UIBezierPath()  //最高线
                upLinePath.moveToPoint(CGPoint(x: currentX, y: maxPriceY))
                upLinePath.addLineToPoint(CGPoint(x: currentX, y: closePriceY))
                //                accessroyLinePath.stroke()
                upLinePath.stroke()
                
                let downLinePath = UIBezierPath()  //最低线
                downLinePath.moveToPoint(CGPoint(x: currentX, y: openPriceY))
                downLinePath.addLineToPoint(CGPoint(x: currentX, y: minPriceY))
                //                accessroyLinePath.stroke()
                downLinePath.stroke()
                
                let midPath = UIBezierPath()
                midPath.moveToPoint(CGPoint(x: currentX - (self.stepX - SINGLE_LINE_WIDTH * 2)/2, y: closePriceY))
                midPath.addLineToPoint(CGPoint(x: currentX - (self.stepX - SINGLE_LINE_WIDTH * 2)/2, y: openPriceY))
                
                midPath.moveToPoint(CGPoint(x: currentX - (self.stepX - SINGLE_LINE_WIDTH * 2)/2, y: closePriceY))
                midPath.addLineToPoint(CGPoint(x: currentX + (self.stepX - SINGLE_LINE_WIDTH * 2)/2, y: closePriceY))
                
                midPath.moveToPoint(CGPoint(x: currentX + (self.stepX - SINGLE_LINE_WIDTH * 2)/2, y: closePriceY))
                midPath.addLineToPoint(CGPoint(x: currentX + (self.stepX - SINGLE_LINE_WIDTH * 2)/2, y: openPriceY))
                
                midPath.moveToPoint(CGPoint(x: currentX - (self.stepX - SINGLE_LINE_WIDTH * 2)/2, y: openPriceY))
                midPath.addLineToPoint(CGPoint(x: currentX + (self.stepX - SINGLE_LINE_WIDTH * 2)/2, y: openPriceY))
                
                
                //                midPath.lineWidth = self.stepX - SINGLE_LINE_WIDTH * 2
                //                accessroyLinePath.stroke()
                midPath.stroke()
                
                
                let volumePath = UIBezierPath()
                volumePath.moveToPoint(CGPoint(x: currentX - (self.stepX - 1)/2, y: volumeY))
                volumePath.addLineToPoint(CGPoint(x: currentX - (self.stepX - 1)/2, y: self.volumeLineRect.maxY))
                
                volumePath.moveToPoint(CGPoint(x: currentX - (self.stepX - 1)/2, y: volumeY))
                volumePath.addLineToPoint(CGPoint(x: currentX + (self.stepX - 1)/2, y: volumeY))
                
                volumePath.moveToPoint(CGPoint(x: currentX - (self.stepX - 1)/2, y: self.volumeLineRect.maxY))
                volumePath.addLineToPoint(CGPoint(x: currentX + (self.stepX - 1)/2, y: self.volumeLineRect.maxY))
                
                volumePath.moveToPoint(CGPoint(x: currentX + (self.stepX - 1)/2, y: volumeY))
                volumePath.addLineToPoint(CGPoint(x: currentX + (self.stepX - 1)/2, y: self.volumeLineRect.maxY))
                
                
                //                volumePath.lineWidth = self.stepX - 1
                if zbsz == 1{
                    volumePath.stroke()
                }
                
            }else {
                
                UP_COLOR.setStroke()
                
                let upLinePath = UIBezierPath()
                upLinePath.moveToPoint(CGPoint(x: currentX, y: maxPriceY))
                upLinePath.addLineToPoint(CGPoint(x: currentX, y: closePriceY))
                upLinePath.stroke()
                
                let downLinePath = UIBezierPath()
                downLinePath.moveToPoint(CGPoint(x: currentX, y: openPriceY))
                downLinePath.addLineToPoint(CGPoint(x: currentX, y: minPriceY))
                downLinePath.stroke()
                
                let midPath = UIBezierPath()
                midPath.moveToPoint(CGPoint(x: currentX - self.stepX / 2 + SINGLE_LINE_WIDTH, y: closePriceY))
                midPath.addLineToPoint(CGPoint(x: currentX + self.stepX / 2 - SINGLE_LINE_WIDTH, y: openPriceY))
                midPath.stroke()
                
                let volumePath = UIBezierPath()
                volumePath.moveToPoint(CGPoint(x: currentX - (self.stepX - 1)/2, y: volumeY))
                volumePath.addLineToPoint(CGPoint(x: currentX - (self.stepX - 1)/2, y: self.volumeLineRect.maxY))
                
                volumePath.moveToPoint(CGPoint(x: currentX - (self.stepX - 1)/2, y: volumeY))
                volumePath.addLineToPoint(CGPoint(x: currentX + (self.stepX - 1)/2, y: volumeY))
                
                volumePath.moveToPoint(CGPoint(x: currentX - (self.stepX - 1)/2, y: self.volumeLineRect.maxY))
                volumePath.addLineToPoint(CGPoint(x: currentX + (self.stepX - 1)/2, y: self.volumeLineRect.maxY))
                
                volumePath.moveToPoint(CGPoint(x: currentX + (self.stepX - 1)/2, y: volumeY))
                volumePath.addLineToPoint(CGPoint(x: currentX + (self.stepX - 1)/2, y: self.volumeLineRect.maxY))
                
                
                //                volumePath.lineWidth = self.stepX - 1
                if zbsz == 1{
                    volumePath.stroke()
                }
                
                
            }
            
            
            let pointX1 = CGFloat(0) * self.stepX + self.stepX / 2
            let pointY1 = self.priceLineRect.minY + CGFloat(self.maxPrice*2/3) * self.stepY
            touchPoint1 = CGPoint(x: pointX1,y: pointY1)
            self.getTouchPoint(touchPoint1)
            self.setFrame()//设定十字星位置
            self.removeDisplayView()//移除
            self.djkj.textColor=UIColor.clearColor()
            self.djlabel.textColor=UIColor.clearColor()
            self.djma5.textColor=UIColor.clearColor()
            self.djma10.textColor=UIColor.clearColor()
            self.djma20.textColor=UIColor.clearColor()
            self.djma30.textColor=UIColor.clearColor()
            
            
            
        }
    }
    
    
    //数组数据的调用借口
    func getKLineDicFromString(string: String) -> NSDictionary {
        
        let keyArray = ["date", "time", "open", "max", "min", "close", "amount", "volume", "hold", "preClose"]
        var keyArrayIndex = 0
        let KLineDic = NSMutableDictionary()
        
        var preIndex = string.startIndex
        
        for index in string.startIndex..<string.endIndex{
            
            if string[index] == "-" {
                
                let subString = string.substringWithRange(Range<String.Index>(preIndex..<index))
                let key  = keyArray[keyArrayIndex]
                KLineDic.setValue(subString, forKey: key)
                keyArrayIndex += 1
                preIndex = index.advancedBy(1)
            }
        }
        
        return KLineDic
    }
    //点击事件
    var displayLineView: UIView!
    var displayXline = UILabel()
    var displayLineYView: UIView!
    var displayYline = UILabel()
    var movePoint: CGPoint!
    func longPressGestureAction(sender: UILongPressGestureRecognizer)  //长按事件
    {
        //        if averageArray.count<=0 {
        //            return
        //        }
        
        
        
        let touchPoint = sender.locationInView(self)
        
        if sender.state == .Began//开始按
        {
            if self.getTouchPoint(touchPoint)
            {
                g2.isDo = false//关闭g2自动刷新
                screenViewController.isDo = false//关闭screenViewController自动刷新
                self.removeDisplayView()//移除
                //                self.addDisplayView()//加载
                self.setFrame()//设定十字星位置
                if klineremovesetisDo == true
                {
                    klineremoveset.invalidate()
                    klineremovesetisDo = false
                }
            }
            
        }else if sender.state == .Changed//滑动
        {
            if self.getTouchPoint(touchPoint)
            {
                self.setFrame()//设定十字星位置
                
                
            }
            
        }else if sender.state == .Ended || sender.state == .Cancelled//手指松开
        {
            
            
            klineremoveset = NSTimer.scheduledTimerWithTimeInterval(10,target:self,selector:#selector(removeDisplayViewkl),userInfo:nil,repeats:false)
            klineremovesetisDo = true
            
            //            self.removeDisplayView()//移除
            
        }
        
    }
    
    func removeDisplayViewkl()
    {
        
        displayXline.backgroundColor = UIColor.clearColor()
        
        displayYline.backgroundColor = UIColor.clearColor()
        self.djlabel.textColor = UIColor.clearColor()
        self.djma5.textColor = UIColor.clearColor()
        self.djma10.textColor = UIColor.clearColor()
        self.djma20.textColor = UIColor.clearColor()
        self.djma30.textColor = UIColor.clearColor()
        self.djcjl .textColor = UIColor.clearColor()
        self.djkj.textColor = UIColor.clearColor()

        
        //十字星移除时启动页面自动刷新
        if g2.isDo == false
        {
            g2.isDo = true
        }
        
        if screenViewController.isDo == false
        {
            screenViewController.isDo = true
        }
        
        
        
        
    }
    
    func addDisplayView()
    {
        self.displayXline.backgroundColor = UIColor.cyanColor()
        addSubview(displayXline)
        
        self.displayYline.backgroundColor = UIColor.redColor()
        addSubview(displayYline)
        
        //        self.displayLineView = UIView()
        //        self.displayLineView.backgroundColor = UIColor.cyanColor()//X轴
        //        self.addSubview(self.displayLineView)
        //
        //        self.displayLineYView = UIView()
        //        self.displayLineYView.backgroundColor = UIColor.redColor()//Y轴
        //        self.addSubview(self.displayLineYView)
        
    }
    
    func removeDisplayView()
    {
        
        displayXline.backgroundColor = UIColor.clearColor()
        
        displayYline.backgroundColor = UIColor.clearColor()
        
        //        if self.displayLineView == nil {
        //            return
        //        }
        //        self.displayLineView.removeFromSuperview()
        //        self.displayLineView = nil
        //
        //        self.displayLineYView.removeFromSuperview()
        //        self.displayLineYView = nil
        
    }
    
    
    func setFrame()
    {
        
        //        self.displayXline.backgroundColor = UIColor.cyanColor()
        //        addSubview(displayXline)
        //
        //        self.displayYline.backgroundColor = UIColor.redColor()
        //        addSubview(displayYline)
        displayXline.backgroundColor = UIColor.cyanColor()//竖线
        displayYline.backgroundColor = UIColor.redColor()//横线
        displayXline.frame = CGRect(x: self.movePoint.x, y: 24, width: 1, height: self.volumeLineRect.maxY - 24)
        displayYline.frame = CGRect(x: 0, y: self.movePoint.y, width: self.priceLineRect.maxX, height: 1)
        //        self.displayLineView.frame = CGRect(x: self.movePoint.x, y: 15, width: 1, height: self.volumeLineRect.maxY - 15)
        //        self.displayLineYView.frame = CGRect(x: 0, y: self.movePoint.y, width: self.priceLineRect.maxX, height: 1)
    }
    
    func getTouchPoint(touchPoint: CGPoint) -> Bool
    {

        
        if self.currentKLineArray == nil
        {
            return false
        }
        
        if self.currentKLineArray.count == 0
        {
            return false
        }
        
        var indexdj = Int(touchPoint.x / self.stepX)
        
        if indexdj>currentKLineArray.count {
            return false
        }
        
        if indexdj < 0 || indexdj > currentKLineArray.count - 1
        {
            return false
        }
        let indexdj1 = indexdj
        indexdj = indexdj + begin
        
        
        let priceDic = self.KLineArray.data![indexdj]
        let price = Double(priceDic[1].number!)
        var touchdate = priceDic[0].string!
        let touchdate1=touchdate.startIndex.advancedBy(4)
        let touchdate11=touchdate.startIndex.advancedBy(7)
        touchdate.insert("/",atIndex:touchdate1)
        touchdate.insert("/",atIndex:touchdate11)
        let kj = Double(priceDic[1].number!)
        let sj = Double(priceDic[2].number!)
        let zg = Double(priceDic[3].number!)
        let zd = Double(priceDic[4].number!)
        let cjln1 = Double(priceDic[5].number!)
        let djm5 = Double(currentAverageArray[indexdj1])
        let djm10 = Double(currentAverageArray10[indexdj1])
        let djm20 = Double(currentAverageArray20[indexdj1])
        let djm30 = Double(currentAverageArray30[indexdj1])
        
        screenViewController.cjlview.cjl = GloMethod.djchangeStrToShou(String(Double(priceDic[5].number!)/100))
        
        if g2.todayOpen.text == String(kj){
            cjlbool = true
            g2.cjlview.cjl = GloMethod.djchangeStrToShou(String(Double(priceDic[5].number!)/100))
        }else if cjlbool == true{
            g2.cjlview.cjl = GloMethod.djchangeStrToShou(String(Double(priceDic[5].number!)/100))
        }

        

    

        
        changeTop?.changeTopData(zg,low: zd, cjl: cjln1, Open: kj, close: sj)
        
        
        //        let zhangdie = price-self.preClosePrice
        //        let cjlnum = Double(priceDic[3].number!)
        let pointX = CGFloat(indexdj1) * self.stepX + self.stepX / 2
        let pointY = self.priceLineRect.minY + CGFloat(self.maxPrice - sj) * self.stepY
        
        //        //改变数据
        self.djma5.textColor = UIColor.whiteColor()
        self.djma5.text = "MA5:" + String(format: "%.2f",djm5)
        
        self.djma10.textColor = color10
        self.djma10.text = "MA10:" + String(format: "%.2f",djm10)
        
        self.djma20.textColor = color20
        self.djma20.text = "MA20:" + String(format: "%.2f",djm20)
        
        self.djma30.textColor = color30
        self.djma30.text = "MA30:" + String(format: "%.2f",djm30)
        
        self.djlabel.textColor = UIColor.whiteColor()
        self.djlabel.text = String(touchdate) + " 均线"
        self.djlabel.textColor = UIColor.whiteColor()
        //十字星每日开高低收价
        //        self.djkj.text = "开" + String(kj)+"高" + String(zg)+"低" + String(zd)+"收" + String(sj)
        //        self.djkj.textColor = UIColor.whiteColor()
        
        //        self.djsj.text = "收" + String(sj)
        //        self.djsj.textColor = UIColor.whiteColor()
        //        self.djzg.text = "高" + String(zg)
        //        self.djzg.textColor = UIColor.whiteColor()
        //        self.djzd.text = "低" + String(zd)
        //        self.djzd.textColor = UIColor.whiteColor()
        self.djcjl.textColor = UIColor.clearColor()
        if zbsz == 1{
            self.djcjl.text = GloMethod.djchangeStrToShou(String(Double(priceDic[5].number!)/100))//String(cjln1)
            self.djcjl.textColor = UIColor.whiteColor()
        }
        
        
        
        self.movePoint = CGPoint(x: pointX, y: pointY)
        
        
        
        return true
        
    }
    
    
    
    func btopen(){
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeLeft.rawValue, forKey: "orientation")
        screenViewController.kviewisno = true
        jumpToHeng!.jump()
        
        
    }
    //    点击事件
    //    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    //        for touch: AnyObject in touches {
    //            let t:UITouch = touch as! UITouch
    //
    //            //获取触摸点坐标
    //            let firstPoint = t.locationInView(self)
    //            self.getPoint(firstPoint)
    ////            self.removeDisplayView()//移除
    ////            self.addDisplayView()//加载
    ////            self.setFrame()//设定十字星位置
    //
    //            print(firstPoint)
    //        }
    //    }
    
    //    func getPoint(touchPoint: CGPoint) -> Bool{
    //        let pointindex = Int(touchPoint.x / self.stepX)
    //
    //        let priceDic = currentKLineArray[pointindex]
    //        let price = Double(priceDic[1].number!)
    //        let touchdate = priceDic[0].string!
    //        print(touchdate)
    //        print(currentKLineArray.count)
    //        let kj = Double(priceDic[1].number!)
    //        let sj = Double(priceDic[2].number!)
    //        let zg = Double(priceDic[3].number!)
    //        let zd = Double(priceDic[4].number!)
    //        let cjln1 = Double(priceDic[5].number!)
    //
    ////        let pointX = CGFloat(pointindex) * self.stepX + self.stepX / 2
    ////        let pointY = self.priceLineRect.minY + CGFloat(self.maxPrice - price) * self.stepY
    ////
    ////        self.movePoint = CGPoint(x: pointX, y: pointY)
    //
    //        return true
    //    }
    func btall(){
        if buttonallisDo{
            buttonleft.hidden = true
            buttonright.hidden = true
            buttonadd.hidden = true
            buttonsub.hidden = true
            buttonopen.hidden = true
            //            buttonright.setBackgroundImage(UIImage(named:"newrights100"),forState:.Normal)
            buttonall.setBackgroundImage(UIImage(named:"btopen"),forState:.Normal)
            buttonallisDo = false
        }else {
            buttonleft.hidden = false
            buttonright.hidden = false
            buttonadd.hidden = false
            buttonsub.hidden = false
            buttonopen.hidden = false
            buttonall.setBackgroundImage(UIImage(named:"btclose"),forState:.Normal)
            buttonallisDo = true
        }
        
        
        //        self.setNeedsDisplay()
        
    }
    
    func btleftdown(){
        self.removeGestureRecognizer(longPressGesture)
        timer = 0.02
        if end - begin <= 15{
            timer = 0.1
        }else if end - begin <= 30{
            timer = 0.05
        }else if end - begin >= 90{
            timer = 0.005
        }else if end - begin >= 120{
            timer = 0.002
        }
        
        
        lefttimer = NSTimer.scheduledTimerWithTimeInterval(timer,target:self,selector:#selector(KlineView.lefttick),userInfo:nil,repeats:true)
        
    }
    
    func lefttick()
    {
        if count<=60{
            
        }
        else if begin>=2{//self.displayRange.length {
            begin=begin-1//self.displayRange.length
            end=end-1//self.displayRange.length
            
        }else {
            begin=0
            end=self.displayRange.length - 1
            
        }
        
        
        self.setNeedsDisplay()
    }
    
    
    
    
    
    func btleft(){
        lefttimer.invalidate()
        self.addGestureRecognizer(longPressGesture)
        
        if count<=60{
            
        }
        else if begin>=2{//self.displayRange.length {
            begin=begin-1//self.displayRange.length
            end=end-1//self.displayRange.length
            
        }else {
            begin=0
            end=self.displayRange.length - 1
            
        }
        
        
        self.setNeedsDisplay()
        
    }
    
    func btrightdown(){
        self.removeGestureRecognizer(longPressGesture)
        timer = 0.02
        if end - begin <= 15{
            timer = 0.1
        }else if end - begin <= 30{
            timer = 0.05
        }else if end - begin >= 90{
            timer = 0.005
        }else if end - begin >= 120{
            timer = 0.002
        }
        righttimer = NSTimer.scheduledTimerWithTimeInterval(timer,target:self,selector:#selector(KlineView.righttick),userInfo:nil,repeats:true)
        
    }
    
    func righttick()
    {
        
        
        if count<=60{
        }else if count - end >= 2{//self.displayRange.length{
            end=end+1//self.displayRange.length
            begin=begin+1//self.displayRange.length
            
        }else {
            begin = count - self.displayRange.length
            end = count  - 1
            
            
            
        }
        
        
        self.setNeedsDisplay()
    }
    
    
    func btright(){
        righttimer.invalidate()
        self.addGestureRecognizer(longPressGesture)
        
        if count<=60{
        }else if count - end >= 2{//self.displayRange.length{
            end=end+1//self.displayRange.length
            begin=begin+1//self.displayRange.length
            
        }else {
            begin = count - self.displayRange.length
            end = count  - 1
            
            
            
        }
        
        //        else if (end+30)<=(count-1){
        //            end=end+30
        //            begin=begin+30
        //
        //        }else if (end+30)>(count-1){
        //            begin = count - self.displayRange.length
        //            end = count  - 1
        //
        //
        //
        //        }
        
        
        self.setNeedsDisplay()
        
        
    }
    
    
    func btadd(){
        
        
        if count<=60{
            
            
        }else if self.displayRange.length == 30{
            begin=begin+15
            self.displayRange.length = self.displayRange.length - 15
            
        }else if self.displayRange.length == 60{
            begin=begin+30
            self.displayRange.length = self.displayRange.length - 30
            
        }else if self.displayRange.length>60{
            begin=begin+30
            self.displayRange.length = self.displayRange.length - 30
            
        }else {
            //            self.addGestureRecognizer(longPressGesture)
            
        }
        
        
        self.setNeedsDisplay()
    }
    
    func btsub(){
        
        if count<=60{
            
            
            
        }
        else if self.displayRange.length == 15 {
            begin=begin-15
            self.displayRange.length = self.displayRange.length + 15
            
        }
        else if self.displayRange.length == 30 {
            begin=begin-30
            self.displayRange.length = self.displayRange.length + 30
            
        }
        else if begin>=30 {
            begin=begin-30
            self.displayRange.length = self.displayRange.length + 30
            
        }else {
            begin=0
            
        }
        //        self.removeDisplayView()//移除
        //        self.removeGestureRecognizer(longPressGesture)
        
        self.setNeedsDisplay()
        
    }
    
    //    //MARK: - Property
    //    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
    //    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
    //
    let SINGLE_LINE_WIDTH = 1.0 / UIScreen.mainScreen().scale
    //
    //    let APP_MAIN_COLOR = UIColor(red: 255/255.0, green: 115/255.0, blue: 96/255.0, alpha: 1.0)
    //
    //    let BLUE_COLOR = UIColor(red: 102/255.0, green: 204/255.0, blue: 238/255.0, alpha: 1.0)
    //    let YELLOW_COLOR = UIColor(red: 251/255.0, green: 151/255.0, blue: 85/255.0, alpha: 1.0)
    //
    //    let BACKGROUND_COLOR = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
    //    let HIGHLIGHTED_COLOR = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
    //
    //    let CELL_COLOR_LIGHT = UIColor.whiteColor()
    //    let CELL_COLOR_DARK = UIColor(red: 27/255.0, green: 27/255.0, blue: 27/255.0, alpha: 1.0)
    //
    //    let SELECTED_COLOR_LIGHT = UIColor(red: 218/255.0, green: 218/255.0, blue: 218/255.0, alpha: 1.0)
    //    let SELECTED_COLOR_DARK = UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0)
    //
    //    let SECTIONHEADER_COLOR_LIGHT = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1.0)
    //    let SECTIONHEADER_COLOR_DARK = UIColor(red: 27/255.0, green: 27/255.0, blue: 27/255.0, alpha: 1.0)
    //
    //    let SEPARATOR_COLOR_LIGHT = UIColor(red: 218/255.0, green: 218/255.0, blue: 218/255.0, alpha: 1.0)
    //    let SEPARATOR_COLOR_DARK = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1.0)
    //
    let UP_COLOR = UIColor(red: 216/255, green: 51/255, blue: 55/255, alpha: 1.0)
    let DOWN_COLOR = UIColor(red: 70/255.0, green: 253/255.0, blue: 255/255.0, alpha: 1.0)
    //
    //    //1.0
    //    let LINE_GRAY_COLOR = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
    //    let MY_YELLOW_COLOR = UIColor(red: 248/255.0, green: 181/255.0, blue: 81/255.0, alpha: 1.0)
    //    let MY_BLUE_COLOR = UIColor(red: 126/255.0, green: 206/255.0, blue: 244/255.0, alpha: 1.0)
    //    let MY_GREEN_COLOR = UIColor(red: 179/255.0, green: 212/255.0, blue: 101/255.0, alpha: 1.0)
    //    let MY_PING_COLOR = UIColor(red: 234/255.0, green: 156/255.0, blue: 194/255.0, alpha: 1.0)
    //    let PATH_DOCUMENTS = NSHomeDirectory() + "/Documents/"
    //    let PATH_LIBRARY = NSHomeDirectory() + "/Library/"
    //    let PATH_CACHE = NSHomeDirectory() + "/Library/Caches/"
    //    let fundTypeCodeToTitle = ["1101": "股票型", "1103": "混合型", "1105": "债券型", "1106": "短期理财", "1107": "保本型", "1109": "货币型", "1110": "QDII"]
    //    let conditionToTitle = ["1": "日涨幅", "2": "月涨幅", "3": "季涨幅", "4": "半年涨幅", "5": "一年涨幅", "6": "七日年化", "7": "万份收益", "8": "单位净值"]
    //    //1.0 Notifications
    //    let SelfSelectStockDidChangedNotification = "SelfSelectStockDidChangedNotification"
    //    let SelfSelectFundDidChangedNotification = "SelfSelectFundDidChangedNotification"
    //
    //    let CenterAccountLoginSucceedNotification = "CenterAccountLoginSucceedNotification"
    //    let CenterAccountLogoutSucceedNotification = "CenterAccountLogoutSucceedNotification"
    //    let PlatformAccountLoginSucceedNotification = "PlatformAccountLoginSucceedNotification"
    //    let PlatformAccountLogoutSucceedNotification = "PlatformAccountLogoutSucceedNotification"
    //
    //    let FundCollectSucceedNotification = "FundCollectSucceedNotification"
    //    let FundCancelCollectSucceedNotification = "FundCancelCollectSucceedNotification"
    //
    //    let FundTradeSucceedNotification = "FundTradeSucceedNotification"
    //
    //    let FundBuySucceedNotification = "FundBuySucceedNotification"
    //    let FundSaleSucceedNotification = "FundSaleSucceedNotification"
    //    let FundTransferSucceedNotification = "FundTransferSucceedNotification"
    //    let FundDividendModifySucceedNotification = "FundDividendModifySucceedNotification"
    //
    //    let MoneyInSucceedNotification = "MoneyInSucceedNotification"
    //    let MoneyOutSucceedNotification = "MoneyOutSucceedNotification"
    //
    //    //MARK: - Method
    //    //金额格式
    //    func getMoneyString(money: Double) -> String
    //    {
    //        return String(format: "%.2f", money)
    //    }
    //
    //    //成交量格式
    //    func getVolumeString(volume: Double) -> String
    //    {
    //        return String(format: "%.0f", volume)
    //    }
    //
    //    //股票数量格式
    //    func getStockCountString(count: Double) -> String
    //    {
    //        return String(format: "%.0f", count)
    //    }
    //
    //    //基金份额格式
    //    func getFundCountString(count: Double) -> String
    //    {
    //        return String(format: "%.2f", count)
    //    }
    //
    //    //率格式
    //    func getRateString(doubleValue: Double) -> String
    //    {
    //        return String(format: "%.2f", doubleValue) + "%"
    //    }
    //    // 千分位算法
    //    func getPerMilString(str: String) -> String
    //    {
    //        let formatter = NSNumberFormatter()
    //        let nsnum = formatter.numberFromString(str)
    //        formatter.numberStyle = .DecimalStyle
    //        let milString = formatter.stringFromNumber(nsnum!)
    //        return milString!
    //
    //    }
    //    //1.0老方法
    //    func getGrowthColor(doubleValue: Double) -> UIColor
    //    {
    //        if doubleValue > 0
    //        {
    //            return UP_COLOR
    //        }
    //        else if doubleValue < 0
    //        {
    //            return DOWN_COLOR
    //        }
    //        else
    //        {
    //            return UIColor.lightGrayColor()
    //        }
    //    }
    //
    //    func getGrowthColorFromString(string: String) -> UIColor
    //    {
    //        if string == "--"
    //        {
    //            return UIColor.lightGrayColor()
    //        }
    //        else if string.hasPrefix("-")
    //        {
    //            return DOWN_COLOR
    //        }
    //        else if string.hasPrefix("0.00")
    //        {
    //            return UIColor.lightGrayColor()
    //        }
    //        else
    //        {
    //            return UP_COLOR
    //        }
    //    }
    //
    //    func getContentText(string: String?) -> String
    //    {
    //        if string == nil
    //        {
    //            return "--"
    //        }
    //
    //        if string!.isEmpty
    //        {
    //            return "--"
    //        }
    //
    //        return string!
    //    }
    //
    //    func getRiskLevelColor(string: String?) -> UIColor
    //    {
    //        if string == nil
    //        {
    //            return UIColor.blackColor()
    //        }
    //
    //        if string == "高风险"
    //        {
    //            return UP_COLOR
    //        }
    //
    //        if string == "低风险"
    //        {
    //            return DOWN_COLOR
    //        }
    //
    //        return UIColor.blackColor()
    //    }
    //
    //    func getProfitColor(string: String?) -> UIColor
    //    {
    //        if string == nil
    //        {
    //            return UIColor.blackColor()
    //        }
    //
    //        if string == "--"
    //        {
    //            return UIColor.blackColor()
    //        }
    //
    //        if string!.hasPrefix("-")
    //        {
    //            return DOWN_COLOR
    //        }
    //        else
    //        {
    //            return UP_COLOR
    //        }
    //    }
    //
    //    func checkMoneyFormat(text: String) -> Bool
    //    {
    //        if (text as NSString).doubleValue == 0
    //        {
    //            return false
    //        }
    //
    //        let regularExpression = "[1-9]\\d*(\\.\\d{1,2})?|0\\.\\d{1,2}"
    //
    //        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
    //
    //        return predicate.evaluateWithObject(text)
    //    }
    //
    //    //get file path
    //    func getSelfSelectStockListCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Documents/SelfSelectStockList.plist"
    //    }
    //
    //    func getSelfSelectFundListCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Documents/SelfSelectFundList.plist"
    //    }
    //
    //    func getStockSearchHistoryCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Documents/StockSearchHistory.plist"
    //    }
    //
    //    func getFundSearchHistoryCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Documents/FundSearchHistory.plist"
    //    }
    //
    //    func getStockSnapShotCachePath(exchangeCode: String, stockCode: String) -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockSnapShot_\(exchangeCode)\(stockCode).plist"
    //    }
    //
    //    func getStockTimeLineCachePath(exchangeCode: String, stockCode: String) -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockTimeLine_\(exchangeCode)\(stockCode).plist"
    //    }
    //
    //    func getStockTickCachePath(exchangeCode: String, stockCode: String) -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockTick_\(exchangeCode)\(stockCode).plist"
    //    }
    //
    //    func getStockKLineCachePath(exchangeCode: String, stockCode: String, timeType: String, fixType: String) -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockKLine_\(exchangeCode)\(stockCode)_\(timeType)_\(fixType).plist"
    //    }
    //
    //    func getStockIndexSummaryCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockIndexSummary.plist"
    //    }
    //
    //    func getStockIndustryRankCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockIndustryRank.plist"
    //    }
    //
    //    func getStockConceptRankCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockConceptRank.plist"
    //    }
    //
    //    func getStockUpDownRateRankRiseCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockUpDownRateRankRise.plist"
    //    }
    //
    //    func getStockUpDownRateRankDownCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockUpDownRateRankDown.plist"
    //    }
    //
    //    func getStockTurnOverRateRankCachePath() -> String
    //    {
    //        return NSHomeDirectory() + "/Library/Caches/StockTurnOverRateRank.plist"
    //    }
    //
    //    func getCenterAccountInfoCachePath() -> String
    //    {
    //        if let userID = NSUserDefaults.standardUserDefaults().stringForKey("userID")
    //        {
    //            return NSHomeDirectory() + "/Documents/CenterAccountInfo_\(userID).plist"
    //        }
    //        else
    //        {
    //            return NSHomeDirectory() + "/Documents/CenterAccountInfo.plist"
    //        }
    //    }
    //
    //    func getPlatformAccountInfoCachePath() -> String
    //    {
    //        if let clientNumber = NSUserDefaults.standardUserDefaults().stringForKey("clientNumber")
    //        {
    //            return NSHomeDirectory() + "/Documents/PlatformAccountInfo_\(clientNumber).plist"
    //        }
    //        else
    //        {
    //            return NSHomeDirectory() + "/Documents/PlatformAccountInfo.plist"
    //        }
    //    }
    //
    //    func getPlatformAccountAssetCachePath() -> String
    //    {
    //        if let clientNumber = NSUserDefaults.standardUserDefaults().stringForKey("clientNumber")
    //        {
    //            return NSHomeDirectory() + "/Library/Caches/PlatformAccountAsset_\(clientNumber).plist"
    //        }
    //        else
    //        {
    //            return NSHomeDirectory() + "/Library/Caches/PlatformAccountAsset.plist"
    //        }
    //    }
    //    
    //    func getStockStatusNameByCode(code: String) -> String
    //    {
    //        let dic = ["0": "停牌", "1": "退市", "2": "正常"]
    //        
    //        if let status = dic[code]
    //        {
    //            return status
    //        }
    //        else
    //        {
    //            return "未知"
    //        }
    //    }
    //    
    //    func getExchangeStatusNameByCode(code: String) -> String
    //    {
    //        let dic = ["0": "集合竞价", "1": "交易中", "2": "午间休市", "3": "已收盘", "4": "未开盘", "5": "休市"]
    //        
    //        if let status = dic[code]
    //        {
    //            return status
    //        }
    //        else
    //        {
    //            return "未知"
    //        }
    //    }
    //    
    //    //date format is yyyyMMdd type 1: yyyy-mm-dd type 2: mm-dd type 3: yyyy-mm
    //    func getDateString(date: String, type: String = "2") -> String
    //    {
    //        let yearRange = Range<String.Index>( date.startIndex.advancedBy(0)..<date.startIndex.advancedBy(4))
    //        let monthRange = Range<String.Index>(date.startIndex.advancedBy(4)..<date.startIndex.advancedBy(6))
    //        let dayRange = Range<String.Index>(date.startIndex.advancedBy(6)..<date.startIndex.advancedBy(8))
    //        
    //        let year = date.substringWithRange(yearRange)
    //        let month = date.substringWithRange(monthRange)
    //        let day = date.substringWithRange(dayRange)
    //        
    //        if type == "2"
    //        {
    //            return "\(month)-\(day)"
    //        }
    //        else if type == "3"
    //        {
    //            return "\(year)-\(month)"
    //        }
    //        else
    //        {
    //            return "\(year)-\(month)-\(day)"
    //        }
    //    }
    //    
    //    //time format is HHmmssSSS type 1: hh:mm:ss type 2: hh:mm type 3: mm:ss
    //    func getTimeString(time: String, type: String = "1") -> String
    //    {
    //        var fixedTime: String!
    //        
    //        if time.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 9
    //        {
    //            fixedTime = time
    //        }
    //        else
    //        {
    //            fixedTime = "0" + time
    //        }
    //        
    //        let hourRange = Range<String.Index>( fixedTime.startIndex.advancedBy(0)..<fixedTime.startIndex.advancedBy(2))
    //        let minuteRange = Range<String.Index>(fixedTime.startIndex.advancedBy(2)..<fixedTime.startIndex.advancedBy(4))
    //        let secondRange = Range<String.Index>(fixedTime.startIndex.advancedBy(4)..<fixedTime.startIndex.advancedBy(6))
    //        
    //        let hour = fixedTime.substringWithRange(hourRange)
    //        let minute = fixedTime.substringWithRange(minuteRange)
    //        let second = fixedTime.substringWithRange(secondRange)
    //        
    //        if type == "2"
    //        {
    //            return "\(hour):\(minute)"
    //        }
    //        else if type == "3"
    //        {
    //            return "\(minute):\(second)"
    //        }
    //        else
    //        {
    //            return "\(hour):\(minute):\(second)"
    //        }
    //        
    //    }
    //    
    //    
    //    
}
