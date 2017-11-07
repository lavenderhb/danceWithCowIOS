//
//  PZBBTableViewCell.swift
//  与牛共舞
//
//  Created by dm on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class PZBBTableViewCell: UITableViewCell {

    var backView : UIView!
    var headerImageviwe : UIImageView!
    var titleLabel : UILabel!
    var contentLabel  : UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addallViews()
    }
    
    func addallViews(){
        
        backView = UIView(frame: CGRectMake(5, 10, UIScreen.mainScreen().bounds.width - 10, 85))
        backView.backgroundColor = UIColor.whiteColor()
        self.addSubview(backView)
        
        headerImageviwe = UIImageView(frame: CGRectMake(8, 15, 64, 64))
//        headerImageviwe.backgroundColor = UIColor.redColor()
        headerImageviwe.layer.cornerRadius = 32
        headerImageviwe.layer.masksToBounds = true
        backView.addSubview(headerImageviwe)
        
        titleLabel = UILabel(frame: CGRectMake(80, 7, UIScreen.mainScreen().bounds.width - 100, 25))
//        titleLabel.backgroundColor = UIColor.redColor()
        titleLabel.font = UIFont.systemFontOfSize(18)
        backView.addSubview(titleLabel)
        
        contentLabel = UILabel(frame: CGRectMake(80, 40, UIScreen.mainScreen().bounds.width - 90, 43))
//        contentLabel.backgroundColor = UIColor.redColor()
        contentLabel.font = UIFont.systemFontOfSize(14)
        contentLabel.numberOfLines = 0
        contentLabel.alpha = 0.6
        backView.addSubview(contentLabel)
    }
    
    // 给cell赋值
    func configureCellWithModel(model : PZBBModel){
        
        // 内容页
        self.titleLabel?.text = model.titleLabelUrl
        
        self.headerImageviwe.sd_setImageWithURL(NSURL(string: model.headerImageUrl))
        
        self.contentLabel.text = model.contentLabelUrl
   
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
