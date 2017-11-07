//
//  CarrrViewCell.swift
//  与牛共舞
//
//  Created by Mac on 16/9/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class CarrrViewCell: UITableViewCell {

    @IBOutlet weak var CarBackImage: UIView!
    
    @IBOutlet weak var headerimageView: UIImageView!


    
    @IBOutlet weak var centerImage: UIImageView!
    @IBOutlet weak var colamnLabel: UILabel!
    @IBOutlet weak var carHeaderImage: UIImageView!

    @IBOutlet weak var carLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
        
    }
    // 给cell赋值
    func configureFontCellWithModel(model:EveryThree){
        self.carLabel.text = model.contentLabel
        self.carLabel.font = UIFont.systemFontOfSize(14)
        self.colamnLabel.text = model.colamLabel
        self.colamnLabel.font = UIFont.systemFontOfSize(14)
//        self.carLastimage.image = UIImage(named: "APP1_62")
//        self.centerImage.image = UIImage(named: "22.jpg")
//        self.carLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
