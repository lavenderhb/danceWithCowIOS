//
//  XZAlertView.swift
//  alert
//
//  Created by JGCM on 16/9/21.
//  Copyright © 2016年 JGCM. All rights reserved.
//

import UIKit

private var promptText: UILabel!;
private var timer: NSTimer?

class XZAlertView {
    
    class func addXZAlertView(view: UIView, title: String) {
        
        var height:CGFloat = 30
        
        if title.characters.count>9 {
            height = 60
        }
        
        promptText = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width , height: height));
        promptText.center = CGPoint(x: UIScreen.mainScreen().bounds.width / 2, y: UIScreen.mainScreen().bounds.height / 2 - 50)
        promptText.text = title;
        promptText.backgroundColor = UIColor(white: 0.0, alpha: 0.7);
        promptText.textColor = UIColor.whiteColor()
        promptText.textAlignment = NSTextAlignment.Center
        promptText.layer.cornerRadius = 7
        promptText.clipsToBounds = true
        view.addSubview(promptText)
        
        
        func shakeToUpShow(aView: UIView) {
            let animation = CAKeyframeAnimation(keyPath: "transform")
            animation.duration = 0.5
            let values = NSMutableArray()
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0)))
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)))
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)))
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
            animation.values = values as [AnyObject];
            aView.layer.addAnimation(animation, forKey: nil)
        }
        
        func runTime() {
            timer = NSTimer(timeInterval: 0.15, target: self, selector: #selector(XZAlertView.methodTime), userInfo: nil, repeats: true)
            if timer != nil {
//                NSRunLoop.currentMode.add(timer!, forMode: RunLoopMode.defaultRunLoopMode);
            NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
            }
        }
        
        shakeToUpShow(promptText);
        runTime();
    }
    
    @objc private class func methodTime() {
        
        if (timer != nil) {
            timer!.invalidate();
            timer = nil
        }
        UIView.beginAnimations(nil, context: nil);
//        UIView.setAnimationCurve(UIViewAnimationCurve.easeIn);
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseIn)
        UIView.setAnimationDuration(0.7);
        UIView.setAnimationDelegate(self);
        promptText.alpha = 0.0;
        UIView.commitAnimations();
        
    }
}
