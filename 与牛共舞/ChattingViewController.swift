//
//  JChatChattingViewController.swift
//  JChatSwift
//
//  Created by oshumini on 16/2/17.
//  Copyright © 2016年 HXHG. All rights reserved.
//

import UIKit


@objc(ChattingViewController)
class ChattingViewController: UIViewController {
    
    var dto:NextServiceModel!//客服信息
    
    var messageTable:ChatMessageTable!
    
    var messageInputView:ChatInputView!
    
    var messageDataSource:JChatChattingDataSource!
    var chatLayout:JChatChattingLayout!
    var messageOffset = 0
    
    var isAllowToScrollMessageTable:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(true)
        //设置标题栏
        self.setupNavigation()
        //设置输入框和消息列表
        self.setupAllViews()
        //初始化数据，获取历史数据
        self.setupDataSource()
        
        
        self.chatLayout = JChatChattingLayout(messageTable: self.messageTable, inputView: self.messageInputView)
        
        let gesture = UITapGestureRecognizer(target: self, action:#selector(JChatChattingViewController.handleTap(_:)))
        
        gesture.delegate = self
        self.messageTable.addGestureRecognizer(gesture)
        
        
        messageTable.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewDidLayoutSubviews() {
        if isAllowToScrollMessageTable {
            self.chatLayout.messageTableScrollToBottom(false)
            isAllowToScrollMessageTable = false
        }
    }
    //析构函数
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func setupNavigation() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.navigationBar.translucent = false
        
        //标题
        self.title = dto.name
        
        //搜索按钮
        //        let rightBtn = UIButton(type: .Custom)
        //        rightBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        //        rightBtn.addTarget(self, action: #selector(self.clickRightBtn), forControlEvents: .TouchUpInside)
        //        rightBtn.setImage(UIImage(named: "createConversation"), forState: .Normal)
        //        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15 * UIScreen.mainScreen().scale)
        
        //左侧按钮
        let backbb  = UIButton(frame: CGRectMake(0, 0, 30, 30))
        //        backbb.backgroundColor = UIColor.blackColor()
        backbb.setImage(UIImage(named: "back4"), forState: UIControlState.Normal)
        backbb.backgroundColor = UIColor.clearColor()
        backbb.adjustsImageWhenHighlighted = false
        backbb.addTarget(self, action: #selector(TopServiceWebView.backToPrevious), forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftBarBtn = UIBarButtonItem(customView: backbb)
        
        
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -20;
        
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        //重新运行
        //断了吧,
        //        print("123++++");
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func deleteMessage(notifacation: NSNotification) {
        let message = notifacation.object as! JMSGMessage
        self.messageDataSource.deleteMessage(message)
        self.chatLayout.loadMoreMessage()
    }
    
    func alertToSendImage(notification:NSNotification) {
        let image = notification.object as! UIImage
        self.prepareSendImageMessage(image)
    }
    
    func cleanMessageCache() {
        self.messageDataSource.cleanCache()
        self.messageTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.messageTable.reloadData()
        
    }
    
    func setupAllViews() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        //输入框
        self.messageInputView = JChatInputView(frame: CGRectZero)
        self.view.addSubview(messageInputView)
        self.messageInputView.inputDelegate = self
        self.messageInputView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
        }
        
        self.messageInputView.moreView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp_bottom)
        }
        //消息table
        self.messageTable = JChatMessageTable(frame: CGRectZero)
        self.messageTable.separatorStyle = .None
        self.messageTable.backgroundColor = kTableViewBackgroupColor
        self.messageTable.delegate = self
        self.messageTable.dataSource = self
        self.messageTable.keyboardDismissMode = .Interactive
        self.view.addSubview(messageTable)
        self.messageTable.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.messageInputView.snp_top)
        }
    }
    
    func setupDataSource() {
        
        self.conversation.clearUnreadCount()
        self.messageDataSource = JChatChattingDataSource(conversation: self.conversation, showTimeInterval: 60 * 5, fristPageNumber: 20, limit: 11)
        
        self.messageDataSource.getPageMessage()
    }
    
    func flashToLoadMessage() {
        self.messageDataSource.getMoreMessage()
        self.chatLayout.loadMoreMessage()
    }
    
    func keyboardFrameChanged(notification: NSNotification) {
        let dic = NSDictionary(dictionary: notification.userInfo!)
        let keyboardValue = dic.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let bottomDistance = UIScreen.mainScreen().bounds.size.height - keyboardValue.CGRectValue().origin.y
        let duration = Double(dic.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSNumber)
        
        UIView.animateWithDuration(duration, animations: {
            self.messageInputView.moreView?.snp_updateConstraints(closure: { (make) -> Void in
                make.height.equalTo(bottomDistance)
                //        right
            })
            self.view.layoutIfNeeded()
        }, completion: {
            (value: Bool) in
        })
        
    }
    
}

