

//
//  Table.swift
//  danceWithCowIOS
//
//  Created by 雷伊潇 on 16/2/6.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit


protocol Chage {
    func chage()
}
class TimeLine: UIView
{
    var timelineremoveset:NSTimer!
    
    var test:Chage!
    var isShow:Bool!
    func setChange(change:Chage,show:Bool){
        self.test=change
        self.isShow=show
    }
    
    //收缩按钮
    let buttonss:UIButton = UIButton(type:.System)
    var ssdo:Bool=true
    
    
    let buttonsearchtime:UIButton = UIButton(type:.System)
    var djlabel = UILabel()
    var djprice = UILabel()
    var djavgprice = UILabel()
    var djupdown = UILabel()
    var djupdownprc = UILabel()
    
    var cjlprcStr = UILabel()
    //颜色
    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
    var bule1=UIColor(red: 19/255, green: 20/255, blue: 29/255, alpha: 1)
    var gray1=UIColor(red: 26/255, green: 25/255, blue: 32/255, alpha: 1)
    var color10=UIColor(red: 232/255, green: 203/255, blue: 50/255, alpha: 1)
    
    var priceLineRect: CGRect!
    var volumeLineRect: CGRect!
    
    var preClosePrice: Double!
    var maxPrice: Double!
    var minPrice: Double!
    var maxVolume: Double!
    var cjlVolume: Double!
    
    var stepX: CGFloat!
    var stepY: CGFloat!
    var stepVolumeY: CGFloat!
    
    let spaceX: CGFloat = 5
    let spaceY: CGFloat = 15
    
    var pcn="close"
    
    var timeLineArray: FenshiBean! {
        
        didSet {
            
            self.setNeedsDisplay()
            
        }
        
    }
    
