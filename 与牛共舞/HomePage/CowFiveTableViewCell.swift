//
//  CowFiveTableViewCell.swift
//  与牛共舞
//
//  Created by Mac on 16/9/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
// 这个是关于牛股情报战队的cell的设定
class CowFiveTableViewCell: UITableViewCell {


    @IBOutlet weak var LastImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 给cell赋值
    func configureCellWithModel(model : FiveIdeaModel){
        
        // 内容页
        self.textLabel?.text = model.titleCell
        self.textLabel?.alpha = 0.55
        self.textLabel?.font = UIFont.systemFontOfSize(14)

    }

    
}
