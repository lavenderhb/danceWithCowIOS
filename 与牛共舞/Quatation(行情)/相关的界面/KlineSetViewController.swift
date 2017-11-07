//
//  KlineSetViewController.swift
//  dancewithcow
//
//  Created by 雷伊潇 on 17/6/15.
//  Copyright © 2017年 org.com.abc. All rights reserved.
//

import UIKit

class KlineSetViewController: UIViewController{
    
    

    
    //数据库数字编号
    var kset0=Int()
    var kset1=Int()
    var kset2=Int()
    //颜色
    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
    var bule1=UIColor(red: 19/255, green: 20/255, blue: 29/255, alpha: 1)
    var gray1=UIColor(red: 26/255, green: 25/255, blue: 32/255, alpha: 1)
    //背景模块
    var page1 = UIView()
    //文字
    var TopTitle = UILabel()
    var zhibiaoTitle0 = UILabel()
    var zhibiaoTitle1 = UILabel()
    var zhibiaoTitle2 = UILabel()
    var zhibiaoAb0 = UILabel()
    var zhibiaoAb1 = UILabel()
    var zhibiaoAb2 = UILabel()
    //bt
    let buttonback:UIButton = UIButton(type:.System)
    var uiswitch0:UISwitch!
    var uiswitch1:UISwitch!
    var uiswitch2:UISwitch!
    
    var ksetList:[KSetBean]=[]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromDB()
        setGP()
        setButton()
        setHengtiao()
        
        self.view.backgroundColor = bule1
        
    
        
