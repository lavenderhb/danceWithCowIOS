//
//  BaseViewController.swift
//  与牛共舞
//
//  Created by yansy on 2017/10/29.
//  Copyright © 2017年 Mac. All rights reserved.
//

import Foundation


class BaseViewController:UIViewController {
    override func viewDidLoad() {
        GloMethod.insertViewController(self)
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        GloMethod.removeViewController(self)
        super.viewDidDisappear(animated)
    }
    func jumpView(view:Int){
    
    }
    
    
    
}
