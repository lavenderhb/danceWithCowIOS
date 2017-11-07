	//
//  NewsFlashTableViewCell.swift
//  与牛共舞
//
//  Created by dm on 16/9/27.
//  Copyright © 2016年 Mac. All rights reserved.

    
//UILabel拥有点击事件
//var label3:UILabel = UILabel(frame: CGRect(x: 50, y: 130, width: 100, height: 35))
//label3.text = "我有点击事件"
//label3.adjustsFontSizeToFitWidth = true //根据label的宽度,改变字体的大小
//
//var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "click:")
//label3.userInteractionEnabled = true
//label3.addGestureRecognizer(tap)
//
//label3.shadowColor = UIColor.purpleColor() //设置shadow
//label3.shadowOffset = CGSize(width: 2, height: 2)

import UIKit

class NewsFlashTableViewCell: UITableViewCell {
    // 时间
    var timeLabel :
    UILabel!
    // 小红点
    var corHeaderImage : UIImageView!
    // 小红条
    var lastLabel : UILabel!
    // 内容
    var content11Label : UILabel!
    
    var str_ss : String!
    var colorArr = [UIColor.redColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.blueColor(), UIColor.orangeColor()];

    //重写cell init方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       setCONtentViewQQ()
    }
    
    func setCONtentViewQQ(){
         timeLabel = UILabel(frame: CGRectMake(7, 2, 35, 25))
        timeLabel.layer.borderColor = UIColor.clearColor().CGColor
//        timeLabel.layer.borderWidth = 0
//        timeLabel.backgroundColor = UIColor.cyanColor()
        timeLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(timeLabel)
        
        corHeaderImage = UIImageView(frame:CGRectMake(15, 23, 15, 15))
        corHeaderImage.image = UIImage(named: "timeline2.png")
        self.contentView.addSubview(corHeaderImage)
        
        
        content11Label = UILabel(frame: CGRectMake(55, 10, UIScreen.mainScreen().bounds.size.width - 60, 75))
//        content11Label = UILabel(frame: CGRectMake(60, 5, UIScreen.mainScreen().bounds.size.width - 20, 40))
//        content11Label.backgroundColor = UIColor.redColor()
        content11Label.font = UIFont(name: "HelveticaNeue", size: 15)
        content11Label.numberOfLines = 0
        // 重要的
        content11Label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        str_ss = content11Label.text
        
//        if (str_ss == nil) {
//            print("快讯没有数据")
//        }else{
        
//            print("dsadssadddddddddddddddddddddddddddddddddddddd")
//            let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: str_ss)
//            
//            let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
//            
//            paragraphStyle.lineSpacing = 100 //大小调整
//            
//            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str_ss.characters.count))
            
            
            
//            content11Label.attributedText = attributedString
            
//            content11Label.sizeToFit()
//        }
//        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: str_ss)
//        
//        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
//        
//        paragraphStyle.lineSpacing = 10 //大小调整
//        
//        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str_ss.characters.count))
//        
//        
//        
//        content11Label.attributedText = attributedString
//        
//        content11Label.sizeToFit()
        /*
         
         label.lineBreakMode = NSLineBreakByCharWrapping;以字符为显示单位显示，后面部分省略不显示。
         label.lineBreakMode = NSLineBreakByClipping;剪切与文本宽度相同的内容长度，后半部分被删除。
         label.lineBreakMode = NSLineBreakByTruncatingHead;前面部分文字以……方式省略，显示尾部文字内容。
         label.lineBreakMode = NSLineBreakByTruncatingMiddle;中间的内容以……方式省略，显示头尾的文字内容。
         label.lineBreakMode = NSLineBreakByTruncatingTail;结尾部分的内容以……方式省略，显示头的文字内容。
         label.lineBreakMode = NSLineBreakByWordWrapping;以单词为显示单位显示，后面部分省略不显示。

         */
        
        
        self.contentView.addSubview(self.content11Label)
     
    }
    
    // 给cell赋值
    func contentfigureWithModel(model : NewsFlashModel){
        
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: model.contentlaBelUrl)
        
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 5 //大小调整
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, model.contentlaBelUrl.characters.count))
        
        
        content11Label.attributedText = attributedString
        
        content11Label.sizeToFit()
        self.timeLabel.text = model.timeLabelUrl
        
        self.content11Label.attributedText = attributedString
    }
    
    // 根据label的内容重新布局
    func adjustCellWithModel(model: NewsFlashModel) {
        
        // 改变contentLabel的frame
        var frame = content11Label.frame
        frame.size.height = NewsFlashTableViewCell.calculateLabelHeightWithModel(model) + 50
        content11Label.frame = frame
        
    }
    
    // 计算label高度
    class func calculateLabelHeightWithModel(model: NewsFlashModel) -> CGFloat {
        
        let str = model.contentlaBelUrl as NSString
        let rect = str.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 10, CGFloat.max), options:[NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15)], context: nil)
        
        return rect.size.height
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
