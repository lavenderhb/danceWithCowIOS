//
//  WebTestViewController.swift
//  与牛共舞
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class WebTestViewController: UIViewController {

    @IBOutlet weak var TestWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.magentaColor()
        let url = NSURL(string: "http://baike.baidu.com/link?url=vNMn6yQVdn9eGcOp71CJr07w9L8zFEoNE1RQSwy16Q5pqDFRAQG1F_uh2LRAMkXyfhS1qzy2W6abHHK6Ub31ma")
        let request = NSURLRequest(URL: url!)
        
        TestWebView.loadRequest(request)
        
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
