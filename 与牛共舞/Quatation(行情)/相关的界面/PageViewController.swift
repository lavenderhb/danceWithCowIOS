//
//  pageview.swift
//  hqnew
//
//  Created by 雷伊潇 on 16/8/31.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var g11:g1?
    var g22:g2?
    
    
    
    private(set) lazy var allViewControllers: [UIViewController] = {
        
        return [self.getViewController("firstVC"),
                self.getViewController("secondVC")]
    }()
    
    
    var timer:NSTimer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        g11=allViewControllers.first as? g1
        g22=allViewControllers.last as? g2
        
        dataSource = self
        
        if let firstViewController = g11 {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: false,
                               completion: nil)
        }
        
        //        timer = NSTimer.scheduledTimerWithTimeInterval(3,target:self,selector:#selector(aaa),userInfo:nil,repeats:true)
        
    }
    
    func aaa(){
        g11?.price.text="aaaaaaaaaa"
        g22?.price.text="bbbbbbbbbb"
    }
    
    
    
    
    
    
    private func getViewController(indentifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier("\(indentifier)")
    }
    
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController
        viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        
        guard previousIndex >= 0 else {
            return g22
        }
        
        guard allViewControllers.count > previousIndex else {
            return nil
        }
        
        return allViewControllers[previousIndex]
    }
    
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController
        viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = allViewControllers.count
        
        
        guard orderedViewControllersCount != nextIndex else {
            return g11
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return allViewControllers[nextIndex]
    }
}
