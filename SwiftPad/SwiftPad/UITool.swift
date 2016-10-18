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
    
    
}
