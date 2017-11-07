//
//  GloStr.swift
//  two
//
//  Created by 雷伊潇 on 16/5/10.
//  Copyright © 2016年 515. All rights reserved.
//

import Foundation

class GloStr{
    static var viewControllList:[UIViewController]=[]
    
    
    static let isFirst = "isFirst"
    
    static let gpURL = "http://api.money.126.net/data/feed/"
    static let gpURL2 = "http://nuff.eastmoney.com/EM_Finance2015TradeInterface/JS.ashx?id="
    static let fenshi = "http://img1.money.126.net/data/hs/time/today/"
    static let rikURL = "http://img1.money.126.net/data/hs/kline/day/history/"
    static let zhoukURL = "http://img1.money.126.net/data/hs/kline/week/history/"
    static let yuekURL = "http://img1.money.126.net/data/hs/kline/month/history/"
    
    
    static let ZFUrl="http://hqdigi2.eastmoney.com/EM_Quote2010NumericApplication/index.aspx?type=s&sortType=C&sortRule=-1&page=1&jsName=quote_123&style=33&pageSize="+String(GloStr.BDPageSize)
    static let DFUrl="http://hqdigi2.eastmoney.com/EM_Quote2010NumericApplication/index.aspx?type=s&sortType=C&sortRule=1&page=1&jsName=quote_123&style=33&pageSize="+String(GloStr.BDPageSize)
    static let HSLUrl="http://hqdigi2.eastmoney.com/EM_Quote2010NumericApplication/index.aspx?type=s&sortType=J&sortRule=-1&page=1&jsName=quote_123&style=33&pageSize="+String(GloStr.BDPageSize)
    static let ZFBUrl="http://hqdigi2.eastmoney.com/EM_Quote2010NumericApplication/index.aspx?type=s&sortType=K&sortRule=-1&page=1&jsName=quote_123&style=33&pageSize="+String(GloStr.BDPageSize)
    static let BDPageSize=10;
    
    static let searchURL="http://quotes.money.163.com/stocksearch/json.do?type=&count=20"
    
    
    
    
    static let KefuListAllUrl="http://"+GloStr.serverIp+":"+String(GloStr.serverPort)+"/danceWithCow/is/customerStaff/getAllListNoPage";
    static let KefuListUrl="http://"+GloStr.serverIp+":"+String(GloStr.serverPort)+"/danceWithCow/is/customerStaff/getAllList4Mobile?pageNo=";
    
    static let SendChatGetUrl="http://"+GloStr.serverIp+":"+String(GloStr.serverPort)+"/danceWithCow/is/onlineConsult/toSendContentGet?changeMessageJson=";
    static let GetChatGetUrl="http://"+GloStr.serverIp+":"+String(GloStr.serverPort)+"/danceWithCow/is/onlineConsult/toDetails?";
    static let ErrorLogUrl="http://"+GloStr.serverIp+":"+String(GloStr.serverPort)+"/danceWithCow/is/mobileLog/log?log=";
    static let insertPNSUser="http://"+GloStr.serverIp+":"+String(GloStr.serverPort)+"/danceWithCow/is/mobileLog/insertPNSUser?userId=";//deviceToken=
    static let kftjurl = "http://appv2.yngw518.com/api.php/customer/recom?token=8c2f64f08271fc4e43";
    //获取old聊天记录    http://118.31.115.18:8080/danceWithCow/is/onlineConsult/getOldData?
    // memberId=906540947&backId=840773943&memberName=123456&backName=aaa&id=128&pageSize=5
    static let oldData = "http://"+GloStr.serverIp+":"+String(GloStr.serverPort)+"/danceWithCow/is/onlineConsult/getOldData?";
    static let newData = "http://"+GloStr.serverIp+":"+String(GloStr.serverPort)+"/danceWithCow/is/onlineConsult/getNewData?";
    
    static let loginUrl = "http://appv2.yngw518.com/api.php/user/login?token=8c2f64f08271fc4e43&username="
    
    static let serverIp="118.31.115.18";
    static let chatPort=8888;
    static let serverPort=8080;
    
    
    
    static var year = 2017
    static let K_ri_start=2015;
    static let K_ri_end=year;
    static let K_zhou_start=2010;
    static let K_zhou_end=year;
    static let K_yue_start=2005;
    static let K_yue_end=year;
    
}

