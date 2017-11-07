//
//  CanTalkWithServiceViewController.swift
//  与牛共舞
//
//  Created by dm on 16/11/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import JMessage
import SnapKit


//internal let interval = 60
//internal let messagePageNumber = 25
//internal let messageFristPageNumber = 20
var talkServicTextField : UITextField!


class CanTalkWithServiceViewController: UIViewController {

    var faceButton : UIButton!
    
    // 信息条
    var messageTable:UITableView!

//    var messageInputView : 
    
    var endView : UIView!
    var backView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.title = "客服郑助理"
        
        
        backView = UIView(frame: CGRectMake(0, 0, KScreenWidth, KScreenHeight))
        backView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(backView)
        
        let backbb  = UIButton(frame: CGRectMake(15, 0, 20, 20))
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
        creatView()
    }
    
    func creatView(){
        endView = UIView(frame: CGRectMake(0, KScreenHeight - 50, KScreenWidth, 50))
        endView.backgroundColor = UIColor.init(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1.0)
        self.view.addSubview(endView)
        
        talkServicTextField = UITextField(frame: CGRectMake(5, 5, KScreenWidth - 55, 40))
        talkServicTextField.borderStyle = .RoundedRect
        talkServicTextField.backgroundColor = UIColor.whiteColor()
        endView.addSubview(talkServicTextField)
        
        faceButton = UIButton(frame: CGRectMake(KScreenWidth - 45, 5, 40, 40))
        faceButton.backgroundColor = UIColor.clearColor()
        faceButton.setImage(UIImage(named: "22.jpg"), forState: UIControlState.Normal)
        endView.addSubview(faceButton)
    }
    
    
    //返回按钮点击响应
    func backToPrevious(){
        TagCancle = 200
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 

    
    
    
    
    
    
    
    
    
    // 进行隐藏的键盘
    func hideKeyBoardAnimation() {
        //  操作完成,调用主线程进行刷新界面
        dispatch_async(dispatch_get_main_queue()) {
            UIApplication.sharedApplication().sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, forEvent: nil)
        }
        UIApplication.sharedApplication().sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, forEvent: nil)
        //    UIApplication.sharedApplication().sendAction(<#T##action: Selector##Selector#>, to: <#T##AnyObject?#>, from: <#T##AnyObject?#>, forEvent: <#T##UIEvent?#>)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
