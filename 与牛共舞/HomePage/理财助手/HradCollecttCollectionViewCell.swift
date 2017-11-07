//
//  HradCollecttCollectionViewCell.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class HradCollecttCollectionViewCell: UICollectionViewCell {
    
    var righetLabel : UILabel!
    var  tittleLabell : UILabel!
    var imageView : UIImageView!
    var backLabel  : UILabel!
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
        
        tittleLabell = UILabel(frame: CGRectMake( 5, 60, 67, 28))
        tittleLabell?.backgroundColor = UIColor.whiteColor()
        tittleLabell.adjustsFontSizeToFitWidth = true
        righetLabel = UILabel(frame: CGRectMake(self.contentView.bounds.width - 2, 0, 2, 65))
        righetLabel.backgroundColor = UIColor.grayColor()
        righetLabel.alpha = 0.1
        
        
        backLabel = UILabel()
        backLabel?.frame = CGRectMake(5, 87, 67, 3)
        backLabel.alpha = 0.7
        backLabel?.backgroundColor = UIColor.redColor()
        
        self.addSubview(righetLabel)
        self.addSubview(backLabel!)
        self.addSubview(tittleLabell!)
        self.addSubview(imageView!)
        
    }
    // 给cell进行赋值
    func configureCellWithModel(model : HradModel){
        if (model.imageUrl != nil){
            self.imageView!.sd_setImageWithURL(NSURL(string: model.imageUrl))
            
        }else{
        }
        self.tittleLabell.text = model.nameLabelUrl
        
    }
    
    
}
