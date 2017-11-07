//
//  ForgotPassWordViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class ForgotPassWordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    self.navigationItem.title = "联系我们"
    self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
//        UIApplication.sharedApplication().openURL(NSURL(string :"tel://15974462468")!)
    
        let telphone : UILabel = UILabel(frame: CGRectMake(20, 70, 90, 30))
        telphone.text = "联系电话："
        
        let Number : UIButton = UIButton(frame: CGRectMake(100, 70, 140, 30))
        Number.setTitle("025-68150303", forState: UIControlState.Normal)
        Number.setTitleColor(UIColor.init(red: 46 / 255.0, green: 128 / 255.0 , blue: 231 / 255.0, alpha: 1.0), forState: UIControlState.Normal)
        Number.addTarget(self, action: #selector(ForgotPassWordViewController.NumberPhomneAC), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(telphone)
        self.view.addSubview(Number)
        
        let backbb  = UIButton(frame: CGRectMake(0, 0, 30, 30))
        //        backbb.backgroundColor = UIColor.blackColor()
        backbb.setImage(UIImage(named: "back4"), forState: UIControlState.Normal)
        backbb.backgroundColor = UIColor.clearColor()
        backbb.adjustsImageWhenHighlighted = false
        backbb.addTarget(self, action: #selector(SearchViewController.backToPrevious), forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftBarBtn = UIBarButtonItem(customView: backbb)
        
        
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -20;
        
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func NumberPhomneAC(){
        
        let alertView = UIAlertView()
        alertView.title = "025-68150303"
        alertView.addButtonWithTitle("取消")
        alertView.addButtonWithTitle("确定")
        alertView.cancelButtonIndex=0
        alertView.delegate=self;
        alertView.show()
        
        
        
        
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        if(buttonIndex==alertView.cancelButtonIndex){
        }
        else
        {
            UIApplication.sharedApplication().openURL(NSURL(string :"tel://025-68150303")!)
        }
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
