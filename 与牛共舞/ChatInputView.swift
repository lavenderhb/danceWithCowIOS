//
//  JChatInputView.swift
//  JChatSwift
//
//  Created by oshumini on 16/2/17.
//  Copyright © 2016年 HXHG. All rights reserved.
//

import UIKit
import SnapKit


protocol ChatInputViewDelegate:NSObjectProtocol {
    // sendText
    func sendTextMessage(messageText:String)
    
}

class ChatInputView: UIView {
    var inputWrapView:UIView!
    var inputTextView:ChatMessageInputView!
    var showMoreBtn:UIButton!

    weak var inputDelegate:ChatInputViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupAllViews()
        
    }
    
    func setupAllViews() {
        
        
        // 这个界面是下面有语音的一种条
        self.inputWrapView = UIView()
        self.inputWrapView.backgroundColor = UIColor(netHex: 0xdfdfdf)
        //        self.inputWrapView.backgroundColor = UIColor.redColor()
        self.addSubview(inputWrapView)
        
        
        // 输入框的view
        self.inputWrapView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            //            make.top.equalTo(self)
            //            make.edges.equalTo(self).inset(UIEdgeInsets(top: 1, left: 40 , bottom: 2, right: 40))
            make.bottom.equalTo(inputWrapView.snp_top)
            make.height.equalTo(35)
        }
        self.updateInputTextViewHeight(self.inputTextView)

        
        // 输入宽的大小
        self.inputTextView = ChatMessageInputView()
        self.inputTextView.layer.borderWidth = 0.5
        self.inputTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.inputTextView.layer.cornerRadius = 2
        self.inputTextView.returnKeyType = .Send
        self.inputTextView.delegate = self
        self.inputTextView.enablesReturnKeyAutomatically = true
        self.addSubview(self.inputTextView!)
        inputTextView?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(self.showMoreBtn.snp_left).offset(-5)
            make.left.equalTo(inputWrapView).offset(3)
            make.right.equalTo(inputWrapView).offset(-3)
            make.top.equalTo(inputWrapView).offset(5)
            make.bottom.equalTo(inputWrapView).offset(-5)
            make.height.greaterThanOrEqualTo(30)
            make.height.lessThanOrEqualTo(100)
        })
        
    }
    
    
    func changeMoreViewStatus() {
        CATransaction.begin()
        hideKeyBoardAnimation()
        self.superview!.layoutIfNeeded()
        UIView.animateWithDuration(keyboardAnimationDuration) { () -> Void in
            self.superview!.layoutIfNeeded()
        }
        CATransaction.commit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getRecorderPath() -> String {
        var recorderPath:String? = nil
        let now:NSDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yy-MMMM-dd"
        recorderPath = "\(NSHomeDirectory())/Documents/"
        
        dateFormatter.dateFormat = "yyyy-MM-dd-hh-mm-ss"
        recorderPath?.appendContentsOf("\(dateFormatter.stringFromDate(now))-MySound.ilbc")
        return recorderPath!
    }
}


extension ChatInputView:UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        self.updateInputTextViewHeight(textView)
    }
    
    func updateInputTextViewHeight(textView: UITextView) {
        let textContentH = textView.contentSize.height
        print("output：\(textContentH)")
        let textHeight = textContentH > 35 ? (textContentH<100 ? textContentH:100):30
        UIView.animateWithDuration(0.2) { () -> Void in
            self.inputTextView.snp_updateConstraints(closure: { (make) -> Void in
                make.height.equalTo(textHeight)
            })
        }
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.inputDelegate.sendTextMessage(self.inputTextView.text)
            self.inputTextView.text = ""
            return false
        }
        return true
    }
}
