//
//  FontThreeTableViewCell.swift
//  与牛共舞
//
//  Created by Mac on 16/8/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
@objc(FontThreeTableViewCell)
class FontThreeTableViewCell: UITableViewCell {

    @IBOutlet weak var FontThreeCellBackView: UIView!

    @IBOutlet weak var HeaderImageView: UIImageView!
    
    @IBOutlet weak var FontThreeLable: UILabel!
    
    @IBOutlet weak var FontThreeLastImageView: UIImageView!
    
    var webUrlstring : NSString!
    
    var  id : NSString!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.FontThreeCellBackView.backgroundColor = UIColor.whiteColor()
        self.HeaderImageView.layer.cornerRadius = 8
        
        FontThreeLable.font =  UIFont.systemFontOfSize(15)
        self.FontThreeLastImageView.image = UIImage(named: "推荐.jpg")
    }
    
    
    // 给cell赋值
    func configureFontCellWithModel(model:FontThreeModel){
        self.FontThreeLable.text = model.contentLabel
        self.webUrlstring = model.weburl
        self.id = model.webId
   
//        self.FontThreeLable.adjustsFontSizeToFitWidth = true
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
