//
//  NextServiceModel.swift
//  与牛共舞
//
//  Created by dm on 16/10/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class NextServiceModel: NSObject {

    
    var content : String!//描述
    var detailURL :  String!//详细url
    var originalId :  NSNumber!//客服id
    var name : String!//客服名称
    var imageUrl : String!//客服头像url
    var team : String!//所属
    var worktime : String!//开始工作时间
    
    var hasNew : Bool!
    
    override init() {
        super.init()
    }
    
    init(dict : NSDictionary) {
        super.init()
        content = dict["content"] as? String
        detailURL = dict["detailUrl"] as? String
        originalId = dict["originalId"] as? NSNumber
        name=dict["name"] as? String
        imageUrl=dict["image"] as? String
        team=dict["team"] as? String
        worktime=dict["worktime"] as? String
        hasNew=false
    }

}
