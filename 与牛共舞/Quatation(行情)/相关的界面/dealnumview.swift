//
//  dealnumview.swift
//  YuNiuGongWu
//
//  Created by 章如强 on 16/10/7.
//  Copyright © 2016年 章如强. All rights reserved.
//

import UIKit

class dealnumview: UIView {
    
    
    var cjl: String! {
        
        didSet {
            
            self.setNeedsDisplay()
            
        }
        
    }
    
    
    var cje: String! {
        
        didSet {
            
            self.setNeedsDisplay()
            
        }
        
    }
    init(){
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.whiteColor()
        self.contentMode = .Redraw
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
    
    
    
    override func drawRect(rect: CGRect) {
        
        let dateTextAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.whiteColor()]
        let cjlnum = cjl as NSString
        let cjlnumSize = cjlnum.sizeWithAttributes(dateTextAttrs)
        let cjlnumPoint = CGPoint(x:(UIScreen.mainScreen().bounds.width*2/6 - 30 - cjlnumSize.width)/2, y: 8)
        cjlnum.drawAtPoint(cjlnumPoint, withAttributes: dateTextAttrs)
        
        
        
        let cjlmoney = cje as NSString
        let cjlmoneySize = cjlmoney.sizeWithAttributes(dateTextAttrs)
        let cjlmoneyPoint = CGPoint(x: (UIScreen.mainScreen().bounds.width*2/6 - 30 - cjlmoneySize.width)/2, y: 38)
        cjlmoney.drawAtPoint(cjlmoneyPoint, withAttributes: dateTextAttrs)
    }
    
    
    
}
