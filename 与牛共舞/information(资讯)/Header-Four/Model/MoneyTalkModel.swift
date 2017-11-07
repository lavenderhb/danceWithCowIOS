//
//  MoneyTalkModel.swift
//  与牛共舞
//
//  Created by dm on 16/9/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MoneyTalkModel: NSObject {
// 属性
    var imagePhoto : String!
    var contentTitle : String!
    var dataLabel : String!
    var detailURL : String!
    // 自定义的构造的方法
    init(dict : NSDictionary) {
        super.init()
        // 头像
        imagePhoto = dict["image"] as! String
        contentTitle = dict["title"] as! String
        dataLabel = dict["times"] as! String
        detailURL = dict["detail_url"] as! String
    }
    
    
}
