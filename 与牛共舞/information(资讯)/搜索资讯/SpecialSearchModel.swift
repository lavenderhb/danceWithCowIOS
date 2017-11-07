
//
//  SpecialSearchModel.swift
//  与牛共舞
//
//  Created by dm on 16/10/28.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class SpecialSearchModel: NSObject {

    var headImageUrl : String!
    var contentUrl : String!
    var timelabelUrl : String!
    var detailUrl : String!
    
    init(dict : NSDictionary) {
        headImageUrl = dict["image"] as! String
        contentUrl = dict["title"] as! String
        timelabelUrl = dict["times"] as! String
        detailUrl = dict["detail_url"] as! String
    }
    
    
}
