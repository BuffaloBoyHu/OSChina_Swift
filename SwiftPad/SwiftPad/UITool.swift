//
//  UITool.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/17.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
//
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
class UITool: NSObject {
    
   class public func UIColorFromRGB(rgbValue :NSInteger) ->UIColor {
        let color = UIColor.init(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16) / 255.0) , green: ((CGFloat)((rgbValue & 0xFF00) >> 8)/255.0), blue: ((CGFloat)(rgbValue & 0xFF) / 255.0), alpha: 1.0);
        return color;
    }
    
   class public func uniformColor() -> UIColor {
        
        return UIColor.init(red: 235.0 / 255, green: 235.0 / 255, blue: 243.0 / 255, alpha: 1.0)
    }
    
    class public func formateDate(dateStr :String?) -> String? {
        if dateStr == nil {
            return nil
        }
        let dateFormatter  = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date  = dateFormatter.date(from: dateStr!)
        let calander = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let unitFlags :NSCalendar.Unit = [.year,.month,.day,.hour,.minute]
        let pastComponents = calander?.components(unitFlags, from: date!)
        let nowComponents = calander?.components(unitFlags, from: Date.init())
        let year = (nowComponents?.year)! - (pastComponents?.year)!
        let month = (nowComponents?.month)! - (pastComponents?.month)! + year * 24
        let day = (nowComponents?.day)! - (pastComponents?.day)! + month * 30
        let hour = (nowComponents?.hour)! - (pastComponents?.hour)! + day * 24
        let minute = (nowComponents?.minute)! - (pastComponents?.minute)! + hour * 60
        
        var formateDateStr :String? = nil
        if minute < 1 {
            formateDateStr = "刚刚"
        }else if minute < 60 {
            formateDateStr = "\(minute) 分钟前"
        }else if hour < 24 {
            formateDateStr = "\(hour) 小时前"
        }else if hour < 48 && day == 1 {
            formateDateStr = "昨天"
        }else if day < 30 {
            formateDateStr = "\(day) 天前"
        }else if day < 60 {
            formateDateStr = "一个月前"
        }else if month < 12 {
            formateDateStr = "\(month) 月前"
        }else {
            formateDateStr = dateStr?.components(separatedBy: "T").first
        }
        return formateDateStr
    }
    
    
}
