//
//  ChatViewController.swift
//  图灵聊天
//
//
//  Created by Huangjunwei on 15/9/1.
//  Copyright (c) 2015年 codeGlider. All rights reserved.
//

import UIKit

import SnapKit
import SwiftHTTP

extension String {
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.stringByRemovingPercentEncoding ?? ""
    }
}


let messageFontSize: CGFloat = 17
let toolBarMinHeight: CGFloat = 44
let textViewMaxHeight: (portrait: CGFloat, landscape: CGFloat) = (portrait: 272, landscape: 90)

let pageSize:Int=10

class ChatViewController:UITableViewController,UITextViewDelegate {
    //MARK:属性定义
    var toolBar: UIToolbar!
    var textView: UITextView!
    var sendButton: UIButton!
    var messages:[[ChatMessage]] = [[]]
    var response:String?
    
    var msgChanges:[MessageChange]=[]
    
    var kefuDto:NextServiceModel?
    
    var newId=NSNumber.init(char: -1)
    var oldId=NSNumber.init(char: -1)
    
    var timer:NSTimer!
    
    //MARK:生命周期管理
    func getInstence(){
        
    }
  
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        (AppDelegate.delegate as! AppDelegate).pageCondition=0
        (AppDelegate.delegate as! AppDelegate).listViewController.removeAtIndex(0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        (AppDelegate.delegate as! AppDelegate).pageCondition=2
        (AppDelegate.delegate as! AppDelegate).listViewController.insert(self,atIndex: 0)
    }
    
    func showSelf(viewController: UIViewController, animated: Bool){
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getKefuDto()->NextServiceModel{
        return kefuDto!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GloMethod.setWebList(2, str: (kefuDto?.originalId)!)
        
        self.navigationItem.title = kefuDto?.name
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let backbb  = UIButton(frame: CGRectMake(0, 0, 30, 30))
        //        backbb.backgroundColor = UIColor.blackColor()
        backbb.setImage(UIImage(named: "back4"), forState: UIControlState.Normal)
        backbb.backgroundColor = UIColor.clearColor()
        backbb.adjustsImageWhenHighlighted = false
        backbb.addTarget(self, action: #selector(self.backToPrevious), forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarBtn = UIBarButtonItem(customView: backbb)
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -20;
        
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
        
        tableView = UITableView(frame: view.bounds, style:UITableViewStyle.Plain)
        tableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
        self.tableView.estimatedRowHeight = 44
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:toolBarMinHeight, right: 0)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.registerClass(MessageSentDateTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MessageSentDateTableViewCell))
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(self.getOldData),
                                       forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉更多")
        
        getOldData()
        timer = NSTimer.scheduledTimerWithTimeInterval(1,target:self,selector:#selector(self.getNewData),userInfo:nil,repeats:true)
    }
    
    
    //发送通知消息
    func scheduleNotification(itemID:Int){
        //如果已存在该通知消息，则先取消
        cancelNotification(itemID)
        
        //创建UILocalNotification来进行本地消息通知
        let localNotification = UILocalNotification()
        //推送时间（设置为30秒以后）
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
        //时区
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        //推送内容
        localNotification.alertBody = "有新消息"
        //声音
        localNotification.soundName = UILocalNotificationDefaultSoundName
        //额外信息
//        localNotification.userInfo = ["ItemID":itemID]
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    //取消通知消息
    func cancelNotification(itemID:Int){
        //通过itemID获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForThisItem(itemID)
        if existingNotification != nil {
            //如果existingNotification不为nil，就取消消息推送
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
    }
    
    //通过遍历所有消息推送，通过itemid的对比，返回UIlocalNotification
    func notificationForThisItem(itemID:Int)-> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:Int]
            let number = info["ItemID"]
            if number != nil && number == itemID {
                return notification as UILocalNotification
            }
        }
        return nil
    }
    
