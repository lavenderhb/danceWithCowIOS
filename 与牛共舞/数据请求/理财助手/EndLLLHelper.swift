//
//  EndLLLHelper.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

// 协议
protocol EndLLLHelperDelegate : NSObjectProtocol{
    func EndLLLHelperData()
}

class EndLLLHelper: NSObject {

    
    
    // 数据源
    var dataArray = NSMutableArray()
    // 代理属性
    weak var delegate : EndLLLHelperDelegate!
    
    // 创建单例
    class func sharedHelper() ->EndLLLHelper{
        struct NetWorkSTR{
            static var helper : EndLLLHelper!
            static var onceToken : dispatch_once_t = 0
        }
        dispatch_once(&NetWorkSTR.onceToken) { () -> Void in
            // 在这里代码只会被执行一次
            NetWorkSTR.helper = EndLLLHelper()
        }
        return NetWorkSTR.helper
    }
    // 向服务器发送请求，解析数据
    func loadDataAndShowWithUrlStr(URLString urlStr : String){
        // 创建url
        let url = NSURL(string: urlStr)!
        // 创建request
        let urlRequest = NSURLRequest(URL: url)
        // 创建人物
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data : NSData?, respone : NSURLResponse?, error : NSError?) -> Void in
            
            if error == nil{
                // 下拉清除所有的数据
                if  isLAZCDOwn == true{
                    self.dataArray.removeAllObjects()
                }
                // 解析data
                let dict = try?NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                
                    // 取出字典中的items的数组
                    let itemsArray = dict!["data"] as! NSArray
                    // 遍历数组
                    for aDict in itemsArray{
                        let modelDict = aDict as!  NSDictionary
                        
                        // 通过构造方法创建模型
                        
                        let NextServiceHeaderModell = EnddddModel(dict: modelDict)
                        // 通过构造方法创建模型
                        // 在闭包的时候,属性必须加self,闭包作为函数的参数称为尾随闭包
                        self.dataArray.addObject(NextServiceHeaderModell)
                        
                    }

                
                // 刷新tableview.如果代理存在,且响应协议中的方法
                if self.delegate != nil && self.delegate.respondsToSelector(Selector("EndLLLHelperData")){
                    self.delegate.EndLLLHelperData()
                }
            }
        }
        // 执行任务
        dataTask.resume()
    }

    
}
