//
//  TableViewCell.swift
//  与牛共舞
//
//  Created by Mac on 16/8/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

     var title:UILabel!
    var  title1 : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /**
     初始化方法
     */
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil){
            title = UILabel(frame: CGRectMake(20, 20, 200, 30))
//            title.backgroundColor = UIColor.grayColor()
//            title1 = UILabel(frame: CGRectMake(0, 0, 15, 30))
//            title1.backgroundColor = UIColor.cyanColor()
//            title1.text = "666666"
//            self.contentView.addSubview(title1)
            self.contentView.addSubview(title)
        }
    }
    
    
    /**
     报错修复的  是什么鬼?
     */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
