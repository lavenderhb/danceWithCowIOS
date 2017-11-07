//
//  CrashManager.swift
//  XYGenericFramework
//
//  Created by xiaoyi on 2017/8/15.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//

import Foundation


enum CrashPathEnum:String {
    case signalCrashPath = "signaCrash"
    case nsExceptionCrashPath = "nsExceptionCrash"
}


//MARK: - Crash处理总入口,请留意不要集成多个crash捕获，NSSetUncaughtExceptionHandler可能会被覆盖.NSException的crash也会同时生成一个signal异常信息
func crashHandle(crashContentAction: ([String])->Void){
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),{
        
        if CrashManager.readAllCrashInfo().count > 0 {
            //如果崩溃信息不为空，则对崩溃信息进行下一步处理
            crashContentAction(CrashManager.readAllCrashInfo())
        }
        CrashManager.deleteAllCrashFile()
    })
    
    //注册signal,捕获相关crash
    registerSignalHandler()
    //注册NSException,捕获相关crash
    registerUncaughtExceptionHandler()
}



class CrashManager: NSObject {
    
    //MARK: - 保存崩溃信息
    class func saveCrash(appendPathStr:CrashPathEnum,exceptionInfo:String)
    {
        let filePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!+("/\(appendPathStr.rawValue)")
        
        let crashPath = filePath
        
        if !NSFileManager.defaultManager().fileExistsAtPath(crashPath) {
            
            try? NSFileManager.defaultManager().createDirectoryAtPath(crashPath, withIntermediateDirectories: true, attributes: nil)
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd-HHmmss"
        let dateString =   dateFormatter.stringFromDate(NSDate())
        
        
        let crashFilePath = crashPath+("/\(dateString).log")
        //cmDebugPrint(crashFilePath)
        
        try? exceptionInfo.writeToFile(crashFilePath, atomically: true, encoding: NSUTF8StringEncoding)
        
    }
    
    
    
    //MARK: - 获取所有的log列表
    class func CrashFileList(crashPathStr:CrashPathEnum) -> [String] {
        let pathcaches = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let cachesDirectory = pathcaches[0]
        let crashPath = cachesDirectory+("/\(crashPathStr.rawValue)")
        
        let fileManager = NSFileManager.defaultManager()
        
        var logFiles: [String] = []
        let fileList = try? fileManager.contentsOfDirectoryAtPath(crashPath)
        if let list = fileList {
            for fileName in list {
                if let _ = fileName.rangeOfString(".log") {
                    logFiles.append(crashPath+"/"+fileName)
                }
            }
        }
        
        return logFiles
    }
    
    
    
    
    //MARK: - 读取所有的崩溃信息
    class func readAllCrashInfo() -> [String] {
        var crashInfoArr:[String] = Array()
        
        //删除signal崩溃文件
        for signalPathStr in CrashFileList(.signalCrashPath){
            if let content = try? String(contentsOfFile: signalPathStr, encoding: NSUTF8StringEncoding) {
                crashInfoArr.append(content)
                //cmDebugPrint(content)
            }
        }
        //删除NSexception崩溃文件
        for exceptionPathStr in CrashFileList(.nsExceptionCrashPath){
            if let content = try? String(contentsOfFile: exceptionPathStr, encoding: NSUTF8StringEncoding){
                crashInfoArr.append(content)
            }
        }
        
        return crashInfoArr
    }
    
    
    
    
    //MARK: - 删除所有崩溃信息文件信息
    class func deleteAllCrashFile(){
        //删除signal崩溃文件
        for signalPathStr in CrashFileList(.signalCrashPath){
            try? NSFileManager.defaultManager().removeItemAtPath(signalPathStr)
            //cmDebugPrint(signalPathStr)
        }
        //删除NSexception崩溃文件
        for exceptionPathStr in CrashFileList(.nsExceptionCrashPath){
            try? NSFileManager.defaultManager().removeItemAtPath(exceptionPathStr)
        }
        
    }
    
    
    //MARK: - 删除单个崩溃信息文件
    class func DeleteCrash(crashPathStr:CrashPathEnum, fileName: String) {
        let pathcaches = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let cachesDirectory = pathcaches[0]
        let crashPath = cachesDirectory+("/\(crashPathStr)")
        
        let filePath = crashPath+("/\(fileName)")
        let fileManager = NSFileManager.defaultManager()
        try? fileManager.removeItemAtPath(filePath)
    }
    
    //MARK: - 读取单个文件崩溃信息
    class func ReadCrash(crashPathStr:CrashPathEnum, fileName: String) -> String? {
        let pathcaches = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let cachesDirectory = pathcaches[0]
        let crashPath = cachesDirectory+("/\(crashPathStr)")
        
        let filePath = crashPath+("/\(fileName)")
        let content = try? String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
        return content
    }
    
    
}
