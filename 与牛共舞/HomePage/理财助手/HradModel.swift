
//
//  HradModel.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class HradModel: NSObject {

    var nameLabelUrl : String!
    var imageUrl : String!
    var detailUrl : String!
    init(dict : NSDictionary) {
        super.init()
        nameLabelUrl = dict["name"] as? String
        imageUrl =  dict["image"] as? String
        detailUrl = dict["detail_url"] as? String
    }
}
