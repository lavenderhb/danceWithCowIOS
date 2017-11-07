
//
//  UserManViewController.swift
//  与牛共舞
//
//  Created by dm on 16/11/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class UserManViewController: UIViewController {

    var UserButton : UIButton!
    
    var NameButton : UIButton!
    
    var QQButton : UIButton!
    
    var PersonButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationItem.title = "个人资料"
        self.view.backgroundColor = UIColor(red: 233 / 256.0, green: 235 / 256.0, blue: 239 / 256.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        creatView()
    
        let backbb  = UIButton(frame: CGRectMake(0, 0, 30, 30))
        //        backbb.backgroundColor = UIColor.blackColor()
        backbb.setImage(UIImage(named: "back00"), forState: UIControlState.Normal)
        backbb.backgroundColor = UIColor.clearColor()
        backbb.adjustsImageWhenHighlighted = false
        backbb.addTarget(self, action: #selector(SearchViewController.backToPrevious), forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftBarBtn = UIBarButtonItem(customView: backbb)
        
        
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10;
        
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }
        
    
    func creatView(){
        // 用户名
        UserButton = UIButton(frame: CGRectMake(0, 64, KScreenWidth, 50))
        UserButton.backgroundColor = UIColor.whiteColor()
        let endLabel1 : UILabel = UILabel(frame: CGRectMake(0, 49, KScreenWidth, 1))
        endLabel1 .backgroundColor = UIColor.grayColor()
        endLabel1.alpha = 0.1
        
        let firstLabel = UILabel(frame: CGRectMake(10, 10, 100, 30))
        firstLabel.text = "用户名"
        firstLabel.backgroundColor = UIColor.whiteColor()
        
        let right1Label  = UILabel(frame: CGRectMake(KScreenWidth - 60, 10, 50, 30))
//        right1Label.backgroundColor = UIColor.grayColor()
        right1Label.alpha = 0.3
        right1Label.text = LoadAll!["username"]?.stringByRemovingPercentEncoding!
        right1Label.textAlignment = .Center
        right1Label.font = UIFont.systemFontOfSize(12)
        
        UserButton.addSubview(firstLabel)
        UserButton.addSubview(endLabel1)
        UserButton.addSubview(right1Label)
        self.view.addSubview(UserButton)
        
        // 姓名
        NameButton = UIButton(frame: CGRectMake(0, 114, KScreenWidth, 50))
        NameButton.backgroundColor = UIColor.whiteColor()
        let endLabel2 = UILabel(frame: CGRectMake(0, 49, KScreenWidth,  1))
        endLabel2.backgroundColor = UIColor.grayColor()
        endLabel2.alpha = 0.1
        
        let firstLabel2 = UILabel(frame: CGRectMake(10, 10, 100, 30))
        firstLabel2.text = "姓名"
        firstLabel2.backgroundColor = UIColor.whiteColor()
        
        let rightImage = UIImageView(frame: CGRectMake(KScreenWidth - 25, 18, 15, 15))
        rightImage.backgroundColor = UIColor.whiteColor()
        rightImage.image = UIImage(named: "arrow-right.png")
        
        let right1Label2  = UILabel(frame: CGRectMake(KScreenWidth - 70, 10, 40, 30))
//        right1Label2.backgroundColor = UIColor.grayColor()
        right1Label2.alpha = 0.3
        right1Label2.font = UIFont.systemFontOfSize(13)
        right1Label2.text = "未填写"
        right1Label2.textAlignment = .Center
        NameButton.addTarget(self, action: #selector(UserManViewController.NmaeAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        NameButton.addSubview(firstLabel2)
        NameButton.addSubview(rightImage)
        NameButton.addSubview(endLabel2)
        NameButton.addSubview(right1Label2)
        self.view.addSubview(NameButton)
        
        // QQ号
        QQButton = UIButton(frame: CGRectMake(0, 164, KScreenWidth, 50))
        QQButton.backgroundColor = UIColor.whiteColor()
        let endLabel3 = UILabel(frame: CGRectMake(0, 49, KScreenWidth, 1))
        endLabel3.backgroundColor = UIColor.grayColor()
        endLabel3.alpha = 0.1
        
        let firstLabel3 = UILabel(frame: CGRectMake(10, 10, 100, 30))
        firstLabel3.text = "qq号"
        firstLabel3.backgroundColor = UIColor.whiteColor()
        
        let rightImage2 = UIImageView(frame: CGRectMake(KScreenWidth - 25, 18, 15, 15))
        rightImage2.backgroundColor = UIColor.whiteColor()
        rightImage2.image = UIImage(named: "arrow-right.png")
        
        let right1Label3  = UILabel(frame: CGRectMake(KScreenWidth - 70, 10, 40, 30))
//        right1Label3.backgroundColor = UIColor.grayColor()
        right1Label3.alpha = 0.3
        right1Label3.text = "未填写"
        right1Label3.font = UIFont.systemFontOfSize(13)
        right1Label3.textAlignment = .Center
        QQButton.addTarget(self, action: #selector(UserManViewController.QQAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        QQButton.addSubview(firstLabel3)
        QQButton.addSubview(endLabel3)
        QQButton.addSubview(rightImage2)
        QQButton.addSubview(right1Label3)
        self.view.addSubview(QQButton)
        
        // 个人说明
        PersonButton = UIButton(frame: CGRectMake(0, 214, KScreenWidth, 50))
        PersonButton.backgroundColor = UIColor.whiteColor()
        let endLabel4 = UILabel(frame: CGRectMake(0, 49, KScreenWidth, 1))
        endLabel4.backgroundColor = UIColor.grayColor()
        endLabel4.alpha = 0.1
        
        let firstLabel4 = UILabel(frame: CGRectMake(10, 10, 100, 30))
        firstLabel4.text = "个人说明"
        firstLabel4.backgroundColor = UIColor.whiteColor()
        
        let rightImage4 = UIImageView(frame: CGRectMake(KScreenWidth - 25, 18, 15, 15))
        rightImage4.backgroundColor = UIColor.whiteColor()
        rightImage4.image = UIImage(named: "arrow-right.png")
        
        let right1Label4  = UILabel(frame: CGRectMake(KScreenWidth - 70, 10, 40, 30))
//        right1Label4.backgroundColor = UIColor.grayColor()
        right1Label4.alpha = 0.3
        right1Label4.font = UIFont.systemFontOfSize(13)
        right1Label4.text = "未填写"
        right1Label4.textAlignment = .Center
        PersonButton.addTarget(self, action: #selector(UserManViewController.PersonAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        PersonButton.addSubview(firstLabel4)
        PersonButton.addSubview(endLabel4)
        PersonButton.addSubview(rightImage4)
        PersonButton.addSubview(right1Label4)
        self.view.addSubview(PersonButton)
        
    }
    
    // 姓名
    func NmaeAction(){
        self.hidesBottomBarWhenPushed = true
        let name = NameView()
        self.navigationController?.pushViewController(name, animated: true)
    }
    
    
    // qq号
    func QQAction(){
        self.hidesBottomBarWhenPushed = true
        let QQ = QQView()
        self.navigationController?.pushViewController(QQ, animated: true)
        
    }
    
    // 个人信息
    func PersonAction(){
        self.hidesBottomBarWhenPushed = true
        let person = PersonViewController()
        self.navigationController?.pushViewController(person, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation/Users/dm/Downloads APP1_62.png
/Users/dm/Downloads/与牛共舞 2/与牛共舞/数据请求/与牛共舞_1/arrow-right.png
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
