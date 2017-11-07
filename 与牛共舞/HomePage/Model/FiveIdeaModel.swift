//
//  FiveIdeaModel.swift
//  与牛共舞
//
//  Created by Mac on 16/9/12.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit


class FiveIdeaModel: NSObject {

    // 属性
    var iconUrl : String!
    // cell中的内容
    var titleCell : String?
    
    var cowFiveUrl1 : String?
    init(dict : NSDictionary) {
        super.init()
        titleCell = dict["title"] as? String
        
        cowFiveUrl1 = dict["detail_url"] as? String
        
    }
}
