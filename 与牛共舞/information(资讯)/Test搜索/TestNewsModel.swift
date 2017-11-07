//
//  TestNewsModel.swift
//  与牛共舞
//
//  Created by dm on 16/12/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit


class TestNewsModel: NSObject {

    var timeLabelUrl : String!
    var contentlaBelUrl : String!
    
    init(dict : NSDictionary) {
        timeLabelUrl = dict["times"] as! String
        contentlaBelUrl = dict["content"] as! String
    }
}
