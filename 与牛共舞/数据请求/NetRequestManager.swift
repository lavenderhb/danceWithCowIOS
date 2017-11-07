//
//  NetRequestManager.swift
//  ReviewTableViewAndLearnSwift
//
//  Created by Dm on 16/9/13.
//  Copyright © 2016年 Dm. All rights reserved.
//

import UIKit

class NetRequestManager: NSObject {

    var TestURL = "http://app.yngw518.com/api/artlist/0/5?token=8c2f64f08271fc4e43"
    enum 网络请求类型 {
       case GET请求
       case POST请求
    }
//    searchs100
    class func 请求网络数据(参数1 网址:String,参数2 请求类型:网络请求类型,参数3 POST字典:[String:String]?, 请求成功闭包:((成功参数:NSData)->()), 请求失败闭包:((失败参数:NSError)->()) ) {
        let 网络请求 = NetRequestManager()
        guard let 字典内容 = POST字典 else{
        网络请求 .GET请求网络数据(参数1: "http://app.yngw518.com/api/artlist/0/5?token=8c2f64f08271fc4e43", 请求成功闭包: 请求成功闭包, 请求失败闭包: 请求失败闭包)
            return
            print(网络请求)
        }
        网络请求.请求网络数据(参数1: 网址, 参数2:请求类型 , 参数3: 字典内容, 请求成功闭包: 请求成功闭包, 请求失败闭包: 请求失败闭包)
    }
    
    func 根据字典返回请求体Data(请求体字典:[String:String])->(NSData){
        var 数组:[String] = []
        for key in 请求体字典.keys{
            let 拼接字符串 = key + "=" + 请求体字典[key]!
            数组.append(拼接字符串)
        }
        let 请求串:String = 数组.joinWithSeparator("&")
        return 请求串.dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    func 请求网络数据(参数1 网址:String,参数2 请求类型:网络请求类型,参数3 POST字典:[String:String], 请求成功闭包:((参数:NSData)->()), 请求失败闭包:((参数:NSError)->()) ) {
        let url = NSURL(string: 网址)
        let request = NSMutableURLRequest.init(URL: url!)
        request.timeoutInterval = 10
        if(请求类型 == 网络请求类型.POST请求){
            request.HTTPMethod = "POST"
            if(POST字典.count > 0){
                request.HTTPBody = 根据字典返回请求体Data(POST字典)
            }
        }
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            if let 成功返回Data = data {
                请求成功闭包(参数: 成功返回Data)
            }
            if let 失败返Error = error {
                请求失败闭包(参数: 失败返Error)
            }
        }
        task.resume()
    }
    
    func GET请求网络数据(参数1 网址:String, 请求成功闭包:((参数:NSData)->()), 请求失败闭包:((参数:NSError)->()) ) {
        
        let url = NSURL(string: "http://app.yngw518.com/api/artlist/0/5?token=8c2f64f08271fc4e43")
        let request = NSMutableURLRequest.init(URL: url!)
        request.timeoutInterval = 10
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            if let 成功返回Data = data {
                请求成功闭包(参数: 成功返回Data)
                print(成功返回Data)
                return
            }
            if let 失败返Error = error {
                请求失败闭包(参数: 失败返Error)
                return
            }
        }
        task.resume()
    }
}
