//
//  HeadLineViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
// 设置为全局变量
// 控制器
var FourNSArrayControllers : NSArray!
// 标题组
var FourNSArrayTitle : NSArray!

var HeaderScrollView : GKScrolSegmentView!
@objc(HeadLineViewController)
class HeadLineViewController: UIViewController {

    var pianyi : AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        FourNSArrayTitle = ["大势研判","今日头条","传闻揭秘", "主力动向"];
        FourNSArrayControllers = [MoneyTableViewController(),EveryDayViewController(),HearSayTableViewController(),MainTableViewController()];

        HeaderScrollView = GKScrolSegmentView(controllers: FourNSArrayControllers as! [UITableViewController] , titles: FourNSArrayTitle as! [String])
        
        self.view.addSubview(HeaderScrollView)
        
        
        HeaderScrollView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.pianyi != nil){
         
            let othernumber : Int = Int(TagTired! as NSNumber)
            
//            HeaderScrollView.jumpCoumMentVC6(othernumber)
//            HeaderScrollView.jumpCoumMentVCGK(othernumber)
        }
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
