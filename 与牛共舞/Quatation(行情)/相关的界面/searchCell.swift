//
//  searchCell.swift
//  danceWithCowIOS
//
//  Created by 雷伊潇 on 16/5/11.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit


class searchCell: UITableViewCell {
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var jumpBtn: UIButton!
    
    @IBOutlet weak var code: UILabel!
    
    @IBAction func jumpToGPXQ(sender: AnyObject) {
        let addgp:GupiaoBean=GupiaoBean ()
        addgp.name = name.text
        addgp.symbol = symbol.text
        addgp.code = code.text
        if GloMethod.isAdd(code.text!) {
            
            GloMethod.deleteGupiaoBean(code.text!)
            jumpBtn.setBackgroundImage(UIImage(named: "newadd"), forState: UIControlState.Normal)
        }
        else {
            GloMethod.insertGupiaoBean(addgp)
            jumpBtn.setBackgroundImage(UIImage(named: "newsub"), forState: UIControlState.Normal)
        }
        
        
        
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
