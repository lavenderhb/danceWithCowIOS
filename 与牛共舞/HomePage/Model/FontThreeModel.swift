//
//  FontThreeModel.swift
//  与牛共舞
//
//  Created by dm on 16/9/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class FontThreeModel: NSObject {

    var contentLabel : String!
    var weburl : String!
    var webId : String!
    init(dict : NSDictionary) {
        super.init()
        contentLabel = dict["title"] as? String
        weburl = dict["detail_url"] as? String
        webId = dict["id"] as! String
        
    }
}