    func getNewData(){
        let loadAll =  NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary;
        if loadAll==nil{
            return
        }
        let userId=loadAll?.objectForKey("uid") as! String
        let webId=String(kefuDto!.originalId!)
        let userName=loadAll?.objectForKey("username") as! String
        let webName=kefuDto?.name
        
        do{
            let url:String
            let url1=GloStr.newData+"memberId="+userId+"&backId="+webId
            let url2="&memberName="+userName+"&backName="+webName!
            if newId == -1{
                url=url1+url2+"&id="
            }else{
                url=url1+url2+"&id="+String(newId)
            }
            
            let opt = try HTTP.GET(url.urlEncoded())
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    let json = JSON(data:result.text!.dataUsingEncoding(NSUTF8StringEncoding)!)
                    let resultArray=json["content"].array!
                    if resultArray.count>0{
                        
                        var msgTemp:[MessageChange]=[]
                        
                        for item in resultArray{
                            var msg:MessageChange=MessageChange()
                            msg.id=item["id"].number
                            msg.readStatus=item["readStatus"].string
                            msg.attachedPic=item["attachedPic"].number
                            msg.time=item["time"].number
                            msg.contentKey=item["contentKey"].string
                            msg.type=item["type"].string
                            msg.messageType=item["messageType"].string
                            msg.modifyTime=item["modifyTime"].number
                            msg.chatContents=item["chatContents"].string
                            
                            msgTemp.append(msg)
                        }
                        
                        msgTemp=msgTemp.reverse()
                        
                        for item in msgTemp{
                            var chatMsg:ChatMessage
                            let timeInterval:NSTimeInterval = NSTimeInterval(item.time!.doubleValue/1000)
                            
                            if item.type == "replay"{
                                chatMsg=ChatMessage(incoming: true,text:item.chatContents!,sentDate:NSDate(timeIntervalSince1970:timeInterval))
                            }else{
                                chatMsg=ChatMessage(incoming: false,text:item.chatContents!,sentDate:NSDate(timeIntervalSince1970:timeInterval))
                            }
                            self.messages.append([chatMsg])
                            self.msgChanges.append(item)
                        }
                        
                    }else{
                        return
                    }
                    
                    dispatch_async(dispatch_get_main_queue(),{
//                        self.scheduleNotification(12345)
                        self.tableView.reloadData()
                        self.setPageData()
                        self.tableViewScrollToBottomAnimated(true)

                    })
                }
            }
        }
            
        catch let error {
            print("请求失败: \(error)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews()  {
        super.viewDidLayoutSubviews()
        
    }
    func sendAction() {
        
        let loadAll =  NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary;
        
        let userId=loadAll?.objectForKey("uid") as! String
        let webId=String(kefuDto!.originalId!)
        
        var message = ChatMessage(incoming: false, text: textView.text, sentDate: NSDate())
        
        var sendMsg = MessageSend(memberId: userId,backId: webId,content: textView.text,type: "send")
        
        
        do{
            let opt = try HTTP.GET((GloStr.SendChatGetUrl+sendMsg.getJsonString()).urlEncoded())
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    let json = JSON(data:result.text!.dataUsingEncoding(NSUTF8StringEncoding)!)
                    let resultArray=json["content"].dictionary!
                    
                    var msg:MessageChange=MessageChange()
                    msg.id=resultArray["id"]!.number
                    msg.readStatus=resultArray["readStatus"]!.string
                    msg.time=resultArray["time"]!.number
                    msg.contentKey=resultArray["contentKey"]!.string
                    msg.type=resultArray["type"]!.string
                    msg.messageType=resultArray["messageType"]!.string
                    msg.chatContents=resultArray["chatContents"]!.string
                    
                    self.msgChanges.append(msg)
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.messages.append([message])
                        
                        self.textView.text = nil
                        self.updateTextViewHeight()
                        self.sendButton.enabled = false
                        
                        let lastSection = self.tableView.numberOfSections
                        self.tableView.beginUpdates()
                        self.tableView.insertSections(NSIndexSet(index: lastSection), withRowAnimation:.Automatic)
                        self.tableView.insertRowsAtIndexPaths([
                            NSIndexPath(forRow: 0, inSection: lastSection),
                            NSIndexPath(forRow: 1, inSection: lastSection)
                            ], withRowAnimation: .Automatic)
                        self.tableView.endUpdates()
                        self.tableViewScrollToBottomAnimated(true)
                        
                        self.setPageData()

                    })
                }
            }
            
            
        }catch let error {
            print("请求失败: \(error)")
        }
    }
    
    
    
    func getOldData(){
        //        messages = [[ChatMessage(incoming: true, text: "1", sentDate: NSDate())],
        //                    [ChatMessage(incoming: true, text: "2", sentDate: NSDate())],
        //        [ChatMessage(incoming: true, text: "3", sentDate: NSDate())]]
        
        let loadAll =  NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary;
        let userId=loadAll?.objectForKey("uid") as! String
        let webId=String(kefuDto!.originalId!)
        let userName=loadAll?.objectForKey("username") as! String
        let webName=kefuDto?.name
        
        do{
            let url:String
            let url1=GloStr.oldData+"memberId="+userId+"&backId="+webId
            let url2="&memberName="+userName+"&backName="+webName!
            if oldId == -1{
                url=url1+url2+"&id="+"&pageSize="+String(pageSize)
            }else{
                url=url1+url2+"&id="+String(oldId)+"&pageSize="+String(pageSize)
            }
            
            let opt = try HTTP.GET(url.urlEncoded())
            opt.start{ result in
                if let error = result.error{
                    print(error)
                }
                else{
                    let json = JSON(data:result.text!.dataUsingEncoding(NSUTF8StringEncoding)!)
                    let resultArray=json["content"].array!
                    if resultArray.count>0{
                        
                        
                        for item in resultArray{
                            var msg:MessageChange=MessageChange()
                            msg.id=item["id"].number
                            msg.readStatus=item["readStatus"].string
                            msg.attachedPic=item["attachedPic"].number
                            msg.time=item["time"].number
                            msg.contentKey=item["contentKey"].string
                            msg.type=item["type"].string
                            msg.messageType=item["messageType"].string
                            msg.modifyTime=item["modifyTime"].number
                            msg.chatContents=item["chatContents"].string
                            self.msgChanges.insert(msg, atIndex: 0)
                            
                            var chatMsg:ChatMessage
                            
                            
                            let timeInterval:NSTimeInterval = NSTimeInterval((msg.time?.doubleValue)!/1000)
                            
                            if msg.type == "replay"{
                                chatMsg=ChatMessage(incoming: true,text:msg.chatContents!,sentDate:NSDate(timeIntervalSince1970:timeInterval))
                            }else{
                                chatMsg=ChatMessage(incoming: false,text:msg.chatContents!,sentDate:NSDate(timeIntervalSince1970:timeInterval))
                            }
                            self.messages.insert([chatMsg], atIndex: 0)
                        }
                        
                    }else{
                        return
                    }
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableView.reloadData()
                        self.setPageData()
                        self.refreshControl!.endRefreshing()

                        self.tableViewScrollToBottomAnimated(true)
                        
                    })
                }
            }
        }
            
        catch let error {
            print("请求失败: \(error)")
        }
        
    }
    
    
    func setPageData(){
        if msgChanges.count>0{
            newId=msgChanges[msgChanges.count-1].id!
            oldId=msgChanges[0].id!
        }
        
        
    }
    
    override var inputAccessoryView: UIView! {
        get {
            if toolBar == nil {
                
                toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: toolBarMinHeight-0.5))
                
                textView = UITextView(frame: CGRect.zero)
                textView.backgroundColor = UIColor(white: 250/255, alpha: 1)
                textView.delegate = self
                textView.font = UIFont.systemFontOfSize(messageFontSize)
                textView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor
                textView.layer.borderWidth = 0.5
                textView.layer.cornerRadius = 5
                textView.scrollsToTop = false
                textView.textContainerInset = UIEdgeInsetsMake(4, 3, 3, 3)
                toolBar.addSubview(textView)
                
                sendButton = UIButton.init(type: UIButtonType.System)
                sendButton.enabled = false
                sendButton.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
                sendButton.setTitle("发送", forState: UIControlState())
                sendButton.setTitleColor(UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1), forState: UIControlState.Disabled)
                sendButton.setTitleColor(UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0), forState: UIControlState())
                sendButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                sendButton.addTarget(self, action: #selector(self.sendAction), forControlEvents: UIControlEvents.TouchUpInside)
                
                toolBar.addSubview(sendButton)
                
                // Auto Layout allows `sendButton` to change width, e.g., for localization.
                //                textView.setTranslatesAutoresizingMaskIntoConstraints(false)
                //                sendButton.setTranslatesAutoresizingMaskIntoConstraints(false)
                textView.snp_makeConstraints{ (make) -> Void in
                    
                    make.left.equalTo(self.toolBar.snp_left).offset(8)
                    make.top.equalTo(self.toolBar.snp_top).offset(7.5)
                    make.right.equalTo(self.sendButton.snp_left).offset(-2)
                    make.bottom.equalTo(self.toolBar.snp_bottom).offset(-8)
                    
                }
                
                sendButton.snp_makeConstraints{ (make) -> Void in
                    make.right.equalTo(self.toolBar.snp_right)
                    make.bottom.equalTo(self.toolBar.snp_bottom).offset(-4.5)
                    
                }
                
            }
            return toolBar
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        let userInfo = notification.userInfo as NSDictionary!
        let frameNew = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let insetNewBottom = self.tableView.convertRect(frameNew, fromView: nil).height
        let insetOld = tableView.contentInset
        let insetChange = insetNewBottom - insetOld.bottom
        let overflow = tableView.contentSize.height - (tableView.frame.height-insetOld.top-insetOld.bottom)
        
        
        let duration = (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations: (() -> Void) = {
            if !(self.tableView.tracking || self.tableView.decelerating) {
                // 根据键盘位置调整Inset
                if overflow > 0 {
                    self.tableView.contentOffset.y += insetChange
                    if self.tableView.contentOffset.y < -insetOld.top {
                        self.tableView.contentOffset.y = -insetOld.top
                    }
                } else if insetChange > -overflow {
                    self.tableView.contentOffset.y += insetChange + overflow
                }
            }
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            // http://stackoverflow.com/a/18873820/242933
            UIView.animateWithDuration(duration, delay: 0, options: options, animations: animations, completion: nil)
        } else {
            animations()
        }
    }
    
    
    //MARK:textView代理方法
    func textViewDidChange(textView: UITextView) {
        updateTextViewHeight()
        sendButton.enabled = textView.hasText()
    }
    //MARK:tableView代理方法
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if  let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as? MessageBubbleTableViewCell{
            if selectedCell.url != ""{
                let url = NSURL(string: selectedCell.url)
                UIApplication.sharedApplication().openURL(url!)
                
            }
        }
        
        return indexPath
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellIdentifier = NSStringFromClass(MessageSentDateTableViewCell)
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath) as! MessageSentDateTableViewCell
            
            if messages[indexPath.section].count==0 {
                return cell
            }
            let message = messages[indexPath.section][0]
            
            cell.sentDateLabel.text = formatDate(message.sentDate as NSDate)
            
            return cell
            
        }else{
            let cellIdentifier = NSStringFromClass(MessageBubbleTableViewCell)
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MessageBubbleTableViewCell!
            if cell == nil {
                
                cell = MessageBubbleTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                
            }
            
            let message = messages[indexPath.section][indexPath.row - 1]
            cell?.configureWithMessage(message)
            
            return cell!
        }
    }
    
    
    func formatDate(date: NSDate) -> String {
        let format:NSDateFormatter=NSDateFormatter()
        format.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        
        return format.stringFromDate(date)

        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return messages.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages[section].count + 1
    }
    
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo = notification.userInfo as NSDictionary!
        let frameNew = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue
        let table = tableView
        let insetNewBottom = table.convertRect(frameNew(), fromView: nil).height
        
        
        //根据键盘高度设置Inset
        let contentOffsetY = tableView.contentOffset.y
        tableView.contentInset.bottom = insetNewBottom
        tableView.scrollIndicatorInsets.bottom = insetNewBottom
        //根据键盘高度设置Inset
        if self.tableView.tracking || self.tableView.decelerating {
            tableView.contentOffset.y = contentOffsetY
        }
    }
    
    
    func tableViewScrollToBottomAnimated(animated: Bool) {
        
        let numberOfSections = messages.count
        let numberOfRows = messages[numberOfSections - 1].count
        let nsIndex:NSIndexPath=NSIndexPath.init(forRow: numberOfRows, inSection: numberOfSections-1)
        if numberOfRows > 0 {
            tableView.scrollToRowAtIndexPath(nsIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
        }
    }
    func updateTextViewHeight() {
        
        let oldHeight = textView.frame.height
        let maxHeight = UIInterfaceOrientationIsPortrait(interfaceOrientation) ? textViewMaxHeight.portrait : textViewMaxHeight.landscape
        var newHeight = min(textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.max)).height, maxHeight)
        #if arch(x86_64) || arch(arm64)
            newHeight = ceil(newHeight)
        #else
            newHeight = CGFloat(ceilf(newHeight.native))
        #endif
        if newHeight != oldHeight {
            toolBar.frame.size.height = newHeight+8*2-0.5
        }
    }
    func backToPrevious(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
class InputTextView: UITextView {
    
    
    
}
