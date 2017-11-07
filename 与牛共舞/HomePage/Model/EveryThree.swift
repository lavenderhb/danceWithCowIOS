//
//  EveryThree.swift
//  与牛共舞
//
//  Created by dm on 16/9/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class EveryThree: NSObject {

    var contentLabel : String!
    var everyWeburl : String!
    var colamLabel : String!
    init(dict : NSDictionary) {
        super.init()
        contentLabel = dict["title"] as? String
        everyWeburl = dict["detail_url"] as? String
        colamLabel = dict["colname"] as? String
        
    }
}
