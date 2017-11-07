
//  Created by Mac on 16/8/22.  mygupiao
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import SwiftHTTP



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate{
    
    weak var conversation:JMSGConversation!
    weak var chattingVC:DMJChatChattingViewController!
    var HQHeaderButton : UIButton!
    var HQHeaderLabel : UILabel!
    var window: UIWindow?
    var viewCCCCCC: ViewController!
    
    var timer : NSTimer!
    var searchcode:[String]?
    
    var listGP:[ListBean]?
    
    var pageCondition:Int = 0 //0:其他界面 1:客服列表界面 2: 聊天界面
    
    var devicetoken:String = ""
    
    var listKefu:[NSNumber]=[]
    
    var listViewController:[UIViewController]=[]
    
    static var delegate: UIApplicationDelegate?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        
        AppDelegate.delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        GloMethod.setYear()
        if GloMethod.isFirst() {
            let gupiaoBean:GupiaoBean=GupiaoBean()
            if !GloMethod.isAdd("0000001") {
                gupiaoBean.name="上证指数"
                gupiaoBean.code="0000001"
                gupiaoBean.symbol="000001"
                GloMethod.insertGupiaoBean(gupiaoBean)
                
            }
            if !GloMethod.isAdd("1399001"){
                gupiaoBean.name="深证成指"
                gupiaoBean.code="1399001"
                gupiaoBean.symbol="399001"
                GloMethod.insertGupiaoBean(gupiaoBean)
            }
            if !GloMethod.isAdd("1399006"){
                gupiaoBean.name="创业板指"
                gupiaoBean.code="1399006"
                gupiaoBean.symbol="399006"
                GloMethod.insertGupiaoBean(gupiaoBean)
            }
            let kset:KSetBean=KSetBean();
            if !GloMethod.isAddKSet("成交量") {
                kset.name="成交量"
                kset.desc="成交量"
                kset.isUse="1"
                GloMethod.insertKSet(kset)
            }
            if !GloMethod.isAddKSet("MACD") {
                kset.name="MACD"
                kset.desc="指数平滑移动平均线"
                kset.isUse="1"
                GloMethod.insertKSet(kset)
            }
            if !GloMethod.isAddKSet("KDJ") {
                kset.name="KDJ"
                kset.desc="随机指标"
                kset.isUse="1"
                GloMethod.insertKSet(kset)
            }
        }
 
        
        let VC1 : UIViewController = HomeViewController()
        if let notification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? [String: AnyObject] {
            //后台启动
            let aps = notification["aps"] as! [String: AnyObject]
//            VC1.openKefu=true
        }
        let nav1 = UINavigationController(rootViewController:VC1)
        nav1.tabBarItem = UITabBarItem(title:"首页", image: UIImage(named: "home.png"), tag:1)
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let anotherView:UIViewController = myStoryBoard.instantiateViewControllerWithIdentifier("fiveonefive_main") as! ViewController
        
        let nav2 = UINavigationController(rootViewController:anotherView)
        nav2.tabBarItem = UITabBarItem(title:"行情", image: UIImage(named: "hudong.png"), tag:2)
        
        let VC3 : UIViewController = InformationViewController()
        let nav3 = UINavigationController(rootViewController:VC3)
        nav3.tabBarItem = UITabBarItem(title:"资讯", image: UIImage(named: "news.png"), tag:3)
        
        NSNotificationCenter.defaultCenter().addObserver(VC3, selector:NSSelectorFromString("tiao:") , name: "tiao", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(VC3, selector: NSSelectorFromString("pianyi:"), name: "pianyi", object: nil)
        
        let VC4 : UIViewController = MeViewController()
        let nav4 = UINavigationController(rootViewController:VC4)
        nav4.tabBarItem = UITabBarItem(title:"我的", image: UIImage(named: "my.png"), tag:4)
        
        let arr = [nav1,nav2,nav3,nav4]
        
        let tabarController = UITabBarController()
        
        tabarController.viewControllers = arr
        tabarController.selectedIndex = 0
        tabarController.tabBar.translucent = false
        
        tabarController.tabBar.tintColor = UIColor.orangeColor()
        // 引导页
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = UIColor.whiteColor()
        
        
        self.window?.rootViewController = tabarController
        
        
        // http://app.yngw518.com/api.php/Index/getAdpic?token=8c2f64f08271fc4e43
        
        
        let url = NSURL(string: "http://app.yngw518.com/api.php/Index/getAdpic?token=8c2f64f08271fc4e43")
        let data = NSData(contentsOfURL: url!)
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        var json : AnyObject?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        }catch let error as NSError{
            print(error)
        }
        
        let meg : String = json?.objectForKey("url") as! String
        let number1 : NSNumber = json?.objectForKey("ad_vesion") as! NSNumber
        
        WZXLaunchViewController.showWithFrame(CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height), imageURL: meg, advertisingURL: "", timeSecond: 3, hideSkip: false, imageLoadGood: { (image : UIImage!, string : String!) in
            }, clickImage: { (viewccc : UIViewController!) in
                
        }) {
            self.window?.rootViewController = tabarController
        }
        
        
        self.window?.rootViewController?.hidesBottomBarWhenPushed = false
        self.window?.makeKeyAndVisible()
        
        registerAppNotificationSettings(launchOptions as [NSObject : AnyObject]?)
        
        
        return true
    }
    
    //获取到devicetoken
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        //注册deviceToken
        let nsdataStr = NSData.init(data: deviceToken)
        
        let datastr = nsdataStr.description.stringByReplacingOccurrencesOfString("<", withString: "").stringByReplacingOccurrencesOfString(">", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
        
        print((datastr))
        self.devicetoken=datastr
        //判断是否登录，如果登录则发送注册信息
        let loadAll =  NSUserDefaults.standardUserDefaults().objectForKey("LoadAll") as? NSDictionary;
        devicetoken=datastr
        
        if(loadAll != nil){
            let userId=loadAll?.objectForKey("uid") as! String
            do{
                let opt = try HTTP.GET(GloStr.insertPNSUser+userId+"&deviceToken="+devicetoken)
                opt.start{result in
                    if let error = result.error{
                        print(error)
                    }
                    else{
                        print("devicetoken success send")
                    }
                    
                }
            }
            catch let error {
                print("请求失败: \(error)")
            }
        }
        
        //如果未登录则只存储
    }
    
    private func registerAppNotificationSettings(launchOptions: [NSObject: AnyObject]?) {
        if #available(iOS 10.0, *) {
            let notifiCenter = UNUserNotificationCenter.currentNotificationCenter()
            notifiCenter.delegate = self
            let types = UNAuthorizationOptions(arrayLiteral: [UNAuthorizationOptions.Alert, UNAuthorizationOptions.Badge, UNAuthorizationOptions.Sound])
            notifiCenter.requestAuthorizationWithOptions(types) { (flag, error) in
                if flag {
                    print("iOS request notification success")
                }else{
                    print(" iOS 10 request notification fail")
                }
            }
        } else { //iOS8,iOS9注册通知
            let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
            let pushNotificationSettings = UIUserNotificationSettings.init(forTypes: notificationTypes, categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(pushNotificationSettings)
        }
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    //iOS10新增：处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        jumpOrStay(true, userInfo: userInfo)
        
        
        completionHandler([UNNotificationPresentationOptions.Sound,UNNotificationPresentationOptions.Alert])
    }
    
    //iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, didReceiveNotificationResponse response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        jumpOrStay(false, userInfo: userInfo)
        completionHandler()
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        if application.applicationState == UIApplicationState.Active {
            jumpOrStay(true, userInfo: userInfo)
        }else{
            jumpOrStay(false, userInfo:userInfo)
        }
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    //7和7之前
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        jumpOrStay(false, userInfo:userInfo)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("点击本地推送")
    }
    
    func jumpOrStay(frontOrBack:Bool,userInfo: [NSObject : AnyObject]) {
        print("收到新消息\(userInfo)")
        UIApplication.sharedApplication().applicationIconBadgeNumber=0
        
        let info:NSDictionary=userInfo
        
        let type:String = info.objectForKey("type") as! String
        
        if type == "web"{
            let webKefuId = NSNumber.init(double: NSString.init(string:String(info.objectForKey("msg")!)).doubleValue)
            
            GloMethod.setWebList(1, str: webKefuId)
            
            //判断界面状态
            //如果是其他界面
            if pageCondition == 0{
                if frontOrBack {//如果是在前台
                    //发送本地推送通知
                    sendLocalNotification(userInfo)
                }
                //跳转到客服列表界面
                toKefuView()
            }
                
            else if pageCondition == 1{//如果是客服列表
                //刷新客服列表
                (listViewController[0] as! ServiceViewController).comeNews()
            }
                
            else if pageCondition == 2{//如果是聊天界面
                
                let newKefuId = (listViewController[0] as! ChatViewController).getKefuDto().originalId
                
                //判断当前聊天的客服 ==？？收到的新消息的客服
                if webKefuId==newKefuId {
                    //如果是，调用获取新消息方法
                    (listViewController[0] as! ChatViewController).getNewData()
                }
                    //如果不是
                else{
                    if frontOrBack {//如果在前台
                        //发送本地推送
                        sendLocalNotification(userInfo)
                        //跳转到客服列表界面
                        toKefuView()
                    }
                }
            }
            
        }else {
            
            
        }

    }
    
    func toKefuView(){
    }
    
    func sendLocalNotification(userInfo: [NSObject : AnyObject]){
        //如果已存在该通知消息，则先取消
        cancelNotification(userInfo)
        
        //创建UILocalNotification来进行本地消息通知
        let localNotification = UILocalNotification()
        
        //推送时间（设置为30秒以后）
        localNotification.fireDate =  NSDate(timeIntervalSinceNow: 1)
        //时区
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        //推送内容
        localNotification.alertBody = "客服消息"
        //声音
        localNotification.soundName = UILocalNotificationDefaultSoundName
        //额外信息
        localNotification.userInfo = ["type":"local"]
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    //取消通知消息
    func cancelNotification(userInfo: [NSObject : AnyObject]){
        //通过itemID获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForThisItem(userInfo)
        if existingNotification != nil {
            //如果existingNotification不为nil，就取消消息推送
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
    }
    
    //通过遍历所有消息推送，通过itemid的对比，返回UIlocalNotification
    func notificationForThisItem(userInfo: [NSObject : AnyObject])-> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:String]
            let number = info["type"]
            
            let temp:NSDictionary=userInfo
            
            let type:String = temp.objectForKey("type") as! String
            if number != nil && number == type {
                return notification as UILocalNotification
            }
        }
        return nil
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //重置界面状态
        pageCondition=0
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Dim.____" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Demo", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        
        var optionsdic = [NSMigratePersistentStoresAutomaticallyOption:true,NSInferMappingModelAutomaticallyOption :true]
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: optionsdic)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        // UserInfo
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
}

