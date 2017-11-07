//
//  HomeCollectionViewCell.swift
//  与牛共舞
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
@objc(HomeCollectionViewCell)
class HomeCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.imageView.layer.cornerRadius = 30
    }

}