extension JChatChattingViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.messageDataSource == nil){
            return 0
        }else{
            return self.messageDataSource.allMessageIdArr.count
        }
        //        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //        if (self.messageDataSource == nil){
        
        //            return 60
        //        }else{
        if self.messageDataSource.noMoreHistoryMessage() != true {
            if indexPath.row == 0 {
                return 25
            }
        }
        
        let model = self.messageDataSource.getMessageWithIndex(indexPath.row)
        
        if model.isKindOfClass(JChattimeModel) {
            return 25
        } else {
            return (model as! JChatMessageModel).messageCellHeight
        }
        //        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("Action - cellForRowAtIndexPath")
        if (self.messageDataSource == nil){
            let cell:JChatLoadingMessageCell = JChatTableCellMaker.LoadingCellInTable(tableView)
            
            return cell
        }else{
            
            if self.messageDataSource.noMoreHistoryMessage() != true {
                if indexPath.row == 0 {
                    let cell:JChatLoadingMessageCell = JChatTableCellMaker.LoadingCellInTable(tableView)
                    cell.startLoading()
                    self.performSelector(#selector(self.flashToLoadMessage), withObject: nil, afterDelay: 1)
                    return cell
                }
            }
            
            let model = self.messageDataSource.getMessageWithIndex(indexPath.row)
            
            if model.isKindOfClass(JChattimeModel) {
                let cell:JChatShowTimeCell = JChatTableCellMaker.timeCellInTable(tableView)
                cell.layoutModel(model as! JChattimeModel)
                return cell
            } else {
                
                let message = (model as! JChatMessageModel).message
                
                if message.contentType == .EventNotification {
                    let cell:JChatShowTimeCell = JChatTableCellMaker.timeCellInTable(tableView)
                    cell.layoutWithNotifcation(model as! JChatMessageModel)
                    return cell
                }
                
                if message.isReceived {
                    let cell:JChatLeftMessageCell = JChatTableCellMaker.leftMessageCellInTable(tableView)
                    cell.setCellData((model as! JChatMessageModel), delegate: self)
                    return cell
                } else {
                    let cell:JChatRightMessageCell = JChatTableCellMaker.rightMessageCellInTable(tableView)
                    cell.setCellData((model as! JChatMessageModel), delegate: self)
                    return cell
                }
            }
            
        }
        
    }
    
}


extension JChatChattingViewController:UIGestureRecognizerDelegate {
    func handleTap(recognizer: UITapGestureRecognizer) {
        hideKeyBoardAnimation()
        
        UIView.animateWithDuration(keyboardAnimationDuration) { () -> Void in
            self.view.layoutIfNeeded()
            self.messageInputView.moreView.snp_updateConstraints { (make) -> Void in
                make.height.equalTo(0)
            }
            self.view.layoutIfNeeded()
        }
    }
}


extension JChatChattingViewController:JChatInputViewDelegate {
    
    func showMoreView() {
        hideKeyBoardAnimation()
        UIView.animateWithDuration(0.25) { () -> Void in
            self.messageInputView.moreView?.snp_updateConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(self.view.snp_bottom)
            })
        }
    }
    
    func appendMessage(model:JChatMessageModel) {
        self.messageDataSource.appendMessage(model)
        self.performSelector(#selector(JChatChattingViewController.appendMessageCell), withObject: nil, afterDelay: 0.01);
    }
    
    func appendMessageCell() {
        self.chatLayout.appendTableViewCellAtLastIndex(self.messageDataSource.messageCount())
    }
    
    func appendTimeDate(timeInterVal:NSTimeInterval) {
        self.appendTimeDate(timeInterVal)
        self.chatLayout.appendTableViewCellAtLastIndex(self.messageDataSource.messageCount())
    }
    
    // JMSGTextContent
    func sendTextMessage(messageText: String) {
        
        let textContent:JMSGTextContent = JMSGTextContent(text:messageText)
        
        let textMessage:JMSGMessage = self.conversation.createMessageWithContent(textContent)!
        self.conversation.sendMessage(textMessage)
        let textModel:JChatMessageModel = JChatMessageModel()
        textModel.setChatModel(textMessage)
        self.appendMessage(textModel)
        //            }
        //        }
    }
    
    func SendMessageWithVoice(voicePath:String, durationTime:Double) {
        let voiceContent:JMSGVoiceContent = JMSGVoiceContent(voiceData: NSData(contentsOfFile: voicePath)!, voiceDuration: Int(durationTime))
        let voiceMessage:JMSGMessage? = self.conversation.createMessageWithContent(voiceContent)
        self.conversation.sendMessage(voiceMessage!)
        let voicemodel:JChatMessageModel = JChatMessageModel()
        voicemodel.setChatModel(voiceMessage)
        self.appendMessage(voicemodel)
    }
    
    func prepareSendImageMessage(image:UIImage) {
        var message:JMSGMessage? = nil
        let imageContent = JMSGImageContent(imageData: UIImagePNGRepresentation(image)!)
        if imageContent != nil {
            message = self.conversation.createMessageWithContent(imageContent!)
            JChatSendImageManager.sharedInstance.addMessage(message!, withConversation: self.conversation)
            let model:JChatMessageModel = JChatMessageModel()
            model.setChatModel(message)
            self.messageDataSource.appendMessage(model)
            self.messageTable.reloadData()
            self.chatLayout.messageTableScrollToBottom(false)
        }
    }
    
    func relayoutTableCellWithMsgId(messageId:String) {
        if messageId == "" { return }
        
        let indexPath = self.messageDataSource.tableIndexPathWithMessageId(messageId)
        
        let messageCell = self.messageTable.cellForRowAtIndexPath(indexPath) as? JChatMessageCell
        messageCell?.layoutAllViews()
    }
    
    // TODO:   targetUid
    func startRecordingVoice() {
    }
    
    
    func finishRecordingVoice(filePath:String, durationTime:Double) {
        self.SendMessageWithVoice(filePath, durationTime: durationTime)
    }
    
    func cancelRecordingVoice() {
        
    }
    
    
    func photoClick() {
    }
}

