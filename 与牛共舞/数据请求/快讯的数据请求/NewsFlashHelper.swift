
//  NewsFlashHelper.swift
//  与牛共舞
//
//  Created by dm on 16/10/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

// 协议
protocol NewsFlashHelperDelegate : NSObjectProtocol{
    func NewFlashHelperReloadData()
}

class NewsFlashHelper: NSObject {
    // 静态属性只能在类里面声明, 不能卸载方法里面
    //    static var helper: NetworkHelper!
    //    static var onceToken: dispatch_once_t = 0
    
    // 数据源
    var dataArray = NSMutableArray()
    //存储日期的数组
    var ddd = NSMutableArray()
    // 代理属性
    weak var delegate: NewsFlashHelperDelegate!
    
    // 创建单例
    class func sharedHelper() -> NewsFlashHelper {
        struct NetworkSTR {
            static var helper: NewsFlashHelper!
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&NetworkSTR.onceToken) { () -> Void in
            // 这里的代码只会被执行一次
            NetworkSTR.helper = NewsFlashHelper()
        }
        return NetworkSTR.helper
    }
    
    // 向服务器发送请求, 成功以后解析数据
    func loadDataAndShowWithUrlStr(URLString urlStr: String) {
        
        // 创建url
        let url = NSURL(string: urlStr)!
        
        // 创建request
        let urlRequest = NSURLRequest(URL: url)
        
        // 创建人物
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if error == nil {
//                if isDown == true {
//                    // 如果是下拉, 就清除所有数据
//                    self.dataArray.removeAllObjects()
//                }
                
                // 解析data
                let dict = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                // 取出字典中的items数组
                let itemsArray = dict!["data"] as! NSArray
//                 遍历数组
                for aDict in itemsArray {
                    let modelDict = aDict as! NSDictionary
//                    print(modelDict)
                    //每次循环都重新声明一个数组去存放一天的model
                    let dayArr = NSMutableArray();
                    let DDDDQQ = modelDict["sub"] as! NSArray
                    let datesStr = modelDict["dates"] as! String
                    self.ddd.addObject(datesStr);
                    for Detailllsc in DDDDQQ{
                        let WWWqqq = Detailllsc as! NSDictionary
//                        print(WWWqqq)
                        // 通过构造方法创建模型
                        let qiuBaiModel = NewsFlashModel(dict: WWWqqq)
                        
                        // 将模型添加到数据源中
                        // 在闭包中, 属性必须加self, 闭包作为函数的参数称为尾随闭包
                        dayArr.addObject(qiuBaiModel)
                    }
                    self.dataArray.addObject(dayArr);
                   
                }
                
                
                // 刷新tableView
                // 如果代理存在, 且响应协议中的方法
                if self.delegate != nil && self.delegate.respondsToSelector(Selector("NewFlashHelperReloadData")) {
                    self.delegate.NewFlashHelperReloadData()
                }
                
            }
        }
        // 执行任务
        dataTask.resume()
    }
  
    
    
    
    
    
    
    
    
    
    
}
