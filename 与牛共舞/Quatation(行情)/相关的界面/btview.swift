//
//  btview.swift
//  dancewithcow
//
//  Created by 章如强 on 16/10/7.
//  Copyright © 2016年 章如强. All rights reserved.
//

import UIKit

protocol ChangeLine {
    func change(page:Int)
}




class btview: UIView {
    var changeLine:ChangeLine?
    func setChange(change:ChangeLine) {
        changeLine=change
    }
    
    var contents:[String]=[]
    
    
    
    
    let buttoncjl:UIButton = UIButton(type:.System)
    let buttonmacd:UIButton = UIButton(type:.System)
    let buttonkdj:UIButton = UIButton(type:.System)
    
    var upline = UILabel()
    var upline2 = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buttoncjl.frame = CGRectMake(0, 5, 80, 20)
        buttoncjl.setTitleColor(UIColor.grayColor() , forState: UIControlState.Normal)
        buttoncjl.setTitle("成交量", forState:UIControlState.Normal)
        buttoncjl.titleLabel?.font = UIFont.systemFontOfSize(12)
        //        addSubview(buttoncjl)
        buttoncjl.addTarget(self,action:#selector(btcjl),forControlEvents:.TouchUpInside)
        
        upline.frame = CGRectMake(70, 5, 20, 20)
        upline.text = "｜"
        upline.textColor = UIColor.darkGrayColor()
        upline.font = UIFont.systemFontOfSize(12)
        upline.textAlignment=NSTextAlignment.Center
        //        addSubview(upline)
        
        buttonmacd.frame = CGRectMake(80, 5, 80, 20)
        buttonmacd.setTitleColor(UIColor.grayColor() , forState: UIControlState.Normal)
        buttonmacd.setTitle("MACD", forState:UIControlState.Normal)
        buttonmacd.titleLabel?.font = UIFont.systemFontOfSize(12)
        //        addSubview(buttonmacd)
        buttonmacd.addTarget(self,action:#selector(btmacd),forControlEvents:.TouchUpInside)
        
        upline2.frame = CGRectMake(150, 5, 20, 20)
        upline2.text = "｜"
        upline2.textColor = UIColor.darkGrayColor()
        upline2.font = UIFont.systemFontOfSize(12)
        upline2.textAlignment=NSTextAlignment.Center
        //        addSubview(upline2)
        
        buttonkdj.frame = CGRectMake(160, 5, 80, 20)
        buttonkdj.setTitleColor(UIColor.grayColor() , forState: UIControlState.Normal)
        buttonkdj.setTitle("KDJ", forState:UIControlState.Normal)
        buttonkdj.titleLabel?.font = UIFont.systemFontOfSize(12)
        //        addSubview(buttonkdj)
        buttonkdj.addTarget(self,action:#selector(btkdj),forControlEvents:.TouchUpInside)
        
        
        
        if contents.contains("0") {
            addSubview(buttoncjl)
        }
        if contents.contains("1") {
            if !contents.contains("0"){
                buttonmacd.frame = CGRectMake(0, 5, 80, 20)
            }
            
            addSubview(buttonmacd)
        }
        if contents.contains("2") {
            if !contents.contains("0") && !contents.contains("1"){
                buttonkdj.frame = CGRectMake(0, 5, 80, 20)
            }else if contents.contains("0") && !contents.contains("1"){
                buttonkdj.frame = CGRectMake(80, 5, 80, 20)
            }else if !contents.contains("0") && contents.contains("1"){
                buttonkdj.frame = CGRectMake(80, 5, 80, 20)
            }
            
            addSubview(buttonkdj)
        }
        
    }
    
    func btcjl(){
        changeLine?.change(1)
    }
    
    func btmacd(){
        changeLine?.change(2)
    }
    
    func btkdj(){
        changeLine?.change(3)
    }
    
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