extension JChatChattingViewController : JChatMessageCellDelegate {
    
    func selectHeadView(model:JChatMessageModel) {
        if model.message.fromUser.isEqualToUser(JMSGUser.myInfo()) {
            //      let myInfoVC = JChatUserInfoViewController()
            //      self.navigationController?.pushViewController(myInfoVC, animated: true)
        } else {
            //      let friendInfoVC = JChatFriendDetailViewController()
            //      friendInfoVC.user = model.message.fromUser
            //      if conversation.conversationType == .Group {
            //        friendInfoVC.isGroupFlag = true
            //      } else {
            //        friendInfoVC.isGroupFlag = false
            //      }
            //
            //      self.navigationController?.pushViewController(friendInfoVC, animated: true)
        }
    }
    
    //  picture  JMSGHttpManager
    func tapPicture(messageModel: JChatMessageModel, tableViewCell: UITableViewCell) {
        let browserImageVC = JChatImageBrowserViewController()
        let tmpImageArr = self.messageDataSource.imageMessageArr
        browserImageVC.imageArr = tmpImageArr
        print("\(tmpImageArr.indexOfObject(messageModel))")
        browserImageVC.imgCurrentIndex = tmpImageArr.indexOfObject(messageModel)
        
        self.presentViewController(browserImageVC, animated: true) {
            
        }
    }
    
    //  voice
    func getContinuePlay(cell:UITableViewCell) {
        
    }
    
    func successionalPlayVoice(cell:UITableViewCell) {
        
    }
}

extension JChatChattingViewController: JMessageDelegate {
    
    func onSendMessageResponse(message: JMSGMessage!, error: NSError!) {
        print("Event - sendMessageResponse")
        self.relayoutTableCellWithMsgId(message.msgId)
        
        if message != nil { print("发送的消息为 msgId 为 \(message.msgId)") }
        
        if error != nil {
            print("Send response error \(NSString.errorAlert(error))")
            self.conversation.clearUnreadCount()
            MBProgressHUD.showMessage(NSString.errorAlert(error), view: self.view)
        }
    }
    
    func onReceiveMessage(message: JMSGMessage!, error: NSError!) {
        self.conversation.clearUnreadCount()
        if message != nil {
            print("收到 message msgID 为 \(message.msgId)")
        } else {
            print("收到message 为 nil")
        }
        
        if error != nil {
            return
        }
        
        if !self.conversation.isMessageForThisConversation(message) {
            return
        }
        
        if message.contentType == .Custom { return }
        
        if messageDataSource.isContaintMessage(message.msgId) { print("该条消息已加载") }
        
        if message.contentType == .EventNotification {}
        
        let model = JChatMessageModel()
        model.setChatModel(message)
        self.appendMessage(model)
    }
    
    func onReceiveMessageDownloadFailed(message: JMSGMessage!) {
        print("Event - receiveMessageNotification")
        
        if self.conversation.isMessageForThisConversation(message) == false { return }
        
        if message == nil { print("get nil message") }
        
        if self.conversation.isMessageForThisConversation(message) {
            let model = JChatMessageModel()
            model.setChatModel(message)
            self.appendMessage(model)
        }
    }
}

func hideKeyBoardAnimation() {
    dispatch_async(dispatch_get_main_queue()) {
        UIApplication.sharedApplication().sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, forEvent: nil)
    }
    UIApplication.sharedApplication().sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, forEvent: nil)
    
}
