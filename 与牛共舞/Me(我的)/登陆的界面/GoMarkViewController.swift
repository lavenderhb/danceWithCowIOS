//
//  GoMarkViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 Mac. All rights reserved.
//


/**
 
 * 手机号码
 
 * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 
 * 联通：130,131,132,152,155,156,185,186
 
 * 电信：133,1349,153,180,189
 
 */

import UIKit



// 用户注册的界面
class GoMarkViewController: UIViewController,UITextFieldDelegate {

    
    // 设置全局变量
    var YZMNumber : String!
    // 判断返回判断号码的信息
    var YZMessage : String!
    
    var tetPhoneNU : UITextField!
     // 注册的号码
    var phoneMessage : String!
    
    var tetYZ : UITextField!
    var YZbutton : UIButton!
    
    
    // 当前倒计时的剩余的秒数
    var sendButton: UIButton!
    
    var countdownTimer: NSTimer?
    
    
    
    var remainingSeconds: Int = 0 {
        willSet {
            YZbutton.setTitle("\(newValue)秒后重新获取", forState: .Normal)
            
            if newValue <= 0 {
                YZbutton.setTitle("获取验证码", forState: .Normal)
                isCounting = false
            }
        }
    }

    
    var isCounting = false {
        willSet {
            if newValue {
                
                countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GoMarkViewController.updateTime(_:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
                
                YZbutton.backgroundColor = UIColor.grayColor()
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                YZbutton.backgroundColor = UIColor.redColor()
            }
            
            YZbutton.enabled = !newValue
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "用户注册"
     
        self.view.backgroundColor = UIColor.init(red: 239 / 255.0, green: 238 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 240 / 255.0, green: 54 / 255.0, blue: 30 / 255.0, alpha: 1.0)

        let leftBarBtn = UIBarButtonItem(title: "", style: .Plain, target: self,
                                         action: nil)        
        self.navigationItem.backBarButtonItem = leftBarBtn
        
        // 手机号
        tetPhoneNU = UITextField()
        tetPhoneNU.frame = CGRectMake(0, 100, self.view.bounds.width, 44)
        tetPhoneNU.backgroundColor = UIColor.whiteColor()
        tetPhoneNU.delegate = self
        // 数字键盘出现的功能
//        tetPhoneNU.keyboardType = UIKeyboardType.NumberPad
        tetPhoneNU.becomeFirstResponder()
//        tetPhoneNU.backgroundColor = UIColor.grayColor()
        tetPhoneNU.placeholder = "手机号"
        let imageNumber : UIImageView = UIImageView(frame: CGRectMake(20, 0, 38, 38))
        imageNumber.image = UIImage(named: "手机.jpg")
        tetPhoneNU.leftView = imageNumber
        tetPhoneNU.leftViewMode = UITextFieldViewMode.Always
        tetPhoneNU.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view.addSubview(tetPhoneNU)
        
        if (tetPhoneNU.text != nil) {
            phoneMessage = tetPhoneNU.text
        }
        
        
        
        // 验证
        tetYZ = UITextField(frame: CGRectMake(0, 146, self.view.bounds.width - 165, 44))
        tetYZ.delegate = self
        tetYZ.placeholder = "验证码"
        tetYZ.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tetYZ)
        
        
        let bbbView = UIView()
        bbbView.frame = CGRectMake(self.view.bounds.width - 165, 146, 165, 44)
        bbbView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bbbView)
        
        let imaYZimage : UIImageView = UIImageView(frame: CGRectMake(20, 0, 35, 38))
        imaYZimage.image = UIImage(named: "验证码.jpg")
        tetYZ.leftView = imaYZimage
        
        YZbutton = UIButton(frame: CGRectMake(20, 5, 138, 34))
        YZbutton!.layer.cornerRadius = 5
        
        YZbutton!.setTitle("获取验证码", forState: UIControlState.Normal)
        YZbutton.addTarget(self, action: #selector(GoMarkViewController.sendButtonClick(_:)), forControlEvents: .TouchUpInside)
        YZbutton!.backgroundColor = UIColor.redColor()
        //                    tetYZ.rightView = YZbutton
        tetYZ.leftViewMode = UITextFieldViewMode.Always
        tetYZ.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        bbbView.addSubview(YZbutton!)
        
        
    
        
        let SureButton : UIButton = UIButton()
        SureButton.frame = CGRectMake(20, 210, self.view.bounds.width - 40, 35)
        SureButton.backgroundColor = UIColor.init(red: 240 / 255.0, green: 54 / 255.0, blue: 30 / 255.0, alpha: 1.0)
        SureButton.setTitle("确认注册", forState: UIControlState.Normal)
        SureButton.addTarget(self, action: #selector(GoMarkViewController.SureBUttonAction), forControlEvents: UIControlEvents.TouchUpInside)
        SureButton.layer.cornerRadius = 10.0
        self.view.addSubview(SureButton)
        
        let OtherButton : UIButton = UIButton(frame: CGRectMake(40, 275, self.view.bounds.width - 80, 30))
        OtherButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        OtherButton.setTitle("已有账号，去登录>>", forState: UIControlState.Normal)
        OtherButton.alpha = 0.5
        OtherButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        OtherButton.addTarget(self, action: #selector(GoMarkViewController.OtherAction), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(OtherButton)
        
        
        // 调用加载数据
        let backbb  = UIButton(frame: CGRectMake(15, 0, 20, 20))
        //        backbb.backgroundColor = UIColor.blackColor()
        backbb.setImage(UIImage(named: "back00"), forState: UIControlState.Normal)
        backbb.backgroundColor = UIColor.clearColor()
        backbb.adjustsImageWhenHighlighted = false
        backbb.addTarget(self, action: #selector(SearchViewController.backToPrevious), forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftBarBtn11 = UIBarButtonItem(customView: backbb)
        
        
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10;
        
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn11]
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
  
    
    
    func OtherAction(){
        
        let loaddVidew = LoadViewController()
        self.navigationController?.pushViewController(loaddVidew, animated: true)

    }

    func SureBUttonAction(){
        
        let SureAlertView = UIAlertView()
        
        let url = NSURL(string: "http://appv2.yngw518.com/api.php/user/reg?token=8c2f64f08271fc4e43&cellphone=" + tetPhoneNU.text!)
        let data = NSData(contentsOfURL: url!)
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        var json : AnyObject?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        }catch let error as NSError{
            print(error)
        }
        
//        let meg : String = json?.objectForKey("msg") as! String
//        let YZM : String = json?.objectForKey("data") as! String
        
//        let code : String = json?.objectForKey("code") as! String//200||301
        let YZM : String = json?.objectForKey("data") as! String//注册成功，稍后客服会联系您！||此手机号已注册！

        
//        YZMNumber = YZM
//        YZMessage = code
        
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluateWithObject(tetPhoneNU.text) == false {
            SureAlertView.title = "请输入正确的手机号"
            SureAlertView.addButtonWithTitle("确定")
        }else if((regexMobile.evaluateWithObject(tetPhoneNU.text) == true)&&YZM == "此手机号已注册!"){
            SureAlertView.addButtonWithTitle("此手机号已经注册")
        }else{
            
            //       SureAlertView.addButtonWithTitle("注册成功")
            //        print(YZMNumber)
            
            if (tetYZ.text == YZMNumber) {
                SureAlertView.addButtonWithTitle("注册成功")
            }else if(tetPhoneNU.text == "" && tetYZ.text == ""){
                SureAlertView.title = "请输入手机号获取验证码"
                SureAlertView.addButtonWithTitle("确定")
            }else if(tetYZ.text != YZMNumber){
                SureAlertView.title = "验证码不正确"
                SureAlertView.addButtonWithTitle("确定")
            }else{
                SureAlertView.title = "手机号码格式错误"
                SureAlertView.addButtonWithTitle("确定")
            }
        }
        //
        SureAlertView.show()
        YZMNumber="";
  
    }
    
    
    func sendButtonClick(sender: UIButton) {
        
        
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluateWithObject(tetPhoneNU.text) == true {
            
            // http://yngwtest.gotoip1.com/api.php/user/getcode?token=8c2f64f08271fc4e43&cellphone=   注册的接口
            
            let url = NSURL(string: "http://appv2.yngw518.com/api.php/user/getcode?token=8c2f64f08271fc4e43&cellphone=" + tetPhoneNU.text!)
            let data = NSData(contentsOfURL: url!)
            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            var json : AnyObject?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            }catch let error as NSError{
                print(error)
            }
            
            let meg : String = json?.objectForKey("msg") as! String
            let YZM : String = json?.objectForKey("data") as! String//验证码
            
            YZMNumber = YZM
            YZMessage = meg
            
            if (meg == "此手机号已注册！"){
                XZAlertView.addXZAlertView(self.view, title: "此手机已经注册!")
            }else{
                isCounting = true
            }

        }else
        {
             let PhoAlertView = UIAlertView()
            PhoAlertView.title = "请输入正确的手机号"
            PhoAlertView.addButtonWithTitle("确定")
            
            PhoAlertView.show()
        }
        
        
            
  
        
    }
    
    func updateTime(timer: NSTimer) {
        remainingSeconds -= 1
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
