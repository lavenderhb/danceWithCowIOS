//
//  tab2.swift
//  two
//
//  Created by 雷伊潇 on 16/5/11.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit

class tab2: UIViewController {
    var tableview:TreeTableView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //获取资源
        let plistpath = NSBundle.mainBundle().pathForResource("DataInof", ofType: "plist")!
        let data = NSMutableArray(contentsOfFile: plistpath)
        
        // 初始化TreeNode数组
        var nodes = TreeNodeHelper.sharedInstance.getSortedNodes(data!, defaultExpandLevel: 0)
        
        // 初始化自定义的tableView
         tableview = TreeTableView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20), withData: nodes)
        self.view.addSubview(tableview!)
        
        
        nodes.removeAll()
        tableview?.reloadData()
        
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
