//
//  tab.swift
//  two
//
//  Created by 雷伊潇 on 16/5/7.
//  Copyright © 2016年 515. All rights reserved.
//

import UIKit
import CoreData
import SwiftHTTP

//import SwiftHTTP



class tab: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tabv: UITableView!
    var gupiaoBeans:[GupiaoBean] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromDB()
        
        // Do any additional setup after loading the view.
    }
    
    
    func getDataFromDB(){
        gupiaoBeans=GloMethod.selectGupiaos()
        
        do{
            for gp in gupiaoBeans {
                let code = GloMethod.change126CodeTo(gp.code!, symbol: gp.symbol!)
                let opt = try HTTP.GET(GloStr.gpURL2+code)
                opt.start{ result in
                    if let error = result.error{
                        print(error)
                    }
                    else{
                        //                    print(result.text)
                        let gupiaonew=GloMethod.fromJsonToDetail(result.text!)
                        gp.price=gupiaonew._25price
                        gp.percent=gupiaonew._29updownpercent
                        dispatch_async(dispatch_get_main_queue(),{
                            self.tabv.reloadData()
                        })
                    }
                }
            }
            
        }catch let error {
            print("请求失败: \(error)")
            
        }
    }
    
    //定义tab行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print(gupiaoBeans.count)
        return gupiaoBeans.count
        
    }
    override func viewWillAppear(animated: Bool) {
        if animated {
            getDataFromDB()
            tabv.reloadData()
        }
    }
    
    //定义tab每行具体数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
//        cell.textLabel?.text = "股票\([indexPath.row])"
        
        let name = cell.viewWithTag(1) as! UILabel
        let symbol = cell.viewWithTag(2) as! UILabel
        let price = cell.viewWithTag(3) as! UILabel
        let percent = cell.viewWithTag(4) as! UILabel
        name.text = gupiaoBeans [indexPath.row].name
        symbol.text = gupiaoBeans [indexPath.row].symbol
        price.text = gupiaoBeans[indexPath.row].price
        percent.text = gupiaoBeans[indexPath.row].percent
        
        //        if gupiaoBeans[indexPath.row].price == nil{
        //        return cell}
        //        if gupiaoBeans[indexPath.row].yestclose == nil{
        //        return cell}
        //        let bjxj = price.text// 现价文本颜色
        //        print(gupiaoBeans [1].name)
        //        let bjsj = Double(gupiaoBeans[indexPath.row].yestclose!)
        //        if bjxj > bjsj{
        //            price.textColor = UIColor.redColor()
        //            percent.textColor = UIColor.redColor()
        //        }
        //        if  bjxj < bjsj{
        //            price.textColor = UIColor.greenColor()
        //            percent.textColor = UIColor.greenColor()
        //        }
        
        let percentString = gupiaoBeans[indexPath.row].percent
        if percentString != nil{
            if (percentString! as NSString).substringToIndex(1) == "-"{
                price.textColor = UIColor.greenColor()
                percent.textColor = UIColor.greenColor()
                percent.text = gupiaoBeans[indexPath.row].percent!+"%"
            }else if percentString == "0.00"{
                price.textColor = UIColor.blackColor()
//                price.textColor = UIColor.whiteColor()
                percent.textColor = UIColor.blackColor()
                percent.text = gupiaoBeans[indexPath.row].percent!+"%"
            }else{
                price.textColor = UIColor.redColor()
                percent.textColor = UIColor.redColor()
                percent.text = gupiaoBeans[indexPath.row].percent!+"%"
            }
        }
        
        
        //        if indexPath.row%2==0{
        //            price.textColor = UIColor.redColor()
        //            percent.textColor = UIColor.redColor()
        //            //            cell.contentView.backgroundColor=UIColor.whiteColor()
        //        }else{
        //            cell.contentView.backgroundColor=UIColor.whiteColor()
        //
        //        }
        return cell
    }
    
    func panduan(){
        for index in 0 ... gupiaoBeans.count {
//                        let bjsj = Double(gupiaoBeans[index].yestclose!)
        }
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //        for index in 0 ... gupiaoBeans.count {
        //            //            let bjsj = Double(gupiaoBeans[index].yestclose!)
        //            print(index)
        //
        //        }
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        self.tabv!.deselectRowAtIndexPath(indexPath, animated: true)
        let itemString = [self.gupiaoBeans[indexPath.row].name!,self.gupiaoBeans[indexPath.row].symbol!,self.gupiaoBeans[indexPath.row].code!]
        //        print(itemString)
        self.performSegueWithIdentifier("wori", sender: itemString)
        
    }
    
    func tableView(tableView: UITableView,
                   commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                      forRowAtIndexPath indexPath: NSIndexPath) {
        print("删除\(indexPath.row)")
        let index = indexPath.row
        GloMethod.deleteGupiaoBean(gupiaoBeans[index].code!)
        self.gupiaoBeans.removeAtIndex(index)
        self.tabv?.deleteRowsAtIndexPaths([indexPath],
                                          withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    //滑动删除
    func tableView(tableView: UITableView,
                   editingStyleForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCellEditingStyle {
            return UITableViewCellEditingStyle.Delete
    }
    
    //修改删除按钮的文字
    func tableView(tableView: UITableView,
                   titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath)
        -> String? {
            return "删除"
    }
    
    //在这个方法中给新页面传递参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "wori"{
            let controller = segue.destinationViewController as! qpxq
            controller.itemString = sender as? [String]
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
