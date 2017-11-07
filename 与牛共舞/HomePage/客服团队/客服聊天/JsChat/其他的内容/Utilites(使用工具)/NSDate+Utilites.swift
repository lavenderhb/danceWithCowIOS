//
//  NSDate+Utilites.swift
//  JChatSwift
//
//  Created by oshumini on 16/2/24.
//  Copyright © 2016年 HXHG. All rights reserved.
//

import UIKit

let FORMAT_PAST_SHORT:String = "yyyy/MM/dd"
let FORMAT_PAST_TIME:String = "ahh:mm"
let FORMAT_THIS_WEEK:String = "eee ahh:mm"
let FORMAT_THIS_WEEK_SHORT:String = "eee"
let FORMAT_YESTERDAY:String = "ahh:mm"
let FORMAT_TODAY:String = "ahh:mm"

let D_MINUTE = 60.0
let D_HOUR = 3600.0
let D_DAY = 86400.0
let D_WEEK = 604800.0
let D_YEAR = 31556926.0

internal let componentFlags:NSCalendarUnit = [.Year, .Month, .Day, .Weekday, .Hour, .Minute, .Second, .WeekdayOrdinal]

extension NSDate {
  class func currentCalendar1() -> NSCalendar{
    let calendar = NSCalendar.autoupdatingCurrentCalendar()
    return calendar
  }

  func isEqualToDateIgnoringTime1(date:NSDate) -> Bool{
    let components1:NSDateComponents = NSDate.currentCalendar1().components(componentFlags, fromDate: self)
    let components2:NSDateComponents = NSDate.currentCalendar1().components(componentFlags, fromDate: date)
    return (components1.year == components2.year) && (components1.month == components2.month) && (components1.date == components2.day)

  }

  func dateByAddingDays1(days:Int) -> NSDate {
    let dateComponents = NSDateComponents()
    dateComponents.day = days
    let newDate:NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options:NSCalendarOptions(rawValue: 0))!
    return newDate
  }
  
  func dateBySubtractingDays1(days:Int) -> NSDate {
     return self.dateByAddingDays1(days * -1)
  }
  
  class func dateWithDaysFromNow1(days:Int) -> NSDate {
    return NSDate().dateByAddingDays1(days)
  }

  class func dateWithDaysBeforeNow1(days:Int) -> NSDate {
    return NSDate().dateBySubtractingDays1(days)
  }

  class func dateTomorrow1() -> NSDate{
    return NSDate.dateWithDaysFromNow1(1)
  }
  
  class func dateYesterday1() -> NSDate {

    return NSDate.dateWithDaysBeforeNow1(1)
  }
  
  func isToday1() -> Bool {
    return self.isEqualToDateIgnoringTime1(NSDate())
  }

  func isTomorrow1() -> Bool {
    return self.isEqualToDateIgnoringTime1(NSDate.dateTomorrow1())
  }

  func isYesterday1() -> Bool {
    return self.isEqualToDateIgnoringTime1(NSDate.dateYesterday1())
  }

  func isSameWeekAsDate1(date:NSDate) -> Bool {
    let components1:NSDateComponents = NSDate.currentCalendar1().components(componentFlags, fromDate: self)
    let components2:NSDateComponents = NSDate.currentCalendar1().components(componentFlags, fromDate: date)
    if components1.weekOfYear != components2.weekOfYear { return false }
    return (fabs(self.timeIntervalSinceDate(date)) < D_WEEK)
  }
  
  func isThisWeek1() -> Bool {
    return self.isSameWeekAsDate1(NSDate())
  }
}
