//
//  TestNewsTableViewCell.swift
//  与牛共舞
//
//  Created by dm on 16/12/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class TestNewsTableViewCell: UITableViewCell {

    // 时间
    var timeLabel : UILabel!
    // 小红点
    var corHeaderImage : UIImageView!
    // 小红条
    var lastLabel : UILabel!
    // 内容
    var content11Label : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        creatView()
    }
    
    
    func creatView(){
        timeLabel = UILabel(frame: CGRectMake(7, 2, 35, 25))
        timeLabel.layer.borderColor = UIColor.clearColor().CGColor
        timeLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(timeLabel)
        
        corHeaderImage = UIImageView(frame:CGRectMake(15, 23, 15, 15))
        corHeaderImage.image = UIImage(named: "timeline2.png")
        self.contentView.addSubview(corHeaderImage)

        if (content11Label == nil){
            content11Label = UILabel(frame: CGRectMake(55, 10, KScreenWidth - 60, 75))
            content11Label.font = UIFont(name: "HelveticaNeue", size: 15)
            content11Label.numberOfLines = 0
            // 重要的
            content11Label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.contentView.addSubview(content11Label)
        }
    }
    
    
    // 给cell进行赋值
    func configureCellWithModel(model: TestNewsModel){

        // 内容
       self.content11Label.text = model.contentlaBelUrl
        self.timeLabel.text = model.timeLabelUrl
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
