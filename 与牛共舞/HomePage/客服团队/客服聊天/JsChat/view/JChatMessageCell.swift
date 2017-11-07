//
//  JChatMessageCell.swift
//  JChatSwift
//
//  Created by oshumini on 16/2/17.
//  Copyright © 2016年 HXHG. All rights reserved.
//

import UIKit
import AVFoundation

protocol JChatMessageCellDelegate:NSObjectProtocol {
  func selectHeadView(model:JChatMessageModel)
  
  //  picture
  func tapPicture(messageModel:JChatMessageModel, tableViewCell:UITableViewCell)

  //  voice
  func getContinuePlay(cell:UITableViewCell)

  func successionalPlayVoice(cell:UITableViewCell)
}

@objc(JChatMessageCell)
class JChatMessageCell: UITableViewCell {
  internal var headImageView:UIImageView!
  internal var messageBubble:JChatMessageBubble?
  internal var circleView:UIActivityIndicatorView!
  internal var percentLable:UILabel!
  internal var sendfailImg:UIImageView!

//  text
  internal var textMessageContent:UILabel!
  
//  voice
  internal var isPlaying:Bool!
  internal var voiceImgIndex:Int!  // 语言按钮图片的当前标识
  internal var voiceBtn:UIImageView!
  internal var unreadStatusView:UIView!
  internal var voiceTimeLable:UILabel!
  internal var continuePlayer:Bool!
  
  weak var delegate:JChatMessageCellDelegate!
  var messageModel:JChatMessageModel!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = UITableViewCellSelectionStyle.None
    self.backgroundColor = UIColor.clearColor()
    
    self.continuePlayer = false
    self.voiceImgIndex = 0
    self.isPlaying = false
    
    self.headImageView = UIImageView()
    self.headImageView.layer.cornerRadius = 22.5
    self.headImageView.layer.masksToBounds = true
    self.contentView.addSubview(self.headImageView)
    
    self.textMessageContent = UILabel()
    self.textMessageContent.numberOfLines = 0
    self.textMessageContent.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    self.contentView.addSubview(textMessageContent)
    
    self.voiceBtn = UIImageView()
    self.contentView.addSubview(self.voiceBtn)
    
    self.unreadStatusView = UIView()
    self.unreadStatusView.layer.cornerRadius = 4
    self.unreadStatusView.layer.masksToBounds = true
    self.unreadStatusView.backgroundColor = UIColor.redColor()
    self.contentView.addSubview(self.unreadStatusView)
    
    self.circleView = UIActivityIndicatorView()
    self.circleView.backgroundColor = UIColor.clearColor()
    self.circleView.hidden = true
    self.circleView.hidesWhenStopped = true
    self.contentView.addSubview(self.circleView)

    self.sendfailImg = UIImageView()
    self.sendfailImg.image = UIImage(named: "22.jpg")
    self.contentView.addSubview(self.sendfailImg)
    
    self.voiceTimeLable = UILabel()
    self.voiceTimeLable.backgroundColor = UIColor.clearColor()
    self.voiceTimeLable.font = UIFont.systemFontOfSize(18)
    self.contentView.addSubview(self.voiceTimeLable)
    
    self.textMessageContent.backgroundColor = UIColor.clearColor()
    
    self.messageBubble = JChatMessageBubble(frame: CGRectZero)
    self.contentView.insertSubview(self.messageBubble!, belowSubview: self.textMessageContent)
    
