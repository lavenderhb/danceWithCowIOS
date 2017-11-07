
//
//  MainTableViewCell.swift
//  与牛共舞
//
//  Created by dm on 16/10/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    var photoImage : UIImageView!
    var  titleLabel : UILabel!
    var timeLabel : UILabel!
    
    var backView : UIView!
    // 间隙
    let lRMargin : CGFloat = 5
    let uRMargin : CGFloat = 10
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style  : style,reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = UIColor.init(red: 239 / 255.0, green: 239 / 255.0, blue:   239 / 255.0, alpha: 1.0)
        addAllViews()
    }
    
    
    func addAllViews(){
        
        backView = UIView(frame: CGRectMake(0, 10, UIScreen.mainScreen().bounds.width, 90))
        backView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(backView)
        
        photoImage = UIImageView(frame:CGRectMake(0, 0, 90, 90))
        photoImage.layer.cornerRadius = 10.0
        photoImage.image = UIImage(named: "22.jpg")
        //        photoImage.backgroundColor = UIColor.redColor()
        self.backView.addSubview(photoImage)
        
        titleLabel = UILabel(frame: CGRectMake(110, 10, contentView.bounds.width - 120, 45))
//        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFontOfSize(13)
        //        titleLabel.backgroundColor = UIColor.greenColor()
        self.backView.addSubview(titleLabel)
        
        timeLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 65, 60, 60, 30))
        //        timeLabel.backgroundColor = UIColor.grayColor()
//        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.font = UIFont.systemFontOfSize(11)
        self.backView.addSubview(timeLabel)
    }
    
   
    
    // 给cell进行赋值
    func mainconfigureCellWitModel(model : MainModel){
        self.photoImage.sd_setImageWithURL(NSURL(string: model.photoImage)!)
        self.titleLabel.text = model.contentLabel
        self.timeLabel.text = model.timeLabel
        
        
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
