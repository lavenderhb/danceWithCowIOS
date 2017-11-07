//
//  JChatRecordingView.swift
//  JChatSwift
//
//  Created by oshumini on 16/2/19.
//  Copyright © 2016年 HXHG. All rights reserved.
//   ALAssetsLibrary

import UIKit
import SnapKit

internal let voiceRecordResaueString = "松开手指，取消发送"
internal let voiceRecordPauseString = "手指上滑，取消发送"

class JChatRecordingView: UIView {

  var remiadeLable:UILabel!
  var microPhoneImageView:UIImageView!
  var cancelRecordImageView:UIImageView!
  var recordingHUDImageView:UIImageView!
  var peakPower:Float!
  
  func dismissCompled(completed: (finish:Bool) -> Void) {
  
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {

    self.backgroundColor = UIColor(netHex: 0x3f80dd)
    self.layer.masksToBounds = true
    self.layer.cornerRadius = 10
    if self.remiadeLable == nil {
      self.remiadeLable = UILabel(frame: CGRectZero)
      self.remiadeLable.textColor = UIColor.whiteColor()
      self.remiadeLable.font = UIFont.systemFontOfSize(13)
      self.remiadeLable.layer.masksToBounds = true
      self.remiadeLable.layer.cornerRadius = 4
      self.remiadeLable.autoresizingMask = [.FlexibleRightMargin, .FlexibleBottomMargin]
      self.remiadeLable.backgroundColor = UIColor.clearColor()
      self.remiadeLable.text = voiceRecordPauseString
      self.remiadeLable.textAlignment = .Center
      self.addSubview(self.remiadeLable!)
//      self.remiadeLable.snp_makeConstraints(closure: { (make) -> Void in
//        make.left.equalTo(self).offset(9.0)
//        make.top.equalTo(self).offset(114)
//        make.size.equalTo(CGSize(width: 120.0, height: 21.0))
//      })
    }

    if self.microPhoneImageView == nil {
      self.microPhoneImageView = UIImageView()
      self.microPhoneImageView.image = UIImage(named: "RecordingBkg")
      self.microPhoneImageView.autoresizingMask = [.FlexibleRightMargin, .FlexibleBottomMargin]
      self.microPhoneImageView.contentMode = .ScaleToFill
      self.addSubview(self.microPhoneImageView)
      self.microPhoneImageView.snp_makeConstraints(closure: { (make) -> Void in
        make.left.equalTo(self).offset(27.0)
        make.top.equalTo(self).offset(8.0)
        make.size.equalTo(CGSize(width: 50.0, height: 99.0))
      })
    }
    
    if self.recordingHUDImageView == nil {
      self.recordingHUDImageView = UIImageView()
      self.recordingHUDImageView.image = UIImage(named: "22.jpg")
      self.recordingHUDImageView.autoresizingMask = [.FlexibleRightMargin, .FlexibleBottomMargin]
      self.addSubview(self.recordingHUDImageView)
      self.recordingHUDImageView.snp_makeConstraints(closure: { (make) -> Void in
        make.left.equalTo(self).offset(82.0)
        make.top.equalTo(self).offset(34.0)
        make.size.equalTo(CGSize(width: 18.0, height: 61.0))
      })
    }
    
    if self.cancelRecordImageView == nil {
      self.cancelRecordImageView = UIImageView()
      self.cancelRecordImageView.image = UIImage(named: "RecordCancel")
      self.cancelRecordImageView.autoresizingMask = [.FlexibleRightMargin, .FlexibleBottomMargin]
      self.cancelRecordImageView.contentMode = .ScaleToFill
      self.addSubview(self.cancelRecordImageView)
      self.cancelRecordImageView.snp_makeConstraints(closure: { (make) -> Void in
        make.left.equalTo(self).offset(19.0)
        make.top.equalTo(self).offset(7.0)
        make.size.equalTo(CGSize(width: 100.0, height: 100.0))
      })
    }
  }

  func startRecordingHUDAtView(view:UIView) {
    view.addSubview(self)
    self.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(view)
    }
    self.configRecoding(true)
    self.backgroundColor = UIColor(netHex: 0x3f80dd)
  }

  func pauseRecord() {
    self.configRecoding(true)
    self.remiadeLable!.text = voiceRecordPauseString
    self.backgroundColor = UIColor(netHex: 0x3f80dd)
  }

  func resaueRecord() {
    self.configRecoding(false)
    self.remiadeLable!.backgroundColor = UIColor.clearColor()
    self.remiadeLable!.text = voiceRecordResaueString
    self.backgroundColor = UIColor(netHex: 0xf47e7e)
  }

  func stopRecordCompleted(completed: (finish:Bool) -> Void) {
    self.dismissCompled(completed)
  }

  func cancelRecordCompleted(completed: (finish:Bool) -> Void) {
    self.dismissCompled(completed)
  }

  func dismissCompleted(completed:(finish:Bool) -> Void) {
    UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
      self.alpha = 0.0
      }) { (finished:Bool) -> Void in
      super.removeFromSuperview()
        completed(finish: finished)
    }
  }
  
  func configRecoding(recording:Bool) {
    self.microPhoneImageView.hidden = !recording
    self.recordingHUDImageView.hidden = !recording
    self.cancelRecordImageView.hidden = recording
  }
  
  func configRecordingHUDImageWithPeakPower(peakPower:Float) {
    var imageName = "RecordingSignal00"
    switch peakPower {
    case peakPower where peakPower > 0 && peakPower <= 0.1:
      imageName += "1"
      break
    case peakPower where peakPower > 0.1 && peakPower < 0.3:
      imageName += "2"
      break
    case peakPower where peakPower > 0 && peakPower < 0.4:
      imageName += "3"
      break
    case peakPower where peakPower > 0 && peakPower < 0.5:
      imageName += "4"
      break
    case peakPower where peakPower > 0 && peakPower < 0.6:
      imageName += "5"
      break
    case peakPower where peakPower > 0 && peakPower < 0.7:
      imageName += "6"
      break
    case peakPower where peakPower > 0 && peakPower < 0.8:
      imageName += "7"
      break
    default:
      imageName += "8"
      break
    }
    
    self.recordingHUDImageView.image = UIImage(named: "22.jpg")
  }

  func setPeakPower(peakPower:Float) {
    self.peakPower = peakPower
    self.configRecordingHUDImageWithPeakPower(peakPower)
  }


//  
//  /*
//  // Only override drawRect: if you perform custom drawing.
//  // An empty implementation adversely affects performance during animation.
//  - (void)drawRect:(CGRect)rect
//  {
//  // Drawing code
//  }
//  */
//
//  
}