    init(){         //初始化
        super.init(frame: CGRectZero)
        
        self.backgroundColor = bule1
        self.contentMode = .Redraw
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureAction))
        
        self.addGestureRecognizer(longPressGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.priceLineRect = CGRect(x: spaceX, y: spaceY, width: self.frame.width - spaceX * 2, height: (self.frame.height - spaceY * 3) * 0.7)
        self.volumeLineRect = CGRect(x: spaceX, y: self.priceLineRect.maxY + spaceY, width: self.frame.width - spaceX * 2, height: (self.frame.height - spaceY * 3) * 0.3)
        
        buttonss.frame=CGRectMake(self.frame.width - 45, spaceY, 40, 20)
        buttonss.setBackgroundImage(UIImage(named:"返回行情"),forState:.Normal)
        if (self.isShow == true){
            addSubview(buttonss);
        }else{
            buttonss.removeFromSuperview()
        }
        
        buttonss.addTarget(self,action:#selector(searchss),forControlEvents:.TouchUpInside)
        
        djlabel.frame=CGRectMake(5, 0, 30, 10)
        djlabel.font = UIFont.systemFontOfSize(10)
        djlabel.textAlignment=NSTextAlignment.Center
        addSubview(djlabel)
        
        djprice.frame=CGRectMake(35, 0, 400, 10)
        djprice.font = UIFont.systemFontOfSize(10)
        djprice.textAlignment=NSTextAlignment.Left
        addSubview(djprice)
        
        djavgprice.frame=CGRectMake(105, 0, 70, 10)
        djavgprice.text = "当前均线"
        djavgprice.textColor = UIColor.clearColor()
        djavgprice.font = UIFont.systemFontOfSize(10)
        djavgprice.textAlignment=NSTextAlignment.Center
        addSubview(djavgprice)
        
        djupdown.frame=CGRectMake(175, 0, 60, 10)
        djupdown.text = "当前涨跌"
        djupdown.textColor = UIColor.clearColor()
        djupdown.font = UIFont.systemFontOfSize(10)
        djupdown.textAlignment=NSTextAlignment.Center
        addSubview(djupdown)
        
        djupdownprc.frame=CGRectMake(235, 0, 80, 10)
        djupdownprc.text = "当前涨跌幅"
        djupdownprc.textColor = UIColor.clearColor()
        djupdownprc.font = UIFont.systemFontOfSize(10)
        djupdownprc.textAlignment=NSTextAlignment.Center
        addSubview(djupdownprc)
        
        //        displayXline.backgroundColor = UIColor.clearColor()
        //        addSubview(displayXline)
        //
        ////        displayYline.backgroundColor = UIColor.clearColor()
        //        addSubview(displayYline)
        
        
    }
    
    override func drawRect(rect: CGRect) {
        
        self.preClosePrice = Double(self.timeLineArray.yestclose!)
        self.cjlVolume = Double(self.timeLineArray.lastVolume!)
        self.maxPrice = self.preClosePrice
        self.minPrice = self.preClosePrice
        self.maxVolume = 100
        
        for item in self.timeLineArray.data! {
            let price = Double(item[1].number!)
            let volume = Double(item[3].number!)
            
            if price > self.maxPrice {
                
                self.maxPrice = price
                
            }else if price < self.minPrice {
                
                self.minPrice = price
            }
            
            if volume > self.maxVolume{
                
                self.maxVolume = volume
            }
            
        }
        var lineMax:Double?
        
        
        if abs(self.maxPrice-self.preClosePrice)>abs(self.preClosePrice-self.minPrice) {
            lineMax = abs(self.maxPrice-self.preClosePrice)
        }else{
            lineMax = abs(self.preClosePrice-self.minPrice)
            
        }
        
        
        
        //成交量文本
        cjlprcStr.frame=CGRectMake(rect.width - 80 - spaceX, self.volumeLineRect.minY, 80, 10)
        cjlprcStr.font = UIFont.systemFontOfSize(10)
        cjlprcStr.textAlignment=NSTextAlignment.Right
        cjlprcStr.textColor = UIColor.whiteColor()
//        cjlprcStr.text = GloMethod.djchangeStrToShou(String(cjlVolume/100))//String(cjlVolume)
        addSubview(cjlprcStr)
        
        
        let accessroyLinePath = UIBezierPath()
        let accessroyLinePath1 = UIBezierPath()
        accessroyLinePath.moveToPoint(CGPoint(x: spaceX, y: self.priceLineRect.minY))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width - spaceX, y: self.priceLineRect.minY))
        accessroyLinePath1.moveToPoint(CGPoint(x: spaceX, y: (self.priceLineRect.midY) / 2 + (self.priceLineRect.minY) / 2 ))
        accessroyLinePath1.addLineToPoint(CGPoint(x: rect.width - spaceX, y: (self.priceLineRect.midY) / 2 + (self.priceLineRect.minY) / 2 ))
        accessroyLinePath1.moveToPoint(CGPoint(x: spaceX, y: self.priceLineRect.midY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: rect.width - spaceX, y: self.priceLineRect.midY))
        accessroyLinePath1.moveToPoint(CGPoint(x: spaceX, y: (self.priceLineRect.midY) / 2 + (self.priceLineRect.maxY) / 2 ))
        accessroyLinePath1.addLineToPoint(CGPoint(x: rect.width - spaceX, y: (self.priceLineRect.midY) / 2 + (self.priceLineRect.maxY) / 2 ))
        accessroyLinePath.moveToPoint(CGPoint(x: spaceX, y: self.priceLineRect.maxY))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width - spaceX, y: self.priceLineRect.maxY))
        accessroyLinePath.moveToPoint(CGPoint(x: spaceX, y: self.volumeLineRect.minY))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width - spaceX, y: self.volumeLineRect.minY))
        accessroyLinePath.moveToPoint(CGPoint(x: spaceX, y: self.volumeLineRect.maxY))
        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width - spaceX, y: self.volumeLineRect.maxY))
        accessroyLinePath.moveToPoint(CGPoint(x: spaceX, y: self.priceLineRect.minY))
        accessroyLinePath.addLineToPoint(CGPoint(x: spaceX, y: self.priceLineRect.maxY))
        
        accessroyLinePath.moveToPoint(CGPoint(x: self.priceLineRect.maxX, y: self.priceLineRect.minY))
        accessroyLinePath.addLineToPoint(CGPoint(x: self.priceLineRect.maxX, y: self.priceLineRect.maxY))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: rect.width / 4, y: self.priceLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: rect.width / 4, y: self.priceLineRect.maxY))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: rect.width / 4 * 2, y: self.priceLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: rect.width / 4 * 2, y: self.priceLineRect.maxY))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: rect.width / 4 * 3, y: self.priceLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: rect.width / 4 * 3, y: self.priceLineRect.maxY))
        
        
        accessroyLinePath.moveToPoint(CGPoint(x: spaceX, y: self.volumeLineRect.minY))
        accessroyLinePath.addLineToPoint(CGPoint(x: spaceX, y: self.volumeLineRect.maxY))
        
        accessroyLinePath.moveToPoint(CGPoint(x: self.priceLineRect.maxX, y: self.volumeLineRect.minY))
        accessroyLinePath.addLineToPoint(CGPoint(x: self.priceLineRect.maxX, y: self.volumeLineRect.maxY))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: rect.width / 4, y: self.volumeLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: rect.width / 4, y: self.volumeLineRect.maxY))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: rect.width / 4 * 2, y: self.volumeLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: rect.width / 4 * 2, y: self.volumeLineRect.maxY))
        
        accessroyLinePath1.moveToPoint(CGPoint(x: rect.width / 4 * 3, y: self.volumeLineRect.minY))
        accessroyLinePath1.addLineToPoint(CGPoint(x: rect.width / 4 * 3, y: self.volumeLineRect.maxY))
        
        //        accessroyLinePath.moveToPoint(CGPoint(x: rect.width / 5 * 4, y: self.volumeLineRect.minY))
        //        accessroyLinePath.addLineToPoint(CGPoint(x: rect.width / 5 * 4, y: self.volumeLineRect.maxY))
        
        UIColor.lightGrayColor().setStroke()
        accessroyLinePath.stroke()
        UIColor.darkGrayColor().setStroke()
        accessroyLinePath1.stroke()
        
        
        let dateTextAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let dateText1 = NSString(string: "09:30")
        let dateText2 = NSString(string: "10:30")
        let dateText3 = NSString(string: "11:30/13:00")
        let dateText4 = NSString(string: "14:00")
        let dateText5 = NSString(string: "15:00")
        
        //let dateTextSize1 = dateText1.sizeWithAttributes(dateTextAttrs)
        let dateText1Point = CGPoint(x: 0, y: self.priceLineRect.maxY)
        dateText1.drawAtPoint(dateText1Point, withAttributes: dateTextAttrs)
        
        let dateTextSize2 = dateText2.sizeWithAttributes(dateTextAttrs)
        let dateText2Point = CGPoint(x: rect.width / 4 - dateTextSize2.width / 2, y: self.priceLineRect.maxY)
        dateText2.drawAtPoint(dateText2Point, withAttributes: dateTextAttrs)
        
        let dateTextSize3 = dateText3.sizeWithAttributes(dateTextAttrs)
        let dateText3Point = CGPoint(x: rect.width / 4 * 2 - dateTextSize3.width / 2, y: self.priceLineRect.maxY)
        dateText3.drawAtPoint(dateText3Point, withAttributes: dateTextAttrs)
        
        let dateTextSize4 = dateText4.sizeWithAttributes(dateTextAttrs)
        let dateText4Point = CGPoint(x: rect.width / 4 * 3 - dateTextSize4.width / 2, y: self.priceLineRect.maxY)
        dateText4.drawAtPoint(dateText4Point, withAttributes: dateTextAttrs)
        
        let dateTextSize5 = dateText5.sizeWithAttributes(dateTextAttrs)
        let dateText5Point = CGPoint(x: rect.width - dateTextSize5.width, y: self.priceLineRect.maxY)
        dateText5.drawAtPoint(dateText5Point, withAttributes: dateTextAttrs)
        
        
        
        let maxTextAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UP_COLOR]
        let maxbfb = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UP_COLOR]
        let bfbmid = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UIColor.whiteColor()]
        let ysdTextAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UIColor.whiteColor()]
        let cjlTextAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UIColor.whiteColor()]
        let cjlnumberAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UIColor.whiteColor()]
        let minTextAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: DOWN_COLOR]
        let minbfb = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: DOWN_COLOR]
        
        //分时图右侧百分比
        let maxbfbz = (lineMax)!/self.preClosePrice
        let maxbfbStr = getMoneyString(maxbfbz*100)+"%" as NSString
        let maxbfbPointSize = maxbfbStr.sizeWithAttributes(dateTextAttrs)
        let maxbfbPoint = CGPoint(x: rect.width - maxbfbPointSize.width - 5, y: self.priceLineRect.minY)
        maxbfbStr.drawAtPoint(maxbfbPoint, withAttributes: maxbfb)
        
        let maxlittlebfbz = ((lineMax)!/self.preClosePrice)/2
        let maxlittlebfbStr = getMoneyString(maxlittlebfbz*100)+"%" as NSString
        let maxlittlebfbPointSize = maxlittlebfbStr.sizeWithAttributes(dateTextAttrs)
        let maxlittlebfbPoint = CGPoint(x: rect.width - maxlittlebfbPointSize.width - 5, y: (self.priceLineRect.minY+(self.priceLineRect.maxY+self.priceLineRect.minY)/2)/2)
        maxlittlebfbStr.drawAtPoint(maxlittlebfbPoint, withAttributes: maxbfb)
        
        let bfbzmidStr = "0.00%" as NSString
        let bfbzmidPoint = CGPoint(x: rect.width - maxbfbPointSize.width - 5, y: (self.priceLineRect.maxY+self.priceLineRect.minY)/2)
        bfbzmidStr.drawAtPoint(bfbzmidPoint, withAttributes: bfbmid)
        
        let minbfbStr = "-"+getMoneyString(maxbfbz*100)+"%" as NSString
        let minbfbSize = minbfbStr.sizeWithAttributes(minbfb)
        let minbfbPoint = CGPoint(x: rect.width - minbfbSize.width - 5, y: self.priceLineRect.maxY - minbfbSize.height)
        minbfbStr.drawAtPoint(minbfbPoint, withAttributes: minbfb)
        
        let minlittlebfbStr = "-"+getMoneyString(maxlittlebfbz*100)+"%" as NSString
        let minlittlebfbSize = minlittlebfbStr.sizeWithAttributes(minbfb)
        let minlittlebfbPoint = CGPoint(x: rect.width - minlittlebfbSize.width - 5, y: (self.priceLineRect.maxY+(self.priceLineRect.maxY+self.priceLineRect.minY)/2)/2)
        minlittlebfbStr.drawAtPoint(minlittlebfbPoint, withAttributes: minbfb)
        
        //分时图左侧涨幅数据最大
        let maxPricePoint = CGPoint(x: spaceX, y: self.priceLineRect.minY)
        let maxPriceStr = getMoneyString(self.preClosePrice+lineMax!) as NSString
        // let maxPriceSize = maxPriceStr.sizeWithAttributes(maxTextAttrs)
        maxPriceStr.drawAtPoint(maxPricePoint, withAttributes: maxTextAttrs)
        
        let maxlittlePricePoint = CGPoint(x: spaceX, y: (self.priceLineRect.minY+(self.priceLineRect.maxY+self.priceLineRect.minY)/2)/2)
        let maxlittlePriceStr = getMoneyString((self.preClosePrice+lineMax!+self.preClosePrice)/2) as NSString
        // let maxPriceSize = maxPriceStr.sizeWithAttributes(maxTextAttrs)
        maxlittlePriceStr.drawAtPoint(maxlittlePricePoint, withAttributes: maxTextAttrs)
        
        
        let ysdPricePoint = CGPoint(x: spaceX, y: (self.priceLineRect.maxY+self.priceLineRect.minY)/2)
        let ysdPriceStr = getMoneyString(self.preClosePrice) as NSString
        ysdPriceStr.drawAtPoint(ysdPricePoint, withAttributes: ysdTextAttrs)
        
        //成交量文本
        let cjlPoint = CGPoint(x: spaceX, y: self.volumeLineRect.minY)
        let cjlStr = "成交量"
        cjlStr.drawAtPoint(cjlPoint, withAttributes: cjlTextAttrs)
        
