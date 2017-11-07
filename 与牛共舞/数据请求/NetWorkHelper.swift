//
//  NetWorkHelper.swift
//  与牛共舞
//  Created by Mac on 16/9/12.
//  Copyright © 2016年 Mac. All rights reserved.


import UIKit

// swift 中的协议
protocol NetWorkHelperDelegate : NSObjectProtocol{
    func tableViewReloadData()
}

class NetWorkHelper: NSObject {
// 注意,静态属性只能在类里面的进行声明,不能卸载方法里面
    
    // 数据源
    var dataArray = NSMutableArray()
    // 代理属性
    weak var delegate : NetWorkHelperDelegate!
    
    // 创建单例
    class func sharedHelper() -> NetWorkHelper {
        struct NetWorkSTR{
            static var helper : NetWorkHelper!
            static var onceToken : dispatch_once_t = 0
        }
        
       dispatch_once (&NetWorkSTR.onceToken){ () -> Void in
        // 在这里代码只会被执行一次
        NetWorkSTR.helper = NetWorkHelper()
        }
        return NetWorkSTR.helper
    }
    
    // 向服务器发送请求,成功以后解析数据
    func loadDataAndShowWithUrlStr(URLString urlStr: String){
        
        // 创建url
        let url = NSURL(string: urlStr)!
        // 创建request
        let urlRequest = NSURLRequest(URL: url)
        // 创建人物
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data : NSData?, respone : NSURLResponse?, error : NSError?) -> Void in
           
            if error == nil{
                // http://appv2.yngw518.com/api.php/column/0/5?token=8c2f64f08271fc4e43
                // 解析data
//                let dict = try!NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                  let dict11 = try?NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let dogString:String = (NSString(data: data!, encoding: NSUTF8StringEncoding))! as String // UTF8转String
                
                // 取出字典中的items的数组
                let itemsArray = dict11?["data"] as? NSArray
                // 遍历数组
                for aDict in itemsArray!{
                   let modelDict = aDict as?  NSDictionary
                    
                    // 通过构造方法创建模型
                    let FiveDeaModel = FiveIdeaModel(dict: modelDict!)
                    // 通过构造方法创建模型
                    // 在闭包的时候,属性必须加self,闭包作为函数的参数称为尾随闭包
                    self.dataArray.addObject(FiveDeaModel)
//                    // 将模型添加数据源中
//                    // 在闭包中,属性必须加入self,闭包作为函数的参数称为尾随闭包
//                    self.dataArray.addObject(fiveMode)
                }
                // 刷新tableview.如果代理存在,且响应协议中的方法
                if self.delegate != nil && self.delegate.respondsToSelector(Selector("tableViewReloadData")){
                    self.delegate.tableViewReloadData()
                }
                
                
            }
            
            
        }
        // 执行任务
        dataTask.resume()
        
    }

}
