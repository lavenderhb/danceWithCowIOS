//
//  dealnumview.swift
//  YuNiuGongWu
//
//  Created by 章如强 on 16/11/7.
//  Copyright © 2016年 章如强. All rights reserved.
//

import UIKit

class screenViewdealnumview: UIView {
    
    
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
    init(){         //初始化
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.whiteColor()
        self.contentMode = .Redraw
        
    }
    required init?(coder aDecoder: NSCoder) {   //条件下初始化  与init互存
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {  //视图中指示图位置及大小  价格图与成交量图
        super.layoutSubviews()
        
        
        
    }
    
    
    
    override func drawRect(rect: CGRect) {
        //总文字信息
        let dateTextAttrs = [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.whiteColor()]//下方时间数字字体信息 字体大小 字体颜色lightGrayColor
        var cjlnum = cjl as NSString
        let cjlnumSize = cjlnum.sizeWithAttributes(dateTextAttrs)
        let cjlnumPoint = CGPoint(x:(UIScreen.mainScreen().bounds.width*2/6 - 30 - cjlnumSize.width)/2, y: 8)
        cjlnum.drawAtPoint(cjlnumPoint, withAttributes: dateTextAttrs)
        
        var cjlmoney = cje as NSString
        let cjlmoneySize = cjlmoney.sizeWithAttributes(dateTextAttrs)
        let cjlmoneyPoint = CGPoint(x: (UIScreen.mainScreen().bounds.width*2/6 - 30 - cjlmoneySize.width)/2, y: 28)
        cjlmoney.drawAtPoint(cjlmoneyPoint, withAttributes: dateTextAttrs)
    }
    
    
    
}
