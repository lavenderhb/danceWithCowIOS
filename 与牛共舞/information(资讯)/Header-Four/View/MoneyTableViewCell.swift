//
//  MoneyTableViewCell.swift
//  与牛共舞
//
//  Created by Mac on 9/19/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class MoneyTableViewCell: UITableViewCell {
    
    // 背景视图
    var backView : UIView!
    
    // 图片
    var photoImageView:UIImageView!
    
    // 内容条
    var contentLabel:UILabel!
    
    
    
    // 时间
    var timeLael : UILabel!
    // 填充视图
//    var contentBackView : UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        // 添加所有的子视图
        addAllViews()
        
    }

    // 内容cell的填充项
    func addAllViews(){
        self.contentView.backgroundColor = UIColor.init(red: 239 / 255.0, green: 239 / 255.0, blue:   239 / 255.0, alpha: 1.0)
        
        self.backView = UIView(frame: CGRectMake(0, 8, UIScreen.mainScreen().bounds.size.width, 90))
        self.backView.backgroundColor = UIColor.whiteColor()
        
        self.contentView.addSubview(backView)
        // 头像视图
        if (photoImageView == nil){
            photoImageView = UIImageView(frame: CGRectMake(4, 3, 74, 74))
            photoImageView.backgroundColor = UIColor.lightGrayColor()
            photoImageView.layer.cornerRadius = 5.0
            self.backView.addSubview(photoImageView)
        }
        
        if(contentLabel == nil){
            // 内容条
            contentLabel = UILabel(frame: CGRectMake(102, 10, self.contentView.bounds.width - 106, 40))
            // 字体的大小
            contentLabel.font  = UIFont.systemFontOfSize(13)
            contentLabel.backgroundColor = UIColor.whiteColor()
            self.backView.addSubview(contentLabel)
        }
        
        if(timeLael == nil){
            timeLael = UILabel(frame: CGRectMake(self.contentView.bounds.width, 70, 40, 20))
//            timeLael.backgroundColor = UIColor.grayColor()
            timeLael.adjustsFontSizeToFitWidth = true
            timeLael.font = UIFont.systemFontOfSize(11)
            self.backView.addSubview(timeLael)
        }
        
    }

    // 给cell进行赋值
    func configureCellWithModel(model: MoneyTalkModel){
        
        // 如果头像的接口存在
        if model.imagePhoto != nil {
            self.photoImageView.sd_setImageWithURL(NSURL(string: model.imagePhoto)!)
        }
        // 内容
        self.contentLabel.text = model.contentTitle
        self.timeLael.text = model.dataLabel
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
