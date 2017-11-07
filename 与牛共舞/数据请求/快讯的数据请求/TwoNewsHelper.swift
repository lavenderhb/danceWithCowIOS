//
//  MaindataHelper.swift
//  与牛共舞
//
//  Created by dm on 16/12/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

// swift 中的协议
protocol TwoNewsWorkHelperDelegagte : NSObjectProtocol{
    func TwoNewsTableViewReloadData()
}

class TwoNewsHelper: NSObject {
    
    // 数据源
    var dataArray = NSMutableArray()
    
    // 存储日期的数组
    var  timeArray = NSMutableArray()
    // 代理属性
    weak var delegate : TwoNewsWorkHelperDelegagte!
    // 创建单例
    class func moneysharedHelper() ->TwoNewsHelper{
        struct NetworkSTR{
            static var HHhelper: TwoNewsHelper!
            static var onceToken: dispatch_once_t = 0
        }
        _dispatch_once(&NetworkSTR.onceToken) {
            // 这里代码只能执行一次
            NetworkSTR.HHhelper = TwoNewsHelper()
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
                if isTwoNewsDown == true{
                    self.dataArray.removeAllObjects()
                }
                // 解析
                let dict = try?NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                // 取出字典中的items的数组
                let  itemsArray = dict!["data"] as! NSArray
                // 遍历数组
                for aDict in itemsArray{
                    let hearModel = aDict as!  NSDictionary
                    let dataTTimeArray = hearModel["date"] as! String
                    self.timeArray.addObject(dataTTimeArray)
                    // 通过构造方法来创建模型
                    let hmainmodel = TestNewsModel(dict: hearModel)
                    self.dataArray.addObject(hmainmodel)
                }
                // 刷新tableview，如果代理存在，且响应协议中的方法
                if self.delegate != nil && self.delegate.respondsToSelector(Selector("TwoNewsTableViewReloadData")){
                    self.delegate.TwoNewsTableViewReloadData()
                }
            }
        }
        // 进行执行任务
        dataTask.resume()
    }
   
    
}
