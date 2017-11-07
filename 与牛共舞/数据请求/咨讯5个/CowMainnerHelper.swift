//
//  CowMainnerHelper.swift
//  与牛共舞
//
//  Created by dm on 16/10/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

// swift中的协议
protocol CowsMainerHelperDelegate: NSObjectProtocol {
    func CowsMainerViewReloadData()
}

class CowMainnerHelper: NSObject {

    //  数据源
    var dataArray = NSMutableArray()
    // 代理属性
    weak var delegate: CowsMainerHelperDelegate!
    // 创建单例
    class func moneysharedHelper() ->CowMainnerHelper{
        struct NetworkSTR{
            static var helper: CowMainnerHelper!
            static var onceToken: dispatch_once_t = 0
        }
        _dispatch_once(&NetworkSTR.onceToken) {
            // 这里代码只能执行一次
            NetworkSTR.helper = CowMainnerHelper()
            
            
        }
        return NetworkSTR.helper
    }
    
    // 向服务器发送请求，成功解析数据
    func loadDataAndShowWithUrlStr(URLString urlStr:String){
        // 创建url
        let url = NSURL(string: urlStr)!
        // 创建request
        let urlRequest = NSURLRequest(URL: url)
        
        // 创建人物
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) {(data: NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if error == nil {
                // 进行下拉进行判断，下拉进行清除所有的数据
                if error == nil {
                    if isCowMainDown == true{
                        self.dataArray.removeAllObjects()
                    }
                }
                // 解析
                let dict = try?NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                // 取出字典中的items的数组
                    let itemsArray = dict!["data"] as! NSArray
                    for aDict in itemsArray{
                        let modelDict = aDict as! NSDictionary
                        
                        // 通过构造方式来创建模型
                        let moneyTalkModel = CowMinnerModel(dict: modelDict)
                        // 将模型添加都数据源中
                        // 在闭包里面，属性必须加self，闭包作为函数的参数成为尾随闭包
                        self.dataArray.addObject(moneyTalkModel)
                }
                
                // 刷新tableView
                // 如果代理存在，且响应协议中的方法
                if self.delegate != nil && self.delegate.respondsToSelector(Selector("CowsMainerViewReloadData")){
                    self.delegate.CowsMainerViewReloadData()
                }
            }
        }
        // 执行任务
        dataTask.resume()
    }
    

    
}
