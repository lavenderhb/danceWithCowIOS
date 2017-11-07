//
//  InformationViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var TestNumber = 17

var ViewSecondNSArrayControllers : NSArray!
@objc(InformationViewController)
class InformationViewController: UIViewController {

    var segment =  UISegmentedControl()

    var everyView = HeadLineViewController()
    
    var tiaoID:AnyObject? = ""
    
    var pianyi : AnyObject? = ""
    
    var scrollView : DMScrolSegmentView!
    var newsView = NewsFlahViewController()
    var  InforTestTOPView  = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.init(red: 246 / 255.0, green: 85 / 255.0 , blue: 22 / 255.0, alpha: 1.0)
        
        // 隐藏导航栏 **** 关键点,非常重要 EveryDayViewController
        self.navigationController?.navigationBarHidden = true
        
        // 自己定义的SDK
        let titleArr : NSArray = ["头条","快讯", "专栏"];
        // NewsFlahViewController    TwoNewsTableViewController
        ViewSecondNSArrayControllers = [HeadLineViewController(),NewsFlahViewController(), SpecialColumnViewController()];
        
        // 使用封装的SDK
         scrollView = DMScrolSegmentView(controllers11: ViewSecondNSArrayControllers as! [UIViewController] , titles: titleArr as! [String])
        
//        scrollView = DMScrolSegmentView(controllers: )
        
        self.navigationController?.navigationBar.translucent = false;

        let BarButton : UIButton = UIButton(frame: CGRectMake(self.view.bounds.width - 47,27, 30,30))
//        BarButton.backgroundColor = UIColor.redColor()
        BarButton.setImage(UIImage(named: "搜索001.png"), forState: UIControlState.Normal)
        BarButton.addTarget(self, action: #selector(InformationViewController.BarAction), forControlEvents: UIControlEvents.TouchUpInside)
        BarButton.adjustsImageWhenHighlighted = false
        self.view.addSubview(scrollView)
        self.view.addSubview(BarButton)
        
        scrollView.show()
    }

    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    
        MobClick.beginLogPageView("PageThree")
    }
    
    
    
    func BarAction(){
        self.hidesBottomBarWhenPushed = true
        let seraVC = SpecialSearchViewController()
        
        self.navigationController?.pushViewController(seraVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
        
    }
    
    func tiao(noti:NSNotification){
        self.tiaoID = noti.object
//        self.pianyi = noti.object  NSInteger tiao
        
        if let something = noti.userInfo{
//            let number = something["偏移量"]!  as! NSNumber
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2), dispatch_get_main_queue()) {
//                if ([self.scrollView.jumpCoumMentVC(2)] != nil){
                    self.scrollView?.jumpCoumMentVC(2)
                
                    let aaa:SpecialColumnViewController = ViewSecondNSArrayControllers[2] as! SpecialColumnViewController
                    aaa.tiaoID = self.tiaoID;
            }
        }
    }
    
    func pianyi(pianyi : NSNotification){
        self.pianyi = pianyi.object
        
        if let othering = pianyi.userInfo{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2), dispatch_get_main_queue()){
             self.scrollView?.jumpCoumMentVC(0)
                
                let bbb : HeadLineViewController = ViewSecondNSArrayControllers[0] as! HeadLineViewController
                bbb.pianyi = self.pianyi
                
            }
        }
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
