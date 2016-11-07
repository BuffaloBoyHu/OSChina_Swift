//
//  CustomModel.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/22.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class CustomModel: NSObject {
    
    var id :NSInteger?
    var name :String?
    var descriptionStr :String?
    var default_branch :String?
    var owner :Owner?
    var publicBool :Bool?
    var path :String?
    var path_with_namespace :String?
    var issues_enabled :Bool?
    var created_at :String?
    var namespace :NameSpace?
    var last_push_at :String?
    var parent_id :NSInteger?
    var fork :Bool?
    var forks_count :NSInteger?
    var stars_count :NSInteger?
    var watches_count :NSInteger?
    var language :String?
    var paas :String?
    var stared :Bool?
    var watched :Bool?
    var relation :String?
    var recomm :NSInteger?
    var parent_path_with_namespace :String?
    var rowHeight :CGFloat = 0
    
    init(dict : Dictionary<String,Any>) {
        super.init()
        
        self.id = dict["id"] as? NSInteger
        if self.id == nil {
            self.id = 0
        }
        self.name = dict["name"] as? String
        if self.name == nil {
            self.name = ""
        }
        self.descriptionStr = dict["description"] as? String
        if self.descriptionStr == nil {
            self.descriptionStr = ""
        }
        self.owner = Owner.init(dict: (dict["owner"] as? Dictionary<String,Any>)!)
        self.publicBool = dict["public"] as? Bool
        if self.publicBool == nil {
            self.publicBool = false
        }
        self.path = dict["path"] as? String
        self.path_with_namespace = dict["path_with_namespace"] as? String
        self.issues_enabled = dict["issues_enabled"] as? Bool
        self.created_at = dict["created_at"] as? String
        self.namespace = dict["namespace"] as? NameSpace
        self.last_push_at = dict["last_push_at"] as? String
        self.parent_id = dict["parent_id"] as? NSInteger
        self.fork = dict["fork?"] as? Bool
        self.forks_count = dict["forks_count"] as? NSInteger
        self.stars_count = dict["stars_count"] as? NSInteger
        self.watches_count = dict["watches_count"] as? NSInteger
        self.language = dict["language"] as? String
        self.paas = dict["pass"] as? String
        let label = UILabel.init()
        label.text = self.descriptionStr
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        let size = label.sizeThatFits(CGSize.init(width: UIScreen.main.bounds.width - 80, height: CGFloat.infinity))
        self.rowHeight += size.height
        // 待续
        self.stared = dict["stared"] as? Bool
        self.watched = dict["watched"] as? Bool
        if self.stared == nil {
            self.stared = false
        }
        if self.watched == nil {
            self.watched = false
        }
    }
    
}
