//
//  UserInfo.swift
//  与牛共舞
//
//  Created by dm on 16/11/10.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit


class UserInfo: NSObject {

    var name:String
    var phone:String
    
    //构造方法
    init(name:String="",phone:String=""){
        self.name = name
        self.phone = phone
        super.init()
    }
    
    //从nsobject解析回来
    init(coder aDecoder:NSCoder!){
        self.name=aDecoder.decodeObjectForKey("Name") as! String
        self.phone=aDecoder.decodeObjectForKey("Phone") as! String
    }
    
    //编码成object
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encodeObject(name,forKey:"Name")
        aCoder.encodeObject(phone,forKey:"Phone")
    }
}
