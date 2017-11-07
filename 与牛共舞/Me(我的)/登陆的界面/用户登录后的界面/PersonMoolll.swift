
//
//  PersonMoolll.swift
//  与牛共舞
//
//  Created by dm on 16/11/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

    let path=(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask, true)[0] as String).stringByAppendingString("user.data")
        
        class PersonMoolll: NSObject,NSCoding{
            
            var name:NSString!
            var phone:NSString!
            
            func encodeWithCoder(aCoder: NSCoder){
                aCoder.encodeObject(self.name, forKey: "name")
                aCoder.encodeObject(self.phone, forKey: "phone")
            }
            
            required init(coder aDecoder: NSCoder) {
                super.init()
                self.name = aDecoder.decodeObjectForKey("name") as! NSString!
                self.phone = aDecoder.decodeObjectForKey("phone") as! NSString!
            }
            
            override init() {
                
            }
            
       
    
}
