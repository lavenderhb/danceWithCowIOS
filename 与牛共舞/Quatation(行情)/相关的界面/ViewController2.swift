//
//  ViewController.swift
//  two
//
//  Created by 雷伊潇 on 16/5/7.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit
import CoreData

class ViewController0: UIViewController {
    
    //override func viewDidLoad() {
    //   super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    //}
    @IBAction func search(sender: AnyObject) {
        let vc:UIViewController = searchViewController()
        self.presentViewController(vc, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var searchbtn: UIButton!
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            firstView.hidden = false
            secondView.hidden = true
        case 1:
            firstView.hidden = true
            secondView.hidden = false
        default:
            break;
        }
    }
    @IBOutlet weak var backimp: UIButton!
    
    @IBAction func backbtn(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion:nil)//关闭当前页面
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)//返回上一页面
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        segmentedControl.tintColor=UIColor.redColor()
        searchbtn.setBackgroundImage(UIImage(named: "22.jpg"), forState: UIControlState.Normal)
        backimp.setBackgroundImage(UIImage(named: "22.jpg"), forState: UIControlState.Normal)
        
        firstView.hidden = false
        secondView.hidden = true
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // override func didReceiveMemoryWarning() {
    //super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    //  }
    
    
}

