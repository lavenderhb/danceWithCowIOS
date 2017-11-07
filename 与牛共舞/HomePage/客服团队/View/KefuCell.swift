//
//  KefuCell.swift
//  与牛共舞
//
//  Created by yansy on 2017/10/25.
//  Copyright © 2017年 Mac. All rights reserved.
//

import Foundation


class KefuCell:UITableViewCell{
    
    
    var TitleString:String?
    var iconImageName:String?
    
    var TitleLabel:UILabel?
    var iconImageView:UIImageView?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.iconImageView=UIImageView()
        
        self.contentView.addSubview(self.iconImageView!)
        
        self.TitleLabel=UILabel()
        
        self.contentView.addSubview(self.TitleLabel!)
        
        setUpviews()
    }
    
    func setUpviews() {
        if self.iconImageName != nil {
            self.iconImageView?.image=UIImage(named: iconImageName!)
            self.TitleLabel?.text=self.TitleString
            
        }
        
        self.iconImageView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(5)
            make.width.equalTo(self.iconImageView!.snp_height)
            
        })
        
        
        self.TitleLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(self.iconImageView!.snp_right).offset(10)
            make.centerY.equalTo(self.iconImageView!.snp_centerY)
            
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpviews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
