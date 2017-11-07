//
//  TreeNodeTableViewCell.swift
//  TreeTableVIewWithSwift
//
//  Created by 二六三 on 15/10/24.
//  Copyright © 2015年 robertzhang. All rights reserved.
//

import UIKit

class TreeNodeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var background: UIView!  //单元背景
    @IBOutlet weak var nodeName: UILabel!  //单元名称
    @IBOutlet weak var nodeIMG: UIImageView! 
    @IBOutlet weak var nodeDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
