//
//  TestCollectionViewCell.swift
//  与牛共舞
//
//  Created by Mac on 16/9/9.
//  Copyright © 2016年 Mac. All rights reserved.


import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    var tittleLabell : UILabel!
    var imageView : UIImageView!
    var backLabel : UILabel!
    var righetLabel : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        
        imageView = UIImageView(frame: CGRectMake(10,0, 56, 56))
//        imageView?.backgroundColor = UIColor.redColor()
        imageView.layer.cornerRadius = 28
        imageView.layer.masksToBounds = true
        
        
        righetLabel = UILabel(frame: CGRectMake(self.contentView.bounds.width - 2, 0, 2, 65))
        righetLabel.backgroundColor = UIColor.grayColor()
        righetLabel.alpha = 0.1
        
        tittleLabell = UILabel(frame: CGRectMake( 5, 67, 67, 28))
        tittleLabell.adjustsFontSizeToFitWidth = true
        tittleLabell?.backgroundColor = UIColor.whiteColor()
        
        backLabel = UILabel()
        backLabel?.frame = CGRectMake(5, 95, 67, 3)
        backLabel.alpha = 0.7
        backLabel?.backgroundColor = UIColor.redColor()
        
        self.addSubview(backLabel!)
        self.addSubview(tittleLabell!)
        self.addSubview(imageView!)
        self.addSubview(righetLabel!)
 
    }
    // 给cell进行赋值
    func configureCellWithModel(model : TopServiceModel){
        if (model.imageUrl != nil){
            self.imageView!.sd_setImageWithURL(NSURL(string: model.imageUrl))
        }else{
        }
        self.tittleLabell.text = model.nameLabelUrl
        
    }
    
}
