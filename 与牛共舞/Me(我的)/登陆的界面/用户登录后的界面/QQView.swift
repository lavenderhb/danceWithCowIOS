
//
//  QQView.swift
//  与牛共舞
//
//  Created by dm on 16/11/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class QQView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 233 / 256.0, green: 235 / 256.0, blue: 239 / 256.0, alpha: 1.0)
        
        
        self.navigationItem.title = "修改qq号"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let rightBB = UIButton(frame: CGRectMake(0, 0, 40, 20))
        rightBB.setTitle("保存", forState: UIControlState.Normal)
        rightBB.backgroundColor = UIColor.whiteColor()
        rightBB.layer.cornerRadius = 5
        rightBB.titleLabel?.font = UIFont.systemFontOfSize(12)
        rightBB.addTarget(self, action: #selector(NameView.RightAA), forControlEvents: UIControlEvents.TouchUpInside)
        rightBB.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        let rightBTN = UIBarButtonItem(customView:rightBB)
        
        self.navigationItem.rightBarButtonItem = rightBTN
        
        
        let backbb  = UIButton(frame: CGRectMake(0, 0, 30, 30))
        //        backbb.backgroundColor = UIColor.blackColor()
        backbb.setImage(UIImage(named: "back00"), forState: UIControlState.Normal)
        backbb.backgroundColor = UIColor.clearColor()
        backbb.adjustsImageWhenHighlighted = false
        backbb.addTarget(self, action: #selector(SearchViewController.backToPrevious), forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftBarBtn = UIBarButtonItem(customView: backbb)
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10;
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
        
        
        let textFul = UITextField(frame: CGRectMake(10, 74, KScreenWidth - 20, 40))
        textFul.layer.cornerRadius = 5
        textFul.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(textFul)
        
        let realNmae = UILabel(frame: CGRectMake(10, 115, 100, 28))
        realNmae.adjustsFontSizeToFitWidth = true
        realNmae.backgroundColor = UIColor.clearColor()
        realNmae.text = "请填写qq号"
        realNmae.font = UIFont.systemFontOfSize(13)
        realNmae.alpha = 0.3
        self.view.addSubview(realNmae)
        
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func RightAA(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
