//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


print(str)

let timeInterval:TimeInterval = TimeInterval(1508261406180/1000)



let format:DateFormatter=DateFormatter()
format.dateFormat="yyyy年MM月dd日 HH:mm:ss"

let date = NSDate(timeIntervalSince1970:timeInterval)

format.string(from: date as Date)


let date1=Date().timeIntervalSince1970

let a = ["a","b","c","d"]

let b:String = String(describing: a)

//let a:Double=Double.init("p")!

