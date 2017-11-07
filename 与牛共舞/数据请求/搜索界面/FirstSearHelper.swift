
//
//  FirstSearHelper.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

var TagSearch : NSString?

protocol FirstSSHelperDelegate: NSObjectProtocol {
    func FirstSearchReloadData()
}


var resultStrin : AnyObject!

class FirstSearHelper: NSObject {
    //  数据源
    var dataArray = NSMutableArray()
    // 代理属性
    weak var delegate: FirstSSHelperDelegate!
    // 创建单例
    class func moneysharedHelper() ->FirstSearHelper{
        struct NetworkSTR{
            static var helper: FirstSearHelper!
            static var onceToken: dispatch_once_t = 0
        }
        _dispatch_once(&NetworkSTR.onceToken) {
            // 这里代码只能执行一次
            NetworkSTR.helper = FirstSearHelper()
            
            
        }
        return NetworkSTR.helper
    }
    
    // 向服务器发送请求，成功解析数据
    func loadDataAndShowWithUrlStr(URLString urlStr:String){
        
        let   url = NSURL(string: urlStr)!
            
            // 创建request
            let urlRequest = NSURLRequest(URL: url)
            
            
            // 创建人物
            let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) {(data: NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                if error == nil {
                    // 进行下拉进行判断，下拉进行清除所有的数据
                    if error == nil {
                        if isSearchDow == true{
                            self.dataArray.removeAllObjects()
                        }
                    }
                    // 解析
                    let dict = try?NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    // (dict!["data"] as? NSString) != nil
                    if ((dict!["data"] as? NSString) != nil) {

                        TagSearch = dict!["data"] as? NSString

                        let center = NSNotificationCenter.defaultCenter()
//
                        center.postNotificationName("passValue", object: self, userInfo: ["value":"天气好"])
                    }else{
                       
                        // 取出字典中的items的数组
                        let itemsArray = dict!["data"] as! NSArray
                        
                        for aDict in itemsArray{
                            let modelDict = aDict as! NSDictionary
                            
                            let moneyTalkModel = SearchModel(dict: modelDict)
                            // 将模型添加都数据源中
                            // 在闭包里面，属性必须加self，闭包作为函数的参数成为尾随闭包
                            self.dataArray.addObject(moneyTalkModel)
                        }
                        
                        
                        // 刷新tableView
                        // 如果代理存在，且响应协议中的方法
                        if self.delegate != nil && self.delegate.respondsToSelector(Selector("FirstSearchReloadData")){
                            self.delegate.FirstSearchReloadData()
                        }
                        
                    }
                    
                }
        }
            // 执行任务
            dataTask.resume()
        }

        
}
