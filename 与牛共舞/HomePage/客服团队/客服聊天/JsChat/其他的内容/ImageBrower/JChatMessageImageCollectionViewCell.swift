//
//  JChatMessageImageCollectionViewCell.swift
//  JChatSwift
//
//  Created by oshumini on 16/6/7.
//  Copyright © 2016年 HXHG. All rights reserved.
//

import UIKit

@objc(JChatMessageImageCollectionViewCell)
class JChatMessageImageCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var messageImageContent: UIScrollView!
  var messageImage:UIImageView!
  weak var messageModel:JChatMessageModel?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    messageImage = UIImageView()
    messageImage.contentMode = .ScaleAspectFit
    messageImage.backgroundColor = UIColor.blackColor()
    messageImage.frame = UIScreen.mainScreen().bounds
    
    messageImageContent.addSubview(messageImage)
    messageImageContent.delegate = self
    messageImageContent.maximumZoomScale = 100
    messageImageContent.minimumZoomScale = 50
    messageImageContent.contentSize = messageImageContent.frame.size
  }
  
  func adjustImageScale() {
    if messageImageContent.zoomScale > 20 {
      messageImageContent.setZoomScale(50, animated: true)
    } else {
      messageImageContent.setZoomScale(30, animated: true)
    }
  }
  
  internal func setImage(model:JChatMessageModel) {
    messageModel = model
    (model.message.content as? JMSGImageContent)?.thumbImageData { (data, msgId, error) in
      if msgId == self.messageModel?.message.msgId {
        self.messageImage.image = UIImage(data: data)!
      }
      
      (model.message.content as! JMSGImageContent).largeImageDataWithProgress({ (percent, msgId) in

        }, completionHandler: { (data, msgId, error) in
          if error == nil {
            
            if msgId != self.messageModel?.message.msgId {
              return
            }
            
            self.messageImage.image = UIImage(data: data)
          } else {
            print("get larget image fail \(NSString.errorAlert(error))")
          }
      })

      if error != nil {
        print("get thumb image fail")
      }
    }
  }
}

extension JChatMessageImageCollectionViewCell:UIScrollViewDelegate {
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return messageImage
  }
  
//  func
}
