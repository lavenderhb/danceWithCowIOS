//
//  JChatMessageInputView.swift
//  JChatSwift
//
//  Created by oshumini on 16/6/12.
//  Copyright © 2016年 HXHG. All rights reserved.
//

import UIKit

class ChatMessageInputView: UITextView {
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        super.canPerformAction(action, withSender: sender)
        return  (action == #selector(self.paste(_:))) || (action == #selector(self.resignFirstResponder))
    }
    
    override func canResignFirstResponder() -> Bool {
        return true
    }
    
    override func paste(sender: AnyObject?) {
        let pasteboard = UIPasteboard.generalPasteboard()
        let textAttachment = NSTextAttachment()
        if pasteboard.string != nil {
            super.paste(sender)
            return
        }
        
        if pasteboard.image != nil {
            textAttachment.image = pasteboard.image
        }
    }
}
