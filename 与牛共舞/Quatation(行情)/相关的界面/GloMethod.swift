//
//  GloMethod.swift
//  two
//
//  Created by 雷伊潇 on 16/5/8.
//  Copyright © 2016年 515. All rights reserved.
//


import CoreData
import UIKit

extension Double{
    func format(f: String) -> String {
        //        return NSString(format: "%\(f)f", self) as String
        return NSString(format: "%.2f", self) as String
    }
}


class GloMethod:NSObject{
    
    static func insertViewController(view:UIViewController){
        GloStr.viewControllList.append(view)
    }
    
    static func removeViewController(view:UIViewController){
        
        if GloStr.viewControllList.count>0 {
            for v in 0...GloStr.viewControllList.count-1{
                if view == GloStr.viewControllList[v] {
                    GloStr.viewControllList.removeAtIndex(v)
                }
            }
        }
        
    }
    
    static func insertPNSUser(){
        
    
    }
    
    
    static func setWebList(type:Int,str:NSNumber)->[NSNumber]{
        let list:[NSNumber] = (AppDelegate.delegate as! AppDelegate).listKefu
        switch type {
        case 1://insert
            var isAdd:Bool=false
            for  a in list{
                if a == str {
                    isAdd=true
                    break;
                }else{
                    continue
                }
            }
            if(isAdd){
                break
            }else{
                (AppDelegate.delegate as! AppDelegate).listKefu.append(str)
            }
            
        case 2://remove
             if list.count>0 {
                 for  a in 0...(list.count-1){
                    if list[a] == str {
                        (AppDelegate.delegate as! AppDelegate).listKefu.removeAtIndex(a)
                        break;
                    }
                }
            }
            
        case 3://get
            break
        default:
            break
        }
        return (AppDelegate.delegate as! AppDelegate).listKefu
    }
    
    
    static func setYear(){
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyyy"
        let strNowTime = timeFormatter.stringFromDate(date) as String
        let yearInt = Int(strNowTime)
        if yearInt<=2018 {
            GloStr.year=yearInt!
        }else{
            GloStr.year=2018
        }
        
    }
    
    
    static func changeStrToShou(str:String) ->String{
        let length=(str as NSString).length
        if length<5{
            return str+"手"
        }else if length<9{
            return ((Double(str)!/10000) as Double).format(".1")+"万"
        }else {
            return ((Double(str)!/100000000) as Double).format(".1")+"亿"
        }
        
    }
    
    
    static func djchangeStrToShou(str:String) ->String{
        let length=(str as NSString).length
        if length<7{
            return str+"手"
        }else if length<11{
            return ((Double(str)!/10000) as Double).format(".1")+"万"
        }else {
            return ((Double(str)!/100000000) as Double).format(".1")+"亿"
        }
        
    }
    
    
    
    static func change126CodeTo(code:String,symbol:String) -> String{
        var a=(code as NSString).substringToIndex(1)
        if a == "0" {
            return symbol+"1"
        }else if a == "1"{
            return symbol+"2"
        }else{
            return ""
        }
        
    }
    static func changeDFCFWTo126(code:String,symbol:String) -> String{
        var a=(code as NSString).substringFromIndex(6)
        if a == "1"{
            return "0"+symbol
        }else if a == "2"{
            return "1"+symbol
        }else{
            return ""
        }
        
        
    }
    
    
    
    //    static func fromJsonToGP(jsonData:String)
    
