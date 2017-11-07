//
//  BDTableCell.swift
//  dancewithcow
//
//  Created by 章如强 on 16/5/10.
//  Copyright © 2016年 章如强. All rights reserved.
//

import UIKit

class BDTableCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var symbol: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var percent: UILabel!
    
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
