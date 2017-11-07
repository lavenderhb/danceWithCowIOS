//
//  ViewController.swift
//  hangge_559
//
//  Created by hangge on 2017/4/5.
//  Copyright © 2017年 hangge. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, ChatDataSource,UITextFieldDelegate {
    
    var Chats:NSMutableArray!
    var tableView:ChatTableView!
    var me:ChatUserInfo!
    var you:ChatUserInfo!
    var txtMsg:UITextField!
    
    var kefu:NextServiceModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        Chats = NSMutableArray()
        
        setupChatTable()
        setupSendPanel()
    }
    
    func setupSendPanel()
    {
        let screenWidth = KScreenWidth
        let sendView = UIView(frame:CGRect(x: 0,y: self.view.frame.size.height - 56,width: screenWidth,height: 56))
        
        sendView.backgroundColor=UIColor.lightGrayColor()
        sendView.alpha=0.9
        
        txtMsg = UITextField(frame:CGRect(x: 7,y: 10,width: screenWidth - 95,height: 36))
        txtMsg.backgroundColor = UIColor.whiteColor()
        txtMsg.textColor=UIColor.blackColor()
        txtMsg.font=UIFont.boldSystemFontOfSize(12)
        txtMsg.layer.cornerRadius = 10.0
        txtMsg.returnKeyType = UIReturnKeyType.Send
        
        //Set the delegate so you can respond to user input
        txtMsg.delegate=self
        sendView.addSubview(txtMsg)
        self.view.addSubview(sendView)
        
        let sendButton = UIButton(frame:CGRect(x: screenWidth - 80,y: 10,width: 72,height: 36))
        sendButton.backgroundColor=UIColor(red: 0x37/255, green: 0xba/255, blue: 0x46/255, alpha: 1)
        sendButton.addTarget(self, action:#selector(ChatViewController.sendMessage) ,
                             forControlEvents:UIControlEvents.TouchUpInside)
        sendButton.layer.cornerRadius=6.0
        sendButton.setTitle("发送", forState:UIControlState())
        sendView.addSubview(sendButton)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        sendMessage()
        return true
    }
    
    func sendMessage()
    {
        //composing=false
        let sender = txtMsg
        let thisChat =  MessageItem(body:sender!.text! as NSString, user:me, date:NSDate(), mtype:ChatType.mine)
        let thatChat =  MessageItem(body:"你说的是：\(sender!.text!)" as NSString, user:you, date:NSDate(), mtype:ChatType.someone)
        
        Chats.addObject(thisChat)
        Chats.addObject(thatChat)
        self.tableView.chatDataSource = self
        self.tableView.reloadData()
        
        //self.showTableView()
        sender?.resignFirstResponder()
        sender?.text = ""
    }
    
    func setupChatTable()
    {
        
        self.tableView = ChatTableView(frame:CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height - 76), style:UITableViewStyle.Plain)
        
        //创建一个重用的单元格
        self.tableView!.registerClass(TableViewCell.self, forCellReuseIdentifier: "ChatCell")
        
        
        me = ChatUserInfo(name:"Xiaoming" ,logo:("xiaoming.png"))
        you  = ChatUserInfo(name:"Xiaohua", logo:("xiaohua.png"))
        
        
        let zero =  MessageItem(body:"最近去哪玩了？", user:you,  date:NSDate(timeIntervalSinceNow:-90096400), mtype:.someone)
        
        let zero1 =  MessageItem(body:"去了趟苏州，明天发照片给你哈？", user:me,  date:NSDate(timeIntervalSinceNow:-90086400), mtype:.mine)
        
        let first =  MessageItem(body:"你看这风景怎么样，我周末去苏州拍的！", user:me,  date:NSDate(timeIntervalSinceNow:-90000400), mtype:.mine)
        
        let second =  MessageItem(image:UIImage(named:"sz.png")!,user:me, date:NSDate(timeIntervalSinceNow:-90000290), mtype:.mine)
        
        let third =  MessageItem(body:"太赞了，我也想去那看看呢！",user:you, date:NSDate(timeIntervalSinceNow:-90000060), mtype:.someone)
        
        let fouth =  MessageItem(body:"嗯，下次我们一起去吧！",user:me, date:NSDate(timeIntervalSinceNow:-90000020), mtype:.mine)
        
        let fifth =  MessageItem(body:"三年了，我终究没能看到这个风景",user:you, date:NSDate(timeIntervalSinceNow:0), mtype:.someone)
        
        
        //        Chats.addObject(first)
        //        Chats.addObject(second)
        //        Chats.addObject(third)
        //        Chats.addObject(fifth)
        //        Chats.addObject(zero)
        //        Chats.addObject(zero1)
        
        Chats.addObjectsFromArray([first,second, third, fouth, fifth,zero,zero1])
        
        self.tableView.chatDataSource = self
        
        //call the reloadData, this is actually calling your override method
        self.tableView.reloadData()
        
        self.view.addSubview(self.tableView)
        
    }
    
    func rowsForChatTable(tableView:ChatTableView) -> Int
    {
        return self.Chats.count
    }
    
    
    func chatTableView(tableView:ChatTableView, dataForRow row:Int) -> MessageItem
    {
        return Chats[row] as! MessageItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



