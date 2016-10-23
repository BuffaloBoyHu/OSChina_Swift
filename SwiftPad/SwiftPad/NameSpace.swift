//
//  NameSpace.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/22.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class NameSpace: NSObject {
    var address : String?
    var avatar : String?
    var created_at : String?
    var descirption : String?
    var email :String?
    var id :NSInteger?
    var location : String?
    var name : String?
    var owner_id : NSInteger?
    var path : String?
    var publicStr : String?
    var url : String?
    
    init(dict : Dictionary<String,Any>) {
        super.init()
        self.address = dict["address"] as? String
        self.avatar = dict["avatar"] as? String
        self.created_at = dict["created_at"] as? String
        self.descirption = dict["description"] as? String
        self.email = dict["email"] as? String
        self.id = dict["id"] as? NSInteger
        self.location = dict["location"] as? String
        self.name = dict["name"] as? String
        self.owner_id = dict["owner_id"] as? NSInteger
        self.path = dict["path"] as? String
        self.publicStr = dict["public"] as? String
        self.url = dict["url"] as? String
    }
}
