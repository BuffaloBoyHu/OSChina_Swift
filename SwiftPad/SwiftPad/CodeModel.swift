//
//  CodeModel.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/31.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class CodeModel: NSObject {

    var name :String?
    var isFolder :Bool? = false
    var id   :String?
    var mode :String?
    
    
    init(dict :Dictionary<String,String>) {
        super.init()
        self.name = dict["name"]
        self.id = dict["id"]
        self.mode = dict["mode"]
        self.isFolder = dict["type"] == "tree" ? true : false
    }
}
