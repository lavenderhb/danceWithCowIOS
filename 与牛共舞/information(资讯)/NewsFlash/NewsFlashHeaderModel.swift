
//
//  NewsFlashHeaderModel.swift
//  与牛共舞
//
//  Created by lanouhn on 16/11/12.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class NewsFlashHeaderModel: NSObject {

    var timeLabelUrl : String!
    var dayLabelUrl : String!
    var monthLabelUrl : String!
    var contentLabelUrl : String!
    
    init(dic : NSDictionary){
     timeLabelUrl = dic["data"] as! String
     monthLabelUrl = dic["data"] as! String
//    contentLabelUrl = dic["data"] as! String
    }
    
    
}
