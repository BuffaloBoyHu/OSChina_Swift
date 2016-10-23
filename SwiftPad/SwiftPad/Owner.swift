//
//  Owner.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/22.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class Owner: NSObject {
    var id :NSInteger?
    var userName :String?
    var email :String?
    var name :String?
    var state :String?
    var created_at :String?
    var portrait :String?
    var new_portrait:String?
    
    init(dict : Dictionary<String,Any>) {
        super.init()
        self.id = dict["id"] as? NSInteger
        self.userName = dict["username"] as?String
        self.email = dict["email"] as? String
        self.name = dict["name"] as? String
        self.state = dict["state"] as? String
        self.created_at = dict["created_at"] as? String
        self.portrait = dict["portrait"] as? String
        self.new_portrait = dict["new_portrait"] as? String
    }
}