//        let cjlnumberPoint = CGPoint(x: rect.width - minlittlebfbSize.width - 15, y: self.volumeLineRect.minY)
//        let cjlnumberStr = getMoneyString(cjlVolume) as NSString
//        cjlnumberStr.drawAtPoint(cjlnumberPoint, withAttributes: cjlnumberAttrs)
        
        
        //分时图左侧涨幅数据最小
        let minPriceStr = getMoneyString(self.preClosePrice-lineMax!) as NSString
        let minPriceSize = minPriceStr.sizeWithAttributes(minTextAttrs)
        let minPricePoint = CGPoint(x: spaceX, y: self.priceLineRect.maxY - minPriceSize.height)
        minPriceStr.drawAtPoint(minPricePoint, withAttributes: minTextAttrs)
        
        let minlittlePriceStr = getMoneyString((self.preClosePrice-lineMax!+self.preClosePrice)/2) as NSString
//        let minlittlePriceSize = minlittlePriceStr.sizeWithAttributes(minTextAttrs)
        let minlittlePricePoint = CGPoint(x: spaceX, y: (self.priceLineRect.maxY+(self.priceLineRect.maxY+self.priceLineRect.minY)/2)/2)
        minlittlePriceStr.drawAtPoint(minlittlePricePoint, withAttributes: minTextAttrs)
        
        
        
        
        if self.maxPrice == self.preClosePrice && self.minPrice == self.preClosePrice {
            
            self.maxPrice = self.preClosePrice
            self.minPrice = self.preClosePrice
            
        }else {
            
            let upValue = self.maxPrice - self.preClosePrice
            let downValue = self.preClosePrice - self.minPrice
            
            if upValue > downValue {
                
                self.minPrice = self.preClosePrice - upValue
                
            }else {
                
                self.maxPrice = self.preClosePrice + downValue
                
            }
            
        }
        
        
        
        self.stepX = self.priceLineRect.width / 240
        self.stepY = self.priceLineRect.height / CGFloat(self.maxPrice - self.minPrice)
        
        let priceLinePath = UIBezierPath()
        
        var price = Double(self.timeLineArray.data![0][1].number!)
        var priceX = self.priceLineRect.minX + self.stepX / 2
        var priceY = self.priceLineRect.minY + CGFloat(self.maxPrice - price) * self.stepY
        priceLinePath.moveToPoint(CGPoint(x: priceX, y: priceY))
        
        
        let avgPriceLinePath = UIBezierPath()
        
        var avgPrice = Double(self.timeLineArray.data![0][2].number!)
        var avgPriceX = priceX
        var avgPriceY = self.priceLineRect.minY + CGFloat(self.maxPrice - avgPrice) * self.stepY
        avgPriceLinePath.moveToPoint(CGPoint(x: avgPriceX, y: avgPriceY))
        
        
        
        for index in 1..<self.timeLineArray.data!.count {
            
            price = Double(self.timeLineArray.data![index][1].number!)
            priceX = self.priceLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            priceY = self.priceLineRect.minY + CGFloat(self.maxPrice - price) * self.stepY
            priceLinePath.addLineToPoint(CGPoint(x: priceX, y: priceY))
            
            avgPrice = Double(self.timeLineArray.data![index][2].number!)
            avgPriceX = self.priceLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            avgPriceY = self.priceLineRect.minY + CGFloat(self.maxPrice - avgPrice) * self.stepY
            avgPriceLinePath.addLineToPoint(CGPoint(x:avgPriceX, y: avgPriceY))
            
        }
        
        UIColor.whiteColor().setStroke()
        priceLinePath.stroke()
        
        self.color10.setStroke()
        avgPriceLinePath.stroke()
        
        
        
        self.stepVolumeY = self.volumeLineRect.height / CGFloat(self.maxVolume)
        var prePrice = self.preClosePrice
        
        for index in 0..<self.timeLineArray.data!.count {
            
            let volumeLinePath = UIBezierPath()
            let volume = CGFloat((self.timeLineArray.data![index][3].number!))
            let volumeX = self.volumeLineRect.minX + CGFloat(index) * self.stepX + self.stepX / 2
            let volumeY = self.volumeLineRect.maxY - volume * self.stepVolumeY
            
            volumeLinePath.moveToPoint(CGPoint(x: volumeX, y: volumeY))
            volumeLinePath.addLineToPoint(CGPoint(x: volumeX, y: self.volumeLineRect.maxY))
            
            let price = Double((self.timeLineArray.data![index][1].number!))
            if price > prePrice
            {
                UP_COLOR.setStroke()
                
            }else if price < prePrice {
                
                DOWN_COLOR.setStroke()
                
            }else {
                
                DOWN_COLOR.setStroke()
                //                UIColor.lightGrayColor().setStroke()
                
            }
            volumeLinePath.stroke()
            
            prePrice = price
        }
        
        
    }
    func reloadData(){
        
        
    }
    
    
    //点击事件
    var displayLineView: UIView!
    var displayXline = UILabel()
    var displayLineYView: UIView!
    var displayYline = UILabel()
    var movePoint: CGPoint!
    func longPressGestureAction(sender: UILongPressGestureRecognizer)
    {
        
        let touchPoint = sender.locationInView(self)
        
        if sender.state == .Began
        {
            if self.getTouchPoint(touchPoint)
            {
                self.removeDisplayView()
                
                self.setFrame()
                
                
            }
            
        }else if sender.state == .Changed
        {
            if self.getTouchPoint(touchPoint)
            {
                
                self.setFrame()
                
                
            }
            
        }else if sender.state == .Ended || sender.state == .Cancelled
        {
            timelineremoveset = NSTimer.scheduledTimerWithTimeInterval(10,target:self,selector:#selector(removeDisplayViewtime),userInfo:nil,repeats:false)
            
            
            
        }
        
    }
    
    func removeDisplayViewtime()
    {
        displayXline.backgroundColor = UIColor.clearColor()
        
        displayYline.backgroundColor = UIColor.clearColor()
        self.djlabel.textColor = UIColor.clearColor()
        self.djprice.textColor = UIColor.clearColor()
        self.cjlprcStr.textColor = UIColor.clearColor()
//        cjlprcStr.text = String(cjlVolume)

        
        
    }
    
    func addDisplayView()
    {
        self.displayLineView = UIView()
        self.displayLineView.backgroundColor = UIColor.cyanColor()//X轴
        self.addSubview(self.displayLineView)
        
        self.displayLineYView = UIView()
        self.displayLineYView.backgroundColor = UIColor.redColor()//Y轴
        self.addSubview(self.displayLineYView)
        
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
        displayXline.backgroundColor = UIColor.cyanColor()
        displayYline.backgroundColor = UIColor.redColor()
        addSubview(displayXline)
        addSubview(displayYline)
        
        displayXline.frame = CGRect(x: self.movePoint.x, y: 15, width: 1, height: self.volumeLineRect.maxY - 15)
        displayYline.frame = CGRect(x: spaceX, y: self.movePoint.y, width: self.priceLineRect.maxX - spaceX , height: 1)//横线位置
        
        //        self.displayLineView.frame = CGRect(x: self.movePoint.x, y: 15, width: 1, height: self.volumeLineRect.maxY - 15)
        //        self.displayLineYView.frame = CGRect(x: 0, y: self.movePoint.y, width: self.priceLineRect.maxX, height: 1)
    }
    
    func getTouchPoint(touchPoint: CGPoint) -> Bool
    {
        if self.timeLineArray == nil
        {
            return false
        }
        
        if self.timeLineArray.data!.count == 0
        {
            return false
        }
        
        let index = Int((touchPoint.x-self.spaceX) / self.stepX)
        
        //        if index>timeLineArray.data!.count {
        //            return false
        //        }
        
        if index < 0 || index > self.timeLineArray.data!.count - 1
        {
            return false
        }
        
        let priceDic = self.timeLineArray.data![index]
        var rq = priceDic[0].string!
        let indexrq=rq.startIndex.advancedBy(2)
        rq.insert(":",atIndex:indexrq)
        let price = Double(priceDic[1].number!)
        let avgprice = Double(priceDic[2].number!)
        let zhangdie = price-self.preClosePrice
        let zhangdiefu = zhangdie/self.preClosePrice*100
        let cjlnum = Double(priceDic[3].number!)
        let pointX = CGFloat(touchPoint.x) //* self.stepX + self.stepX / 2
        let pointY = self.priceLineRect.minY + CGFloat(self.maxPrice - price) * self.stepY
        
        
        self.djlabel.text = String(rq)
        self.djlabel.textColor = UIColor.whiteColor()
        self.djprice.text = "价格:" + String(format: "%.1f", price)+"均价:" + String(format: "%.1f", avgprice)+"涨跌:" + String(format: "%.2f", zhangdie)+"涨跌幅:" + String(format: "%.2f", zhangdiefu)+"%"
        self.djprice.textColor = UIColor.whiteColor()
        //成交量十字变化
        self.cjlprcStr.textColor = UIColor.whiteColor()
        self.cjlprcStr.text = GloMethod.djchangeStrToShou(String(Double(priceDic[3].number!)/100))
        
        
        self.movePoint = CGPoint(x: pointX, y: pointY)
        
        return true
        
    }
    
    
    
    func searchss(){
        self.test.chage()
        
        if g1.ssdo{
            pcn = "close"
            buttonss.setBackgroundImage(UIImage(named:"返回行情"),forState:.Normal)
        }else{
            pcn = "open"
            buttonss.setBackgroundImage(UIImage(named:"扩大行情"),forState:.Normal)
        }
        displayXline.backgroundColor = UIColor.clearColor()
        displayYline.backgroundColor = UIColor.clearColor()
        self.djlabel.textColor = UIColor.clearColor()
        self.djprice.textColor = UIColor.clearColor()
        self.cjlprcStr.textColor = UIColor.clearColor()
    }
    
    //MARK: - Property 参数添加
    let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
    let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
    
    let APP_MAIN_COLOR = UIColor(red: 255/255.0, green: 115/255.0, blue: 96/255.0, alpha: 1.0)
    
    let BLUE_COLOR = UIColor(red: 102/255.0, green: 204/255.0, blue: 238/255.0, alpha: 1.0)
    let YELLOW_COLOR = UIColor(red: 251/255.0, green: 151/255.0, blue: 85/255.0, alpha: 1.0)
    
    let BACKGROUND_COLOR = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
    let HIGHLIGHTED_COLOR = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
    
    let CELL_COLOR_LIGHT = UIColor.whiteColor()
    let CELL_COLOR_DARK = UIColor(red: 27/255.0, green: 27/255.0, blue: 27/255.0, alpha: 1.0)
    
    let SELECTED_COLOR_LIGHT = UIColor(red: 218/255.0, green: 218/255.0, blue: 218/255.0, alpha: 1.0)
    let SELECTED_COLOR_DARK = UIColor(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0)
    
    let SECTIONHEADER_COLOR_LIGHT = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1.0)
    let SECTIONHEADER_COLOR_DARK = UIColor(red: 27/255.0, green: 27/255.0, blue: 27/255.0, alpha: 1.0)
    
    let SEPARATOR_COLOR_LIGHT = UIColor(red: 218/255.0, green: 218/255.0, blue: 218/255.0, alpha: 1.0)
    let SEPARATOR_COLOR_DARK = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1.0)
    
    let UP_COLOR = UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)//UIColor(red: 255/255.0, green: 115/255.0, blue: 96/255.0, alpha: 1.0)
    let DOWN_COLOR = UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)//UIColor(red: 127/255.0, green: 181/255.0, blue: 102/255.0, alpha: 1.0)
    
    //1.0
    let LINE_GRAY_COLOR = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
    let MY_YELLOW_COLOR = UIColor(red: 248/255.0, green: 181/255.0, blue: 81/255.0, alpha: 1.0)
    let MY_BLUE_COLOR = UIColor(red: 126/255.0, green: 206/255.0, blue: 244/255.0, alpha: 1.0)
    let MY_GREEN_COLOR = UIColor(red: 179/255.0, green: 212/255.0, blue: 101/255.0, alpha: 1.0)
    let MY_PING_COLOR = UIColor(red: 234/255.0, green: 156/255.0, blue: 194/255.0, alpha: 1.0)
    let PATH_DOCUMENTS = NSHomeDirectory() + "/Documents/"
    let PATH_LIBRARY = NSHomeDirectory() + "/Library/"
    let PATH_CACHE = NSHomeDirectory() + "/Library/Caches/"
    let fundTypeCodeToTitle = ["1101": "股票型", "1103": "混合型", "1105": "债券型", "1106": "短期理财", "1107": "保本型", "1109": "货币型", "1110": "QDII"]
    let conditionToTitle = ["1": "日涨幅", "2": "月涨幅", "3": "季涨幅", "4": "半年涨幅", "5": "一年涨幅", "6": "七日年化", "7": "万份收益", "8": "单位净值"]
    //1.0 Notifications
    let SelfSelectStockDidChangedNotification = "SelfSelectStockDidChangedNotification"
    let SelfSelectFundDidChangedNotification = "SelfSelectFundDidChangedNotification"
    
    let CenterAccountLoginSucceedNotification = "CenterAccountLoginSucceedNotification"
    let CenterAccountLogoutSucceedNotification = "CenterAccountLogoutSucceedNotification"
    let PlatformAccountLoginSucceedNotification = "PlatformAccountLoginSucceedNotification"
    let PlatformAccountLogoutSucceedNotification = "PlatformAccountLogoutSucceedNotification"
    
    let FundCollectSucceedNotification = "FundCollectSucceedNotification"
    let FundCancelCollectSucceedNotification = "FundCancelCollectSucceedNotification"
    
    let FundTradeSucceedNotification = "FundTradeSucceedNotification"
    
    let FundBuySucceedNotification = "FundBuySucceedNotification"
    let FundSaleSucceedNotification = "FundSaleSucceedNotification"
    let FundTransferSucceedNotification = "FundTransferSucceedNotification"
    let FundDividendModifySucceedNotification = "FundDividendModifySucceedNotification"
    
    let MoneyInSucceedNotification = "MoneyInSucceedNotification"
    let MoneyOutSucceedNotification = "MoneyOutSucceedNotification"
    
    //MARK: - Method
    //金额格式
    func getMoneyString(money: Double) -> String
    {
        return String(format: "%.2f", money)
    }
    
    
}