    static func formJsonToBD(jsonData:String) ->[JSON]{
       
        let res = jsonData.stringByReplacingOccurrencesOfString("var quote_123=", withString: "").stringByReplacingOccurrencesOfString("rank", withString: "\"rank\"").stringByReplacingOccurrencesOfString("pages", withString: "\"pages\"")
        let json = JSON(data:res.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        return json["rank"].array!
    }
    
    static func fromJsonToDetail(jsonData:String) -> GPBean{
        let gpBean:GPBean=GPBean()
        //        let res = jsonData.stringByReplacingOccurrencesOfString("_ntes_quote_callback(", withString: "").stringByReplacingOccurrencesOfString(");", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let res = jsonData.stringByReplacingOccurrencesOfString("callback(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
        
        let json = JSON(data:res.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        //        print(json["Value"])
        let jsonResult=json["Value"]
        
        if jsonResult.count <= 0 {
            gpBean.statu=false
            return gpBean
        }
        
        
        gpBean._0citycode=jsonResult[0].string
        gpBean._1symbol=jsonResult[1].string
        if gpBean._0citycode == "1" {
            gpBean.code="0"+gpBean._1symbol!
        }else if gpBean._0citycode == "2"{
            gpBean.code="1"+gpBean._1symbol!
        }
        gpBean.statu=true
        gpBean._2name=jsonResult[2].string
        gpBean._3buy1=jsonResult[3].string
        gpBean._4buy2=jsonResult[4].string
        gpBean._5buy3=jsonResult[5].string
        gpBean._6buy4=jsonResult[6].string
        gpBean._7buy5=jsonResult[7].string
        gpBean._8sell1=jsonResult[8].string
        gpBean._9sell2=jsonResult[9].string
        gpBean._10sell3=jsonResult[10].string
        gpBean._11sell4=jsonResult[11].string
        gpBean._12sell5=jsonResult[12].string
        gpBean._13buy1num=jsonResult[13].string
        gpBean._14buy2num=jsonResult[14].string
        gpBean._15buy3num=jsonResult[15].string
        gpBean._16buy4num=jsonResult[16].string
        gpBean._17buy5num=jsonResult[17].string
        gpBean._18sell1num=jsonResult[18].string
        gpBean._19sell2num=jsonResult[19].string
        gpBean._20sell3num=jsonResult[20].string
        gpBean._21sell4num=jsonResult[21].string
        gpBean._22sell5num=jsonResult[22].string
        gpBean._23zhangting=jsonResult[23].string
        gpBean._24dieting=jsonResult[24].string
        gpBean._25price=jsonResult[25].string
        gpBean._26averageprice=jsonResult[26].string
        gpBean._27updown=jsonResult[27].string
        gpBean._28todayopen=jsonResult[28].string
        gpBean._29updownpercent=jsonResult[29].string
        gpBean._30top=jsonResult[30].string
        gpBean._31sumhand=jsonResult[31].string
        gpBean._32bottom=jsonResult[32].string
        gpBean._34yestclose=jsonResult[34].string
        gpBean._35dealmoney=jsonResult[35].string
        gpBean._36liangbi=jsonResult[36].string
        gpBean._37changehandpercent=jsonResult[37].string
        gpBean._39waipan=jsonResult[39].string
        gpBean._40neipan=jsonResult[40].string
        gpBean._41weibi=jsonResult[41].string
        gpBean._42weicha=jsonResult[42].string
        gpBean._45liutongshizhi=jsonResult[45].string
        gpBean._46zongshizhi=jsonResult[46].string
        gpBean._49time=jsonResult[49].string
        gpBean._50zhenfu=jsonResult[50].string
        
        return gpBean
        
    }
    
    
    
    
    static func fromJsonTok(jsonData:String) -> KBean{
        let json = JSON(data:jsonData.dataUsingEncoding(NSUTF8StringEncoding)!)
        let rik:KBean = KBean()
        rik.name = json["name"].string
        rik.symbol = json["symbol"].string
        rik.data = json["data"].array
        return rik
        
    }
    
    static func fromJsonToSearch(jsonData:String) -> [GupiaoBean]{
        var gupiaoBeans:[GupiaoBean]=[]
        let res = jsonData.stringByReplacingOccurrencesOfString("_ntes_stocksearch_callback(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
        let json = JSON(data:res.dataUsingEncoding(NSUTF8StringEncoding)!)
        let arr = json.array
        for item in arr!{
            let gp:GupiaoBean=GupiaoBean()
            gp.name = item["name"].string!
            gp.symbol = item["symbol"].string!
            if item["type"].string! == "SH"{
                gp.code = "0"+gp.symbol!
            }else if item["type"].string! == "SZ"{
                gp.code = "1"+gp.symbol!
            }else {
                continue
            }
            gupiaoBeans.append(gp)
            
        }
        
        return gupiaoBeans
        
    }
    
    static func fromJsonToFenshi(jsonData:String) -> FenshiBean{
        let json = JSON(data:jsonData.dataUsingEncoding(NSUTF8StringEncoding)!)
        let fenshi : FenshiBean = FenshiBean()
        
        fenshi.count = json["count"].stringValue
        
        fenshi.date = json["date"].string
        fenshi.lastVolume = json["lastVolume"].stringValue
        fenshi.name = json["name"].string
        fenshi.symbol = json["symbol"].string
        fenshi.yestclose = json["yestclose"].stringValue
        
        fenshi.data = json["data"].array
        
        
        
        
        //        let a = fenshi.data
        //        let b = a!.stringByReplacingOccurrencesOfString("[[", withString: "[")
        //
        //        print(a)
        return fenshi
        
    }
    static func isFirst() -> Bool{
        if GloMethod.isAdd(GloStr.isFirst) {
            return false
            
        }else{
            let gupiaobean:GupiaoBean=GupiaoBean()
            gupiaobean.code = GloStr.isFirst
            
            GloMethod.insertGupiaoBean(gupiaobean)
            return true
        }
        
    }
    static func insertGupiaoBean(gupiaoBean:GupiaoBean){
        let app = AppDelegate.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        //创建User对象
        let myGupiao = NSEntityDescription.insertNewObjectForEntityForName("MyGupiao",inManagedObjectContext: context) as! MyGupiao
        
        //对象赋值
        myGupiao.name=gupiaoBean.name
        myGupiao.code=gupiaoBean.code
        myGupiao.symbol=gupiaoBean.symbol            //保存
        do {
            try context.save()
        }
        catch{
            fatalError("不能保存：\(error)")
        }
        
    }
    static func insertKSet(kset0:KSetBean){
        let app = AppDelegate.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        //创建User对象
        let kset = NSEntityDescription.insertNewObjectForEntityForName("KSet",inManagedObjectContext: context) as! KSet
        
        //对象赋值
        kset.name=kset0.name
        kset.desc=kset0.desc
        kset.isUse=kset0.isUse          //保存
        do {
            try context.save()
        }
        catch{
            fatalError("不能保存：\(error)")
        }
    }
    static func deleteGupiaoBean(code:String) {
        let app = AppDelegate.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("MyGupiao",
                                                                            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            
            
            //遍历查询的结果
            for info:MyGupiao in fetchedObjects as! [MyGupiao]{
                if info.code ==  code {
                    context.deleteObject(info)
                }
                
            }
            try context.save()
            
        }
        catch {
            
        }
    }
    static func selectGupiaos() -> [GupiaoBean]{
        var gupiaos:[GupiaoBean] = []
        let  app = AppDelegate.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("MyGupiao",
                                                                            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            for info:MyGupiao in fetchedObjects as! [MyGupiao] {
                if(info.code == GloStr.isFirst){}
                else{
                    
                    let gupiaoBean:GupiaoBean = GupiaoBean()
                    gupiaoBean.name = info.name
                    gupiaoBean.symbol = info.symbol
                    gupiaoBean.code = info.code
                    gupiaos.append(gupiaoBean)
                }
                
            }
            return gupiaos
            
            
        }
        catch {
            return gupiaos
        }
        
        
    }
    static func selectAllKset()->[KSetBean]{
        var ksets:[KSetBean] = []
        let  app = AppDelegate.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("KSet",
                                                                            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            for info:KSet in fetchedObjects as! [KSet] {
                
                let kset:KSetBean = KSetBean()
                kset.name = info.name
                kset.desc = info.desc
                kset.isUse = info.isUse
                ksets.append(kset)
                
                
                
            }
            return ksets
            
            
        }
        catch {
            return ksets
        }
        
    }
    static func selectCode(code:String) -> GupiaoBean{
        let gupiaoBean:GupiaoBean = GupiaoBean()
        let  app = AppDelegate.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("MyGupiao",
                                                                            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            for info:MyGupiao in fetchedObjects as! [MyGupiao] {
                if info.code == code {
                    gupiaoBean.name = info.name
                    gupiaoBean.symbol = info.symbol
                    gupiaoBean.code = info.code
                    return gupiaoBean
                }
            }
            return gupiaoBean
            
            
        }
        catch {
            return gupiaoBean
        }
        
        
    }
    
    
    static func isAdd(code:String) -> Bool{
        let  app = AppDelegate.delegate as! AppDelegate
        
        let context = app.managedObjectContext
        
        
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("MyGupiao",
                                                                            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            for info:MyGupiao in fetchedObjects as! [MyGupiao] {
                if info.code == code {
                    return true
                }
            }
            return false
            
            
        }
        catch {
            return false
        }
    }
    static func isAddKSet(name:String)->Bool{
        let  app = AppDelegate.delegate as! AppDelegate
        
        let context = app.managedObjectContext
        
        
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("KSet",
                                                                            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            for info:KSet in fetchedObjects as! [KSet] {
                if info.name == name {
                    return true
                }
            }
            return false
            
            
        }
        catch {
            return false
        }
        
    }
    
    static func updateKset(kset:KSetBean) -> Bool {
        
        //需要执行的代码块
        
        let  app = AppDelegate.delegate as! AppDelegate
        
        let context = app.managedObjectContext
        
        
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("KSet",
                                                                            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            for info:KSet in fetchedObjects as! [KSet] {
                if info.name == kset.name {
                    info.isUse=kset.isUse
                    break
                }
            }
            
            return true
        }
        catch {
            
            return false
        }
        
    }
    
    
    static func deleteAll(){
        let app = AppDelegate.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        //        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("MyGupiao",
                                                                            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        //        let predicate = NSPredicate(format: "code= '0000001' ", "")
        //        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects:[AnyObject]? = try context.executeFetchRequest(fetchRequest)
            
            
            //遍历查询的结果
            for info:MyGupiao in fetchedObjects as! [MyGupiao]{
                context.deleteObject(info)
            }
            try context.save()
            
        }
        catch {
            
        }
        
        
    }
    
    
}

