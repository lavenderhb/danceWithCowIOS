//
//  TTTTTViewController.swift
//  与牛共舞
//
//  Created by dm on 16/10/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import Foundation


class TTTTTViewController: UIViewController {
    @IBOutlet weak var sg_Order: UISegmentedControl!
    
    @IBOutlet weak var view_Order: UIView!
    
    var tttView : UIImageView!
    var CCCview : UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

//    tttView = UIImageView(frame: CGRectMake(50, 60, 100, 100))
//        CCCview = UIImageView(frame: CGRectMake(50, 60, 90, 90))
//        CCCview.layer.cornerRadius = 45
//        CCCview.backgroundColor = UIColor.whiteColor()
//        CCCview.layer.masksToBounds = true
//        tttView.addSubview(CCCview)
//    tttView.layer.cornerRadius = 50
//    tttView.layer.masksToBounds = true
////    tttView.backgroundColor = UIColor.redColor()
//    self.view_Order.addSubview(tttView)
//        
//        
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 200,y: 200), radius: CGFloat(50), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
//        
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = circlePath.CGPath
//        
//        //change the fill color
//        shapeLayer.fillColor = UIColor.whiteColor().CGColor
//        //you can change the stroke color
//        shapeLayer.strokeColor = UIColor.redColor().CGColor
//        //you can change the line width
//        shapeLayer.lineWidth = 1.0
//        
//        self.view_Order.layer.addSublayer(shapeLayer)
//
        
        let alertController = UIAlertController(title: "通知", message: "确定还是取消", preferredStyle: UIAlertControllerStyle.Alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型
        
        let alertView1 = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            print("确定按钮点击事件")
            
        }
        
        let alertView2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            print("取消按钮点击事件")
            
        }
        
        let alertView3 = UIAlertAction(title: "下次吧", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            print("下次吧按钮点击事件")
            
        }
        alertController.addAction(alertView1)
        
        alertController.addAction(alertView2)
        
        alertController.addAction(alertView3) // 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
        
        let label = UILabel(frame: CGRectMake(60, 60, 200, 400))
        
        label.font = UIFont.systemFontOfSize(12)
        
        label.backgroundColor = UIColor.grayColor()
        label.numberOfLines = 0
        self.view_Order.addSubview(label)
//
        let str = "这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string这是需要处理的string"
        
        let NSMAString = NSMutableAttributedString.init(string: str)
        
        let NSMPStyle = NSMutableParagraphStyle()
        
        //设置行间距为28
        NSMPStyle.lineSpacing = 15
        
        NSMAString.addAttribute(NSParagraphStyleAttributeName, value: NSMPStyle, range: NSMakeRange(0, (str.characters.count)))
        
        label.attributedText = NSMAString
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBarHidden = true
        
        
        
        
        //创建NSURL对象
        let url:NSURL! = NSURL(string: "00")
        //创建请求对象
        let urlRequest:NSURLRequest = NSURLRequest(URL: url)
//        print(urlRequest)
       
        //响应对象
        var response:NSURLResponse?
        
        do{
            //发送请求
            let data:NSData? = try NSURLConnection.sendSynchronousRequest(urlRequest,
                                                                          returningResponse: &response)
            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            
            
        }catch let error as NSError{
            //打印错误消息
            print(error.description)
        }
     let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest){(data: NSData?, response:NSURLResponse?, error:NSError?) -> Void in
        if error == nil {
            
        }
        let dict = try?NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        
        if ((dict!["data"] as? NSString) == nil) {
//            print("99991")
        }
  
//        let itemArray = dict["data"] as! NSArray
        
//        print(dict)
//        print(dict["data"]!["username"])
        
    }
        
        dataTask.resume()
        
        
        
        
        // Do any additional setup after loading the view.
    }
   
   
    
    @IBAction func onSegmentItemClicked(sender: AnyObject) {
        
        switch(sender.selectedSegmentIndex){
        case 0:
//            let array1 = [self.view_Order.subviews] as NSArray
//            if ([array1.count] == 2) {//如果用于切换页面的view中已经有了两个子页面，那么就去掉一个，这样可以实现segment的无限制次数的切换
//                array1.objectAtIndex(1).removeFromSuperview()
//            }
            let orderservingview = HeadLineViewController()
            orderservingview.viewDidLoad()//同样在切换的时候需要启动页面加载函数
//            orderservingview.view.width(self.view_Order.width())
            [self.view_Order.addSubview(orderservingview.view)];
            break;
        case 1:
//            let array1 = [self.view_Order.subviews] as NSArray
//            if ([array1.count] == 2) {
//                array1.objectAtIndex(1).removeFromSuperview()
//            }
            let orderhistoryview = NewsFlahViewController()//第二个用于切换的controller
            orderhistoryview.viewDidLoad()
//            orderhistoryview.view.width(self.view_Order.width())
            [self.view_Order.addSubview(orderhistoryview.view)];
            break;
        default:
            break;
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
         
         //        var name = String()
         self.hidesBottomBarWhenPushed = true
         
         
         let url  = NSURL(string: "http://appv2.yngw518.com/api.php/user/login?token=8c2f64f08271fc4e43&username=" + ")" + "&password=" + "")
         let data = NSData(contentsOfURL: url!)
         //        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
         //        print(str)
         
         let alert = UIAlertView()
         
         
         if(txtUsr.text == ""){
         alert.title = "请输入密码"
         alert.addButtonWithTitle("确定")
         TagCancle = 200
         }else if (txtUsr.text == ""){
         XZAlertView.addXZAlertView(self.view, title: "请输入用户名")
         TagCancle = 200
         }
         else if(txtUsr.text != nil){
         var json : AnyObject?
         do{
         json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
         }catch let error as NSError{
         print(error)
         }
         
         let meg : String = json?.objectForKey("msg") as! String
         let dataa12 : NSDictionary = json?.objectForKey("data") as! NSDictionary
         
         //                print(dataa12)
         
         
         
         LoadID   = dataa12["uid"] as? NSNumber
         
         if (dataa12 .isEqual(nil)){
         alert.title = "\(meg)"
         alert.addButtonWithTitle("确定")
         alert.show()
         }else{
         LoadAll = dataa12
         
         XZAlertView.addXZAlertView(self.view, title: "登录喽")
         NSNotificationCenter.defaultCenter().postNotificationName("gameOverNotification", object: LoadAll)
         //                    print(dataa12["uid"])
         
         //                    let Qiao  : String = (dataa12["username"] as? String)!
         
         //                   LoadName = encodeEscapesURL("%25E9%2583%2591%25E7%25A4%25BC")
         //                    LoadName = "郑礼吗"
         NSNotificationCenter.defaultCenter().postNotificationName("Test", object: TagCancle)
         TagCancle = 201
         self.navigationController?.popViewControllerAnimated(true)
         
         }
         }
        
        
        
    }
    


}
