//
//  MineTableViewCell.swift
//  与牛共舞
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bigLabel: UILabel!
    
    @IBOutlet weak var smiallLabel: UILabel!
    
    @IBOutlet weak var littleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
