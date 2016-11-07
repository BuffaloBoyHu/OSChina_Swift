//
//  UserFollow.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/5.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class UserFollow: NSObject {

    var followers :NSInteger? = 0
    var following :NSInteger? = 0
    var starred :NSInteger? = 0
    var watched :NSInteger? = 0
    
    init(dict :Dictionary<String,NSInteger>) {
        super.init()
        self.followers = dict["followers"]
        self.following = dict["following"]
        self.starred = dict["starred"]
        self.watched = dict["watched"]
    }
}
