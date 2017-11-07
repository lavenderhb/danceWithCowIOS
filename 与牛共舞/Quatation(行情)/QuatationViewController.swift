//
//  QuatationViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class QuatationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("fiveonefive_main") as! ViewController
        self.presentViewController(anotherView, animated: true, completion: nil)
        self.hidesBottomBarWhenPushed = false
        
//        self.navigationItem.title = "第一个界面"
////        UISegmentedControl
//        self.view.backgroundColor = UIColor.grayColor()
//        
//        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
//
//        let button = UIButton(frame: CGRectMake(80, 100, 60, 50))
//        button.backgroundColor = UIColor.redColor()
//        button.addTarget(self, action: #selector(QuatationViewController.BackAction), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(button)
//        
//        
//        
////        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("fiveonefive_main") as! ViewController
////        self.presentViewController(anotherView, animated: true, completion: nil)
//        let alertController = UIAlertController(title: "通知", message: "确定还是取消", preferredStyle: UIAlertControllerStyle.Alert) // 这里因为控件都不存在改变的可能，所以一律使用let类型
//        
//        let alertView1 = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
//            print("确定按钮点击事件")
//            
//        }
//        let alertView2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
//            
//            print("取消按钮点击事件")
//            
//        }
        
//        let alertView3 = UIAlertAction(title: "下次吧", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
//            
//            print("下次吧按钮点击事件")
//        }
//        alertController.addAction(alertView1)
//        
//        alertController.addAction(alertView2)
//        
//        alertController.addAction(alertView3) // 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
////        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func BackAction(){
//        self.hidesBottomBarWhenPushed = true
//        let nnn = TDLiveSteamingViewController()
//        self.presentViewController(nnn, animated: true, completion: nil);
//        self.hidesBottomBarWhenPushed = false
        print("行情界面")
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("fiveonefive_main") as! ViewController
        self.presentViewController(anotherView, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
      // 界面将要出现的时候让友盟统计进行数据的记录
         MobClick.beginLogPageView("PageTwo")
//        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("fiveonefive_main") as! ViewController
//        self.presentViewController(anotherView, animated: true, completion: nil)
    }

    override func viewWillDisappear(animated: Bool) {
     super.viewWillDisappear(animated)
        // 页面即将消失的时候出现的进行记录
        MobClick.endLogPageView("PageTwo")
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
