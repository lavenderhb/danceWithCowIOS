//
//  ZXTableViewCell.swift
//  dancewithcow
//
//  Created by 雷伊潇 on 16/10/5.
//  Copyright © 2016年 org.com.abc. All rights reserved.
//

import UIKit

class ZXTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var symbol: UILabel!
    
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var percent: UILabel!
    
    @IBOutlet weak var percentm: UILabel!
    @IBOutlet weak var code: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
