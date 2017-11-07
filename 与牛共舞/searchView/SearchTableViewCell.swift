


//
//  SearchTableViewCell.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var HeaderImmge: UIImageView!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    // 赋值 headImmm
    func configureCellWithModel(model : SearchModel){
        self.timeLabel.text = model.timelabelUrl
        self.titleLabel.text   = model.contentUrl
        self.HeaderImmge.sd_setImageWithURL(NSURL(string: model.headImageUrl))        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
