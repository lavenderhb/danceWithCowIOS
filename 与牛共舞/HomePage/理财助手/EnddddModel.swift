


//
//  EnddddModel.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class EnddddModel: NSObject {
    var nameLabelUrl : String!
    var imageUrl : String!
    var whenUrl : String!
    var detailURL :  String!
    
    init(dict : NSDictionary) {
        super.init()
        nameLabelUrl = dict["name"] as? String
        imageUrl =  dict["photo"] as? String
        whenUrl = dict["worktime"] as? String
        detailURL = dict["detail_url"] as? String
        
    }
}
