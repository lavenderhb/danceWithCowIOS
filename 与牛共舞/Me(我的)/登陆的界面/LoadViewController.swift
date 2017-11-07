//
//  LoadViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import SwiftHTTP


var LoadID : NSNumber?

var LoadName : String?

var LoadAll : NSDictionary?

var TTAgg : Int32?

var  ContactFilePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingString("contacts.data")


var TTesttt : AnyObject?
var txtUsr : UITextField!
class LoadViewController: UIViewController,UITextFieldDelegate {
    // 输入框和密码框的设定
    
    // 设置全局的路径
    
    var txtPwd : UITextField!
    
    var centerLabel : UILabel!
    // 登录框的状态
    var showType : LoginShowType = LoginShowType.PASS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let leftBarBtn = UIBarButtonItem(title: "", style: .Plain, target: self,
                                         action: nil)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 240 / 255.0, green: 54 / 255.0, blue: 30 / 255.0, alpha: 1.0)
        
        self.navigationItem.backBarButtonItem = leftBarBtn
        
        self.view.backgroundColor = UIColor.init(red: 239 / 255.0, green: 238 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        self.navigationItem.title = "用户登录"
        
        //  用户名输入框
        txtUsr  = UITextField(frame: CGRectMake(0,100,UIScreen.mainScreen().bounds.width, 44))
        txtUsr.delegate = self
        txtUsr.placeholder = "账号"
        txtUsr.backgroundColor = UIColor.whiteColor()
        txtUsr.layer.borderWidth = 0.0
        txtUsr.layer.borderColor = UIColor.blueColor().CGColor
        let imageNameView : UIImageView = UIImageView(frame: CGRectMake(20, 0, 44, 44))
        imageNameView.image = UIImage(named: "人物.jpg")
        txtUsr.leftView = imageNameView
        // 设置实现leftView的现实时机
        txtUsr.leftViewMode = UITextFieldViewMode.Always
        txtUsr.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view.addSubview(txtUsr)
        
        //        centerLabel = UILabel(frame: CGRectMake(0, 116, self.view.bounds.width, 2))
        //        centerLabel.backgroundColor = UIColor.init(red: 239 / 255.0, green: 238 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        //        self.view.addSubview(centerLabel)
        
        // 密码框的状态
        txtPwd = UITextField(frame: CGRectMake(0,146, UIScreen.mainScreen().bounds.width, 44))
        txtPwd.delegate = self
        txtPwd.placeholder = "密码"
        txtPwd.backgroundColor = UIColor.whiteColor()
        txtPwd.layer.borderWidth = 0.0
        txtPwd.clearButtonMode = UITextFieldViewMode.WhileEditing
        txtPwd.layer.borderColor = UIColor.magentaColor().CGColor
        let PWDimageView : UIImageView = UIImageView(frame: CGRectMake(0, 20, 44, 44))
        PWDimageView.image = UIImage(named: "密码.jpg")
        txtPwd.leftView = PWDimageView
        txtPwd.leftViewMode = UITextFieldViewMode.Always
        self.view.addSubview(txtPwd)
        
        // 忘记密码  redcolor
        let forgetButton : UIButton = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 100, 200, 90, 25))
        forgetButton.setTitle("忘记密码?", forState: UIControlState.Normal)
        forgetButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        forgetButton.alpha = 0.4
        forgetButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        //        forgetButton.titleLabel?.numberOfLines = 16
        forgetButton.backgroundColor = UIColor.init(red: 239 / 255.0, green: 238 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        forgetButton.addTarget(self, action: #selector(LoadViewController.forgetViewAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(forgetButton)
        
        // http://yngwtest.gotoip1.com/api.php/user/login?token=8c2f64f08271fc4e43&username=%E9%83%91%E7%A4%BC&password=123456
        // 确认登录
        let sureButton : UIButton = UIButton(frame: CGRectMake(20,240,UIScreen.mainScreen().bounds.width - 40,40))
        sureButton.backgroundColor = UIColor.init(red: 240 / 255.0, green: 54 / 255.0, blue: 30 / 255.0, alpha: 1.0)
        
        sureButton.setTitle("确认登录", forState: UIControlState.Normal)
        sureButton.addTarget(self, action: #selector(LoadViewController.SureAction), forControlEvents: UIControlEvents.TouchUpInside)
        sureButton.layer.cornerRadius = 5
        self.view.addSubview(sureButton)
        
        // 没有账号,去注册>>
        let NoButton : UIButton = UIButton(frame: CGRectMake(100, 308, UIScreen.mainScreen().bounds.width - 200, 30))
        NoButton.backgroundColor = UIColor.init(red: 239 / 255.0, green: 238 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        NoButton.alpha = 0.5
        NoButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        NoButton.setTitle("没有账号,去注册>>", forState: UIControlState.Normal)
        NoButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        NoButton.addTarget(self, action: #selector(LoadViewController.NONumber), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(NoButton)
        
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
        TagCancle = 200
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // 没有账号的界面
    func NONumber(){
        self.hidesBottomBarWhenPushed = true
        let goMVC  = GoMarkViewController()
        self.navigationController?.pushViewController(goMVC, animated: true)
        
    }
    
    // 忘记界面
    func forgetViewAction(){
        self.hidesBottomBarWhenPushed = true
        let passView = ForgotPassWordViewController()
        self.navigationController?.pushViewController(passView, animated: true)
    }
    
    
    
    //  确定登录的事件
    // jiguang_kefu_username
    func SureAction(){
        // http://yngwtest.gotoip1.com/api.php/user/login?token=8c2f64f08271fc4e43&username=%E9%83%91%E7%A4%BC&password=123456
        let url  = NSURL(string: "http://appv2.yngw518.com/api.php/user/login?token=8c2f64f08271fc4e43&username=" + "\(encodeEscapesURL(txtUsr.text!))" + "&password=" + txtPwd.text!)
        
        let data = NSData(contentsOfURL: url!)
        //        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        let alert = UIAlertView()
        
        if(txtUsr.text != "" && txtPwd.text == ""){
            alert.title = "请输入密码"
            alert.addButtonWithTitle("确定")
            alert.show()
        }else if(txtUsr.text == "" && txtPwd.text == ""){
            XZAlertView.addXZAlertView(self.view, title: "请输入用户名")
            
        }
        else if(txtUsr.text != nil && txtPwd.text != nil){
            var json : AnyObject?
            do{
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            }catch let error as NSError{
                print(error)
            }
            
            let meg : String = json?.objectForKey("msg") as! String
            
            let statues : Int = json!.objectForKey("status") as! Int
            
            
            if (statues == 0){
                alert.title = "\(meg)"
                alert.addButtonWithTitle("确定")
                alert.show()
            }else if (statues == 1){
                let dataa12 : NSDictionary = json?.objectForKey("data") as! NSDictionary
                
                //                let name968 : String = dataa12["name"] as! String
                //
                //                let cellPhone968 : String = dataa12["cellphone"] as! String
//                print(dataa12["name"])
//                print(dataa12["cellphone"])
//                print(dataa12["jiguang_username"])
//                print(dataa12["jiguang_password"])
//                print(dataa12["jiguang_kefu_username"])
                
                let data0:NSMutableDictionary=NSMutableDictionary.init(dictionary: dataa12)
                
                
                
                if data0["jiguang_kefu_nickname"] is NSNull {
                    data0.setValue("", forKey: "jiguang_kefu_nickname")
                }
                data0.setObject(txtPwd.text!, forKey: "password")
                
                LoadAll = data0
                
                let userDefaut=NSUserDefaults.standardUserDefaults()
                userDefaut.setValue(LoadAll, forKey: "LoadAll")
                userDefaut.synchronize()
                
                
                //                NSUserDefaults.standardUserDefaults().setValue(LoadAll, forKey: "LoadAll");
                //                NSUserDefaults.standardUserDefaults().synchronize();
                
                
                XZAlertView.addXZAlertView(self.view, title: "登录喽")
                NSNotificationCenter.defaultCenter().postNotificationName("gameOverNotification", object: LoadAll)
                
                NSNotificationCenter.defaultCenter().postNotificationName("Test", object: TagCancle)
                TagCancle = 201
                self.navigationController?.popViewControllerAnimated(true)
                
                let userId=LoadAll?.objectForKey("uid") as! String
                do{
                    let opt = try HTTP.GET(GloStr.insertPNSUser+userId+"&deviceToken="+(AppDelegate.delegate as! AppDelegate).devicetoken)
                    opt.start{result in
                        if let error = result.error{
                            print(error)
                        }else{
                        print("devicetoken success send")
                        }
                        
                    }
                }
                catch let error {
                    print("请求失败: \(error)")
                }

                
            }else{
                print("在登录界面中")
            }
        }
    }
    
    func userLoginSave() {
        NSUserDefaults.standardUserDefaults().setObject(txtUsr.text, forKey: kuserName)
        NSUserDefaults.standardUserDefaults().setObject(self.txtPwd.text, forKey: klastLoginUserName)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    /*
     "uid":"236828592",
     "username":"%E9%83%91%E7%A4%BC",
     "cellphone":"12345671118",
     "name":"",
     "qq":"",
     "content":""
     */
    
    //登录框状态枚举
    enum LoginShowType {
        case NONE
        case USER
        case PASS
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName("canclTTT", object: txtUsr.text)
    }
    
    // 进行URL编码
    func encodeEscapesURL(value:String) -> String {
        let str:NSString = value
        let originalString = str as CFStringRef
        let charactersToBeEscaped = "!*'();:@&=+$,/?%#[]" as CFStringRef  //":/?&=;+!@#$()',*"    //转意符号
        //let charactersToLeaveUnescaped = "[]." as CFStringRef  //保留的符号 101
        let result =
            CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                    originalString,
                                                    nil,    //charactersToLeaveUnescaped,
                charactersToBeEscaped,
                CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) as NSString
        
        return result as String
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
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
