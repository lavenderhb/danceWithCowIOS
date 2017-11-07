//
//  EndTTTViewCell.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class EndTTTViewCell: UITableViewCell {

    
    @IBOutlet weak var BBBBVIew: UIView!
    
    @IBOutlet weak var headerImagegg: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ContentLabel: UILabel!
    
    @IBOutlet weak var FontLabel: UILabel!
    
    @IBOutlet weak var timeLaebel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
    }
    
    
    // 给cell进行赋值
    func configureCellWithModel(model : EnddddModel){
        if (model.imageUrl != nil){
            self.headerImagegg!.sd_setImageWithURL(NSURL(string: model.imageUrl))
            
        }else{
            print("")
        }
        self.nameLabel.text = model.nameLabelUrl
        
        self.timeLaebel.text = model.whenUrl
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        headerImagegg.layer.cornerRadius = 32
        headerImagegg.backgroundColor = UIColor.redColor()
        headerImagegg.layer.masksToBounds = true
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 45,y: 52), radius: CGFloat(35), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.whiteColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.init(red: 230 / 255.0, green: 94 / 255.0, blue: 99 / 255.0, alpha: 1.0).CGColor
        
        //you can change the line width
        shapeLayer.lineWidth = 2.0
        
        self.BBBBVIew.layer.addSublayer(shapeLayer)
        shapeLayer.addSublayer(headerImagegg.layer)
        
        
        ContentLabel.text = "与牛共舞"
        FontLabel.text = "从业时间"
        // Configure the view for the selected state
    }
    
}
