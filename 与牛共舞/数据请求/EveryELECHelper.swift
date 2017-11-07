//
//  EveryELECHelper.swift
//  与牛共舞
//
//  Created by dm on 16/9/26. View
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
// 协议
protocol EveryELEHelperDelegate: NSObjectProtocol{
    func EverytableViewReloadData()
}

class EveryELECHelper: NSObject {
    
    // 数据源
    var dataArraty = NSMutableArray()
    // 代理属性
    weak var delegate: EveryELEHelperDelegate!
    // 创建单例
    class func everyysharedHelp() ->EveryELECHelper {
        struct ENetworkSTR{
            static var helper: EveryELECHelper!
            static var onceToken:dispatch_once_t = 0
        }
        dispatch_once(&ENetworkSTR.onceToken){
            // 这里代码只是执行一次
            ENetworkSTR.helper = EveryELECHelper()
        }
        return ENetworkSTR.helper
    }
    
    // 向服务器发送请求，解析数据源
    func loadDataAndShowWithUrlStr(URLString urlStr: String){
        let url = NSURL(string: urlStr)!
        let urlRequest = NSURLRequest(URL:url)
        // 创建人物
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest){(data: NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if error == nil{
            // 进行下拉进行和判断，下拉清除所有的数据
                if error == nil{
                    if isEveryDown == true{
                        self.dataArraty.removeAllObjects()
                    }

                    // 解析
                let dict = try?NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                // 取出字典中的items的数组
                let itemsArray = dict!["data"] as! NSArray
                    // 便利数组
                    for aDict in itemsArray{
                        let modelDict = aDict as! NSDictionary
                        let eveDayModel = EveryDayModel(dict: modelDict)
                        self.dataArraty.addObject(eveDayModel)
                    }
                
            }
            // 刷新tableView,如果代理存在，且响应协议中的方法
            if self.delegate != nil && self.delegate.respondsToSelector(Selector("EverytableViewReloadData")){
                self.delegate.EverytableViewReloadData()
            }
        }
     }
        // 执行任务
        dataTask.resume()
    }
}
