//
//  SpecialYJTableViewCell.swift
//  与牛共舞
//
//  Created by Mac on 16/9/10.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class SpecialYJTableViewCell: UITableViewCell {

    var contectLabel : UILabel!
    
    var  titleLabel : UILabel!
    
    var bBBackView : UIView!
    
    var headerImage : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = UIColor.init(red: 239 / 255.0, green: 239 / 255.0, blue:   239 / 255.0, alpha: 1.0)
        
        bBBackView = UIView(frame: CGRectMake(0, 10, UIScreen.mainScreen().bounds.width, 90))
        bBBackView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(bBBackView)
        
        if (headerImage == nil){
            headerImage = UIImageView()
            headerImage.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
//            headerImage.layer.cornerRadius = 5
            self.bBBackView.addSubview(headerImage)
        }
        
        if(contectLabel == nil){
            contectLabel = UILabel()
            contectLabel.frame = CGRect(x: 95 , y: 10, width: 300, height: 30)
            contectLabel.font = UIFont.systemFontOfSize(13)
            self.bBBackView.addSubview(contectLabel)
            
        }
        if (titleLabel == nil) {
            titleLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 65, 65, 50, 25))
            titleLabel.font = UIFont.systemFontOfSize(11)
            self.bBBackView.addSubview(titleLabel)
        }
        
    }
    
    // 给cell赋值
    func configureCellWithModel(model: SpecialModel){
        
        if model.photoImage != nil{
            self.headerImage.sd_setImageWithURL(NSURL(string: model.photoImage)!)
        }
        self.contectLabel.text = model.contentLabel
        
        self.titleLabel.text =  model.timeLabel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
