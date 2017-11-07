//
//  SpecialModel.swift
//  与牛共舞
//
//  Created by Mac on 9/19/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class SpecialModel: NSObject {

    // 属性
    // 头像
    var photoImage:String!
    // 内容
    var contentLabel : String!
    
    var timeLabel : String!
    
    var webUrl : String!
    // 自定义的构造方法
    
    init(dict:NSDictionary) {
        super.init()
        photoImage = dict["image"] as! String
        
        contentLabel = dict["title"] as! String
        
        timeLabel = dict["times"] as! String
        
        webUrl = dict["detail_url"] as! String
    }
    
    
    
}
