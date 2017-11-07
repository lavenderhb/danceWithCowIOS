//
//  ViewController.swift
//  hqnew
//
//  Created by 雷伊潇 on 16/8/11.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet  weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    //let button:UIButton = UIButton(type:.ContactAdd)
    let button1 = UIButton()
    
    var red1=UIColor(red: 190/255, green: 0/255, blue: 3/255, alpha: 1)
    var black1=UIColor(red: 11/255, green: 9/255, blue: 20/255, alpha: 1)
    var greed1=UIColor(red: 30/255, green: 260/255, blue: 15/255, alpha: 1)
    
    var page1 = UIView()
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            
            firstView.hidden = false
            c1.isDo=true
            c2.isDo=false
            secondView.hidden = true
        case 1:
            firstView.hidden = true
            c1.isDo=false
            c2.isDo=true
            secondView.hidden = false
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        // Do any additional setup after loading the view, typically from a nib.
        
        firstView.hidden = false
        secondView.hidden = true
        c1.isDo=true
        
        
        page1.backgroundColor = red1
        page1.frame = CGRectMake(0,0, UIScreen.mainScreen().bounds.width , 70)
        self.view.addSubview(page1)
        self.view.sendSubviewToBack(page1)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



