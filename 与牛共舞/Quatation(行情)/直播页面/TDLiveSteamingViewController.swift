//
//  TDLiveSteamingViewController.swift
//  与牛共舞
//
//  Created by dm on 16/11/18.
//  Copyright © 2016年 Mac. All rights reserved.


import UIKit

class TDLiveSteamingViewController: UIViewController {

    var backView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.redColor()
        backView = UIView(frame: CGRectMake(0, 20, KScreenWidth, KScreenHeight - 20))
        backView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(backView)
        self.navigationController?.navigationBar
            .setBackgroundImage(UIImage(named: "100"), forBarMetrics: .Default)
        
        let Backbutton = UIButton(frame: CGRectMake(0, 25, 30, 30))
        Backbutton.backgroundColor = UIColor.redColor()
        Backbutton.adjustsImageWhenHighlighted = false
        Backbutton.setImage(UIImage(named: "返回.jpg"), forState: UIControlState.Normal)
        Backbutton.addTarget(self, action: #selector(TDLiveSteamingViewController.BackAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Backbutton)
        
    }
    
    func BackAction(){
       self.dismissViewControllerAnimated(true, completion: nil);
    }

    
    override func viewWillAppear(animated: Bool) {
//        self.navigationController?.hidesBottomBarWhenPushed = true
        
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
