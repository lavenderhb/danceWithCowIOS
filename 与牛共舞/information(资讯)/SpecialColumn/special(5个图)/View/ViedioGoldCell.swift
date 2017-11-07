//
//  ViedioGoldCell.swift
//  与牛共舞
//
//  Created by dm on 16/11/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class ViedioGoldCell: UITableViewCell {

    var ViediotextLabbel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
   ViediotextLabbel = UILabel(frame: CGRectMake(5, 5, UIScreen.mainScreen().bounds.width / 2, 35))
        
//    ViediotextLabbel.backgroundColor = UIColor.redColor()
    ViediotextLabbel.font = UIFont.systemFontOfSize(15)
        
        self.contentView.addSubview(ViediotextLabbel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    // 给cell进行赋值
    func configureCellWithModel(model: ViedioGoldModel){
  
        self.ViediotextLabbel?.text = model.contentLabel
        
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