    self.percentLable = UILabel()
    self.percentLable.font = UIFont.systemFontOfSize(18)
    self.percentLable.textAlignment = .Center
    self.percentLable.textColor = UIColor.whiteColor()
    self.messageBubble?.addSubview(percentLable)
//    self.percentLable.snp_makeConstraints { (make) in
//      make.size.equalTo(CGSizeMake(60, 40))
//      make.center.equalTo(self.messageBubble!)
//    }
    
//    self.addGestureForAllViews()
  }
  
  func addGestureForAllViews() {
    let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapContent))
    self.messageBubble?.addGestureRecognizer(gesture)
    self.messageBubble?.userInteractionEnabled = true

    let tapHeadGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapHeadView))
    self.headImageView.addGestureRecognizer(tapHeadGesture)
    self.headImageView.userInteractionEnabled = true
    
  }
  
  func tapContent() {
    print("tap message")
    switch messageModel.message.contentType {
    case .Voice:
      self.playVoice()
      break
    case .Image:
      if messageModel.message.status == .ReceiveDownloadFailed {
        print("正在下载缩略图")
        self.circleView.startAnimating()
      } else {
        self.delegate.tapPicture(self.messageModel, tableViewCell: self)
      }
      break
    default:
      break
    }
  }
  
  func tapHeadView() {
    self.delegate.selectHeadView(self.messageModel)
  }
  
  func setCellData(model:JChatMessageModel) {
    self.messageModel = model
    self.messageBubble?.message = model.message
    
    model.message.fromUser.thumbAvatarData { (data, ObjectId, error) -> Void in
      if error == nil {
        let user:JMSGUser = self.messageModel.message.fromUser
        if ObjectId == user.username {
          
          if data != nil {
            self.headImageView.image = UIImage(data: data)
          } else {
            self.headImageView.image = UIImage(named: "headDefalt")
          }
          
        } else {
          print("该头像是乱序的头像")
        }
        
      } else {
        print("get thumbAvatar fail")
        self.headImageView.image = UIImage(named: "headDefalt")
      }
      
    }
    
    self.messageBubble?.image = self.messageBubble?.maskBackgroupImage
    
    switch model.message.contentType {
    case .Text:
      let textContent = model.message.content as! JMSGTextContent
      self.textMessageContent.text = textContent.text
      break
    case .Voice:
      self.setVoiceBtmImage()
      break
    case .Image:
      let imageContent = self.messageModel.message.content as! JMSGImageContent
      
      imageContent.thumbImageData({[weak weakSelf = self] (data, objectId, error) -> Void in
        if error == nil {
          if data != nil {
            weakSelf?.messageBubble?.image = UIImage(data: data)
            return
          }
        }
        weakSelf?.messageBubble?.image = UIImage(named: "22.jpg")
        })
      break
    default:
      break
    }
    
    if self.messageModel.message.flag == 1 || !self.messageModel.message.isReceived {
      self.unreadStatusView.hidden = true
    } else {
      self.unreadStatusView.hidden = false
    }
    
    self.layoutAllViews()

  }
  
  func setCellData(model:JChatMessageModel, delegate:JChatMessageCellDelegate) {
    self.delegate = delegate
    self.setCellData(model)
  }
  
  func layoutAllViews() {
    let tmpMessage = self.messageModel.message
    switch tmpMessage.status {
    case .Sending:
      fallthrough
    case .SendDraft:
      self.circleView.startAnimating()
      self.sendfailImg.hidden = true
      self.percentLable.hidden = false
      
      if tmpMessage.contentType == .Image {
        self.messageBubble?.alpha = 0.5
        self.addUpLoadHandler()
      } else {
        self.messageBubble?.alpha = 1
      }

      break
      
    case .SendFailed:
      fallthrough
    case .SendUploadFailed:
      fallthrough
    case .ReceiveDownloadFailed:
      self.circleView.stopAnimating()
      if tmpMessage.isReceived {
        self.sendfailImg.hidden = false
      } else {
        self.percentLable.hidden = true
      }
      self.messageBubble?.alpha = 1
      break
    default:
      self.messageBubble?.alpha = 1
      self.circleView.stopAnimating()
      self.sendfailImg.hidden = true
      self.percentLable.hidden = true
      break
    }
    
    if tmpMessage.contentType != .Voice {
      self.unreadStatusView.hidden = true
    }
    
    switch tmpMessage.contentType {
    case .Unknown:
      
      break
    case .Text:
      self.textMessageContent.hidden = false
      self.percentLable.hidden = true
      self.unreadStatusView.hidden = true
      self.voiceTimeLable.hidden = true
      self.voiceBtn.hidden = true
      break
    case .Image:
      self.textMessageContent.hidden = true
      self.unreadStatusView.hidden = true
      self.voiceTimeLable.hidden = true
      self.voiceBtn.hidden = true
      break
    case .Voice:
      self.textMessageContent.hidden = true
      self.textLabel?.hidden = true
      self.percentLable.hidden = true
      self.voiceTimeLable.hidden = false
      self.voiceBtn.hidden = false
      self.voiceTimeLable.text = "\((tmpMessage.content as! JMSGVoiceContent).duration)"
      break
    case .Custom:
      break
    case .EventNotification:
      break
    }
  }

  func addUpLoadHandler() {
    (self.messageModel.message.content as! JMSGImageContent).uploadHandler = {[weak weakSelf = self] (percent:Float, msgId:(String!)) in
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        if weakSelf?.messageModel.message.msgId == msgId! {
          let percent = "\(Int(percent*100))％"
          weakSelf?.percentLable.text = percent
          print("upload percent is \(percent)")
        }
      })
    } as JMSGMediaProgressHandler
    
  }
  
  //#pragma mark --连续播放语音
  //- (void)playVoice {
  //}
  
  func playVoice() {
    print("Action - playVoice")

    self.continuePlayer = false
    self.unreadStatusView.hidden = true
    self.messageModel.message.updateFlag(1)

    (self.messageModel.message.content as! JMSGVoiceContent).voiceData {[weak weakSelf = self] (data, objectId, error) -> Void in
      var alertString = ""
      if error == nil {
        if data != nil {
          alertString = "下载语言成功"
          weakSelf!.voiceImgIndex = 0
        }
// TODO:
        self.isPlaying = true
        JChatAudioPlayerHelper.sharedInstance.delegate = self
        JChatAudioPlayerHelper.sharedInstance.managerAudioWithData(data, toplay: true)
      }
    }
    
  }
  
  func changeVoiceBtmImage() {
    if self.isPlaying == false {
      return
    }
    self.setVoiceBtmImage()
    if self.isPlaying == true{
      self.voiceImgIndex?++
      self.performSelector(#selector(self.changeVoiceBtmImage), withObject: nil, afterDelay: 0.25)
    }
  }
  
  func setVoiceBtmImage() {
    var voiceImagePreStr:NSString = ""
    if self.messageModel.message.isReceived {
      voiceImagePreStr = "ReceiverVoiceNodePlaying00"
    } else {
      voiceImagePreStr = "SenderVoiceNodePlaying00"
    }
    // voiceImagePreStr.stringByAppendingString("\(self.voiceImgIndex % 4)")
    self.voiceBtn.image = UIImage(named:"22.jpg")

  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}

// TODO:

extension JChatMessageCell:JChatAudioPlayerHelperDelegate {
  func didAudioPlayerBeginPlay(AudioPlayer:AVAudioPlayer) {
  
  }

  func didAudioPlayerStopPlay(AudioPlayer:AVAudioPlayer) {
    JChatAudioPlayerHelper.sharedInstance.delegate = nil
    self.isPlaying = false
    self.voiceImgIndex = 0
    self.setVoiceBtmImage()
    
    if self.continuePlayer == true {
      self.continuePlayer = false
      self.performSelector(#selector(JChatMessageCell.prepareToPlayVoice), withObject: nil, afterDelay: 0.5)
    }
  }
  
  func prepareToPlayVoice() {
    self.delegate?.successionalPlayVoice(self)
  }
  
  func didAudioPlayerPausePlay(AudioPlayer:AVAudioPlayer) {
  
  }
}


