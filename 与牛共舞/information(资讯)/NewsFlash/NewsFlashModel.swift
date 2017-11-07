//
//  NewsFlashModel.swift
//  与牛共舞
//
//  Created by dm on 16/10/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
// 快讯的model
class NewsFlashModel: NSObject {

    var timeLabelUrl : String!
    var contentlaBelUrl : String!
    
    init(dict : NSDictionary) {
        timeLabelUrl = dict["times"] as! String
        contentlaBelUrl = dict["content"] as! String
        
    }
    
    
    
    
    
}
