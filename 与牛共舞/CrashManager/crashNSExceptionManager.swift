//
//  crashNSExceptionManager.swift
//  XYGenericFramework
//
//  Created by xiaoyi on 2017/8/15.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//  用于捕获OC的NSException导致的异常崩溃

import UIKit



func registerUncaughtExceptionHandler()
{
    NSSetUncaughtExceptionHandler(UncaughtExceptionHandler)
}

func UncaughtExceptionHandler(exception: NSException) {
    let arr = exception.callStackSymbols
    let reason = exception.reason
    let name = exception.name
    var crash = String()
    crash += "Stack:\n"
    crash = crash.stringByAppendingFormat("slideAdress:0x%0x\r\n", calculate())
    crash += "\r\n\r\n name:\(name) \r\n reason:\(String(reason)) \r\n \(arr.joinWithSeparator("\r\n")) \r\n\r\n"

     CrashManager.saveCrash(.nsExceptionCrashPath, exceptionInfo: crash)
}