        // Do any additional setup after loading the view.
    }
    func getDataFromDB(){
        ksetList=GloMethod.selectAllKset()
        for i in [0,1,2]{
            if ksetList[i].name == "成交量" {
                kset0 = i
            }else if ksetList[i].name == "MACD" {
                kset1 = i
            }else if ksetList[i].name == "KDJ" {
                kset2 = i
            }
        }
        
    }
    
    //文字设置
    func setGP(){
        
        
        TopTitle.frame = CGRectMake(0, 32, UIScreen.mainScreen().bounds.width, 30)
        TopTitle.text = "指标设置"
        TopTitle.textColor = UIColor.whiteColor()
        TopTitle.font = UIFont.systemFontOfSize(18)
        TopTitle.textAlignment=NSTextAlignment.Center
        self.view.addSubview(TopTitle)
        
        zhibiaoTitle0.frame = CGRectMake(20, 90, UIScreen.mainScreen().bounds.width-20, 30)
        zhibiaoTitle0.text = ksetList[kset0].name
        zhibiaoTitle0.textColor = UIColor.whiteColor()
        zhibiaoTitle0.font = UIFont.systemFontOfSize(18)
        zhibiaoTitle0.textAlignment=NSTextAlignment.Left
        self.view.addSubview(zhibiaoTitle0)
        
        zhibiaoAb0.frame = CGRectMake(UIScreen.mainScreen().bounds.width/2 - 60, 90, UIScreen.mainScreen().bounds.width-20, 30)
        zhibiaoAb0.text = ksetList[kset0].desc
        zhibiaoAb0.textColor = UIColor.whiteColor()
        zhibiaoAb0.font = UIFont.systemFontOfSize(18)
        zhibiaoAb0.textAlignment=NSTextAlignment.Left
        self.view.addSubview(zhibiaoAb0)
        
        zhibiaoTitle1.frame = CGRectMake(20, 150, UIScreen.mainScreen().bounds.width-20, 30)
        zhibiaoTitle1.text = ksetList[kset1].name
        zhibiaoTitle1.textColor = UIColor.whiteColor()
        zhibiaoTitle1.font = UIFont.systemFontOfSize(18)
        zhibiaoTitle1.textAlignment=NSTextAlignment.Left
        self.view.addSubview(zhibiaoTitle1)
        
        zhibiaoAb1.frame = CGRectMake(UIScreen.mainScreen().bounds.width/2 - 60, 150, UIScreen.mainScreen().bounds.width-20, 30)
        zhibiaoAb1.text = ksetList[kset1].desc
        zhibiaoAb1.textColor = UIColor.whiteColor()
        zhibiaoAb1.font = UIFont.systemFontOfSize(18)
        zhibiaoAb1.textAlignment=NSTextAlignment.Left
        self.view.addSubview(zhibiaoAb1)
        
        zhibiaoTitle2.frame = CGRectMake(20, 210, UIScreen.mainScreen().bounds.width-20, 30)
        zhibiaoTitle2.text = ksetList[kset2].name
        zhibiaoTitle2.textColor = UIColor.whiteColor()
        zhibiaoTitle2.font = UIFont.systemFontOfSize(18)
        zhibiaoTitle2.textAlignment=NSTextAlignment.Left
        self.view.addSubview(zhibiaoTitle2)
        
        zhibiaoAb2.frame = CGRectMake(UIScreen.mainScreen().bounds.width/2 - 60, 210, UIScreen.mainScreen().bounds.width-20, 30)
        zhibiaoAb2.text = ksetList[kset2].desc
        zhibiaoAb2.textColor = UIColor.whiteColor()
        zhibiaoAb2.font = UIFont.systemFontOfSize(18)
        zhibiaoAb2.textAlignment=NSTextAlignment.Left
        self.view.addSubview(zhibiaoAb2)
        
        
        
    }
    
    //button方法
    
    func switchDidChange0(){
   
        if uiswitch0.on {
            ksetList[kset0].isUse="1"
        }else{
            ksetList[kset0].isUse="0"
        }
        GloMethod.updateKset(ksetList[kset0])
       
    }
    func switchDidChange1(){
        
        if uiswitch1.on {
            ksetList[kset1].isUse="1"
        }else{
            ksetList[kset1].isUse="0"
        }
        GloMethod.updateKset(ksetList[kset1])
     
    }
    func switchDidChange2(){
        
        if uiswitch2.on {
            ksetList[kset2].isUse="1"
        }else{
            ksetList[kset2].isUse="0"
        }
        GloMethod.updateKset(ksetList[kset2])
       
    }
    
    
    func setHengtiao(){
        //横条设置
        page1.backgroundColor = red1
        page1.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.width , 70)
        self.view.addSubview(page1)
        self.view.sendSubviewToBack(page1)
    }
    
    func setButton(){
        
        buttonback.frame=CGRectMake(8, 28, 40, 40)
        buttonback.setBackgroundImage(UIImage(named:"backs100"),forState:.Normal)
        self.view.addSubview(buttonback);
        buttonback.addTarget(self,action:#selector(tapped),forControlEvents:.TouchUpInside)
        
        uiswitch0 = UISwitch()
        //设置位置（开关大小无法设置）
        uiswitch0.center = CGPoint(x:UIScreen.mainScreen().bounds.width - 50, y:105)
        //设置默认值
        
        uiswitch0.addTarget(self, action:#selector(switchDidChange0), forControlEvents:.ValueChanged)
        
        
        uiswitch1 = UISwitch()
        //设置位置（开关大小无法设置）
        uiswitch1.center = CGPoint(x:UIScreen.mainScreen().bounds.width - 50, y:165)
        //设置默认值
        
        uiswitch1.addTarget(self, action:#selector(switchDidChange1), forControlEvents:.ValueChanged)
       
        
        uiswitch2 = UISwitch()
        //设置位置（开关大小无法设置）
        uiswitch2.center = CGPoint(x:UIScreen.mainScreen().bounds.width - 50, y:225)
        //设置默认值
        
        uiswitch2.addTarget(self, action:#selector(switchDidChange2), forControlEvents:.ValueChanged)
        
        
        for kset in ksetList {
            if kset.name == "成交量" {
                if kset.isUse == "0" {
                    uiswitch0.on=false
                }else{
                    uiswitch0.on=true
                }
            }
            else if kset.name == "MACD"{
                if kset.isUse == "0" {
                    uiswitch1.on=false
                }else{
                    uiswitch1.on=true
                }
            }
            else if kset.name == "KDJ"{
                if kset.isUse == "0" {
                    uiswitch2.on=false
                }else{
                    uiswitch2.on=true
                }
            }
            
        }
        self.view.addSubview(uiswitch0);
        self.view.addSubview(uiswitch1);
        self.view.addSubview(uiswitch2);

    }
    
    
    
    func tapped(){
        
        self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
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
