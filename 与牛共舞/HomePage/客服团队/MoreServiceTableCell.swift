//
//  MoreServiceTableCell.swift
//  与牛共舞
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MoreServiceTableCell: UITableViewCell {


    @IBOutlet weak var BBBBview: UIView!
    
    @IBOutlet weak var manLabel: UILabel!
    
    @IBOutlet weak var headerView: UIImageView!
    
    @IBOutlet weak var simpleLabel: UILabel!
    
    @IBOutlet weak var whenLabel: UILabel!
  
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var redmessages: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.contentView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 45,y: 52), radius: CGFloat(34), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.whiteColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.init(red: 230 / 255.0, green: 94 / 255.0, blue: 99 / 255.0, alpha: 1.0).CGColor
        
        //you can change the line width
        shapeLayer.lineWidth = 2.0
        
        
        self.BBBBview.layer.addSublayer(shapeLayer)
        
        self.headerView.layer.cornerRadius = 32
//                headerView.backgroundColor = UIColor.init(red: 255 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.8)
        headerView.layer.masksToBounds = true
        
        shapeLayer.addSublayer(headerView.layer)
        
        redmessages.image = UIImage(named:"red_pod")
        
        self.whenLabel.text  = "从业时间"
        manLabel.textColor = UIColor.redColor()
        self.manLabel.adjustsFontSizeToFitWidth = true
        self.whenLabel.adjustsFontSizeToFitWidth = true
        self.timeLabel.adjustsFontSizeToFitWidth = true
        // Configure the view for the selected state
    }
    
    func configureCellWithModel(model : NextServiceModel){
        // 进行cell的赋值
        headerView.sd_setImageWithURL(NSURL(string: model.imageUrl))
        manLabel.text = model.name
        timeLabel.text = model.worktime
        simpleLabel.text = model.content
        if model.hasNew == true{
            redmessages.hidden=false
        }else{
            redmessages.hidden=true
        }
    }
}
