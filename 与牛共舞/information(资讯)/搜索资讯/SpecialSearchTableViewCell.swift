
//
//  SpecialSearchTableViewCell.swift
//  与牛共舞
//
//  Created by dm on 16/10/28.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class SpecialSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var HeaderImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 赋值 headImmm
    func configureCellWithModel(model : SpecialSearchModel){
        self.TimeLabel.text = model.timelabelUrl
        self.titleLabel.text   = model.contentUrl
        self.HeaderImage.sd_setImageWithURL(NSURL(string: model.headImageUrl))
        
        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
