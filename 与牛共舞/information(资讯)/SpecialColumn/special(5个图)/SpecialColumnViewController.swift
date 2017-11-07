//
//  SpecialColumnViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit


var MAINScrollView : TTScrolSegmentView!

@objc(SpecialColumnViewController)
class SpecialColumnViewController: UIViewController {

    var tiaoID:AnyObject?
   var pianyi : AnyObject?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        let titleArr : NSArray = ["牛股情报站","专题研究","五星擒牛","高手追踪","视频点金"];
        
        let contrllerArray : NSArray = [CowsWinnersTableViewController(), SpecialYJTableViewController(), FiveStareViewController(), CowsPeopleViewController(), ViedioTableView()]
        MAINScrollView = TTScrolSegmentView(controllers: contrllerArray as! [UITableViewController] , titles: titleArr as! [String])
        
        
        self.view.addSubview(MAINScrollView)
        
        MAINScrollView.show()
        
        
//        MAINScrollView = DMScrolSegmentView(controllers: contrllerArray as! [UITableViewController] , titles: titleArr as! [String])
        
    // 使用封装的SDK
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.tiaoID != nil) {
            
            let number : Int = Int(TagTired! as NSNumber)
            
            MAINScrollView.jumpCoumMentVC6(number)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
