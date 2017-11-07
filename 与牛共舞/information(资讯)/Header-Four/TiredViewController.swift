

//
//  TiredViewController.swift
//  与牛共舞
//
//  Created by dm on 16/10/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class TiredViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //选项除了文字还可以是图片
        let items=["选项一","选项二",UIImage(named: "22.jpg")!] as [AnyObject]
        let segmented = UISegmentedControl(items:items)
        self.navigationController?.navigationBarHidden = true
        self.navigationItem.titleView = segmented
        segmented.selectedSegmentIndex = 0 //默认选中第二项
        
        segmented.addTarget(self, action: #selector(TiredViewController.segmentDidchange(_:)),
                            forControlEvents: UIControlEvents.ValueChanged)  //添加值改变监听
        self.view.addSubview(segmented)
    }
    
    func segmentDidchange(segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
        print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
        
                print("sadsasdasdasdas")
                switch (segmented.selectedSegmentIndex) {
                case 0:
                    print("sssssss")
                    self.view.backgroundColor = UIColor.whiteColor()
//        //            let aray1 = [self.view.subviews] as NSArray
//        //            if ([aray1.count] == 2){
//        //                aray1.objectAtIndex(1).removeFromSuperview()
//        //            }
//                    let TiredFirstview = HeadLineViewController()
//                    TiredFirstview.viewDidLoad()
//        //            TiredFirstview.view.width(self.view.bounds.width())
//        
//                    self.view.addSubview(TiredFirstview.view)
                    break
                case 1:
                    print("222222222")
                    self.view.backgroundColor = UIColor.redColor()
//                    let aray1 = [self.view.subviews] as NSArray
//        //            if ([aray1.count] == 2){
//        //                aray1.objectAtIndex(1).removeFromSuperview()
//        //            }
//                    let TiredSecondview = NewsFlahViewController()
//                    TiredSecondview.viewDidLoad()
//                    //            TiredFirstview.view.width(self.view.bounds.width())
//        
//                    self.view.addSubview(TiredSecondview.view)
                    break
                case 2:
                    print("222222222")
                    self.view.backgroundColor = UIColor.cyanColor()
//                    let aray1 = [self.view.subviews] as NSArray
//                    if ([aray1.count] == 2){
//                        aray1.objectAtIndex(1).removeFromSuperview()
//                    }
//                    let TiredSecondview = NewsFlahViewController()
//                    TiredSecondview.viewDidLoad()
//                    //            TiredFirstview.view.width(self.view.bounds.width())
//                    
//                    self.view.addSubview(TiredSecondview.view)
                    break
                default:
                    break
                }

        
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
