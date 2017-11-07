//
//  NewsHeaderTableViewCell.swift
//  与牛共舞
//
//  Created by lanouhn on 16/11/12.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class NewsHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var monthlabel: UILabel!
    
    @IBOutlet weak var RedRouidLabel: UIImageView!
    
    @IBOutlet weak var headerLLabel : UILabel!
    
    var content11Label : UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var littleLabel : UILabel!
    
    var contentLabel: UILabel!
    var str_ss : String!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCONtentViewQQ()

     
    }
    
    
    func setCONtentViewQQ(){
        
 
        headerLLabel.layer.borderColor = UIColor.orangeColor().CGColor
        headerLLabel.layer.borderWidth = 2
        headerLLabel.backgroundColor = UIColor.init(red: 254 / 255.0, green: 243 / 255.0, blue: 237 / 255.0, alpha: 1.0)
//        label2.font = UIFont.boldSystemFontOfSize(20)//调整文字为加粗类型
        
        dayLabel.font = UIFont.boldSystemFontOfSize(17)
        
        timeLabel.layer.borderColor = UIColor.clearColor().CGColor
        //        timeLabel.layer.borderWidth = 0
        //        timeLabel.backgroundColor = UIColor.cyanColor()
        timeLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(timeLabel)
        
        
        contentLabel = UILabel(frame: CGRectMake(55, 5, UIScreen.mainScreen().bounds.size.width - 70, 90))
        //        content11Label = UILabel(frame: CGRectMake(60, 5, UIScreen.mainScreen().bounds.size.width - 20, 40))
        //        content11Label.backgroundColor = UIColor.redColor()
        contentLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        contentLabel.numberOfLines = 0
        // 重要的
        contentLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        str_ss = contentLabel.text
        
            /*
         label.lineBreakMode = NSLineBreakByCharWrapping;以字符为显示单位显示，后面部分省略不显示。
         label.lineBreakMode = NSLineBreakByClipping;剪切与文本宽度相同的内容长度，后半部分被删除。
         label.lineBreakMode = NSLineBreakByTruncatingHead;前面部分文字以……方式省略，显示尾部文字内容。
         label.lineBreakMode = NSLineBreakByTruncatingMiddle;中间的内容以……方式省略，显示头尾的文字内容。
         label.lineBreakMode = NSLineBreakByTruncatingTail;结尾部分的内容以……方式省略，显示头的文字内容。
         label.lineBreakMode = NSLineBreakByWordWrapping;以单词为显示单位显示，后面部分省略不显示。
         
         */
        
        
        self.contentView.addSubview(self.contentLabel)
        
        
    }
    
    // 给cell赋值
    func contentfigureWithModel(model : NewsFlashModel){
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: model.contentlaBelUrl)
//          contentLabel.sizeToFit()
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5 //大小调整
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, model.contentlaBelUrl.characters.count))
        
        contentLabel.attributedText = attributedString
        
        contentLabel.sizeToFit()
        
        self.timeLabel.text = model.timeLabelUrl
        
    }
    
    // 根据label的内容重新布局
    func adjustCellWithModel(model: NewsFlashModel) {
        // 改变contentLabel的frame
        var frame = contentLabel.frame
        frame.size.height = NewsFlashTableViewCell.calculateLabelHeightWithModel(model) + 50
        contentLabel.frame = frame
    }
    
    // 计算label高度
    class func calculateLabelHeightWithModel(model: NewsFlashModel) -> CGFloat {
        
        let str = model.contentlaBelUrl as NSString
        let rect = str.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 10, CGFloat.max), options:[NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15)], context: nil)

        return rect.size.height
    }
    



    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
