


//
//  ViedioGoldModel.swift
//  与牛共舞
//
//  Created by dm on 16/11/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class ViedioGoldModel: NSObject {

    var contentLabel : String!
    var webUrl : String!
    // 自定义构造器的方法
    init(dict : NSDictionary) {
        super.init()
        
        contentLabel = dict["title"]  as! String
        webUrl = dict["detail_url"] as! String
    }
}
