
//  MoneyDayCell.swift
//  与牛共舞
//
//  Created by Mac on 9/20/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
// 每日电讯的界面
class MoneyDayCell: UITableViewCell {

    @IBOutlet weak var photoimage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var BBBackView: UIView!
    var backView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.backgroundColor = UIColor.init(red: 239 / 255.0, green: 239 / 255.0, blue:   239 / 255.0, alpha: 1.0)
        
        BBBackView.backgroundColor = UIColor.whiteColor()
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.photoimage.layer.cornerRadius = 5.0
        
        // Configure the view for the selected state
    }
    // 给cell赋值
    func configureCellWithModel(model: EveryDayModel){
        self.photoimage.sd_setImageWithURL(NSURL(string: model.photoImage))
        self.contentLabel.text = model.contentLabel

        
        
        self.timeLabel.text = model.timeLabel
    }
 
  
}
