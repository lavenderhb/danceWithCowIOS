
//
//  TestTTTT.swift
//  与牛共舞  SMS_SDK
//
//  Created by dm on 16/11/10.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit


class TestTTTT: UIViewController {

    
    var dataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.navigationItem.title = "行情"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        
//        JMessage.addDelegate(<#T##delegate: JMessageDelegate!##JMessageDelegate!#>, withConversation: <#T##JMSGConversation!#>)
        let num : UIButton = UIButton(frame: CGRectMake(10, 100, 100, 30))
        num.backgroundColor = UIColor.redColor()
        num.addTarget(self, action: #selector(TestTTTT.sasad), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num)
        
        let nnnn : UIButton = UIButton(frame: CGRectMake(10,200, 100, 30))
        nnnn.backgroundColor = UIColor.blackColor()
        nnnn.addTarget(self, action: #selector(TestTTTT.nnnn), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nnnn)
        
        //初始化模拟数据
//        onCreateData()
    }
    
    //创建模拟数据
    func onCreateData(){
        dataModel.userList.append(UserInfo(name: "张三", phone: "1234"))
        dataModel.userList.append(UserInfo(name: "李四", phone: "1212"))
        dataModel.userList.append(UserInfo(name: "航歌", phone: "3525"))
        
        dataModel.loadData()
    }
    
    //保存数据
  func sasad() {
    
    self.hidesBottomBarWhenPushed = true
    let nacv = TDLiveSteamingViewController()
    self.navigationController?.pushViewController(nacv, animated: true)
    self.hidesBottomBarWhenPushed = false
    }
    
    //读取数据
    func nnnn() {
        dataModel.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
