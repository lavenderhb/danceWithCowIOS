//
//  HearSayHelper.swift
//  与牛共舞
//
//  Created by dm on 16/9/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

// 协议
protocol HearSayNetworkHelperDelegate:NSObjectProtocol{
    func HearSayTableViewReloadData()
}

class HearSayHelper: NSObject {
  // 数据源
    var dataArray = NSMutableArray()
    // 代理属性
    weak var delegate : HearSayNetworkHelperDelegate!
    // 创建单例
    class func moneysharedHelper() ->HearSayHelper{
        struct NetworkSTR{
            static var HHhelper: HearSayHelper!
            static var onceToken: dispatch_once_t = 0
        }
        _dispatch_once(&NetworkSTR.onceToken) {
            // 这里代码只能执行一次
            NetworkSTR.HHhelper = HearSayHelper()
            
        }
        return NetworkSTR.HHhelper
    }
    // 向服务器发送请求,解析数据
    func loadDataAndShowWithUrlStr(URLString urlString:String){
        // 创建url 
        let url = NSURL(string:  urlString)!
        let urlRequest = NSURLRequest(URL: url)
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest){(data: NSData?, response: NSURLResponse?,error:NSError?) -> Void in
            if error == nil{
                if isSearchDow == true{
                    self.dataArray.removeAllObjects()
                }
                
               // 解析
                let dict = try?NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                // 取出字典中的items的数组
                let  itemsArray = dict!["data"] as! NSArray
                
                // 遍历数组
                for aDict in itemsArray{
                    let hearModel = aDict as!  NSDictionary
                    
                    // 通过构造方法来创建模型
                    let hearSSModel = HearSayModel(dict : hearModel)
                    self.dataArray.addObject(hearSSModel)
                    
                }
                // 刷新tableview，如果代理存在，且响应协议中的方法
                if self.delegate != nil && self.delegate.respondsToSelector(Selector("HearSayTableViewReloadData")){
                    self.delegate.HearSayTableViewReloadData()
                }
            }
        }
        // 进行执行任务
        dataTask.resume()
    }
}
