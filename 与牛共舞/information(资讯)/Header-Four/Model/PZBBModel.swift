//
//  PZBBModel.swift
//  与牛共舞

//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.

import UIKit

class PZBBModel: NSObject {
 
    var  headerImageUrl : String!
    var  titleLabelUrl : String!
    var  contentLabelUrl : String!
    var detaUrl : String!
    init(dict : NSDictionary) {
        super.init()
        headerImageUrl = dict["image"] as! String
        titleLabelUrl = dict["title"] as! String
        contentLabelUrl = dict["content"] as! String
        detaUrl = dict["detail_url"] as! String!
        
    }
}
