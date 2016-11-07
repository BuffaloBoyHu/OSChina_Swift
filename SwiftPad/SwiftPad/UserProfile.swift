//
//  UserProfile.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/5.
//  Copyright © 2016年 buffalo. All rights reserved.
//static NSString * const kKeyUserId = @"id";
//static NSString * const kKeyUsername = @"username";
//static NSString * const kKeyName = @"name";
//static NSString * const kKeyBio = @"bio";
//static NSString * const kKeyWeibo = @"weibo";
//static NSString * const kKeyBlog = @"blog";
//static NSString * const kKeyThemeId = @"theme_id";
//static NSString * const kKeyCreatedAt = @"created_at";
//static NSString * const kKeyState = @"state";
//static NSString * const kKeyPortrait = @"new_portrait";
//static NSString * const kKeyEmail = @"email";
//static NSString * const kKeyPrivateToken = @"private_token";
//static NSString * const kKeyAdmin = @"is_admin";
//static NSString * const kKeyCanCreateGroup = @"can_create_group";
//static NSString * const kKeyCanCreateProject = @"can_create_project";
//static NSString * const kKeyCanCreateTeam = @"can_create_team";
//static NSString * const kKeyFollow = @"follow";

import UIKit

class UserProfile: NSObject {
    var id :NSInteger?
    var userName :String?
    var name :String?
    var bio :String?
    var blog :String?
    var weibo :String?
    var themeID :NSInteger?
    var createdAt :String?
    var state :String?
    var portrait :String?
    var email :String?
    var privateToken :String?
    var isAdmin :Bool? = false
    var canCreateProject :Bool = false
    var canCreateGroup :Bool = false
    var canCreateTeam :Bool = false
    var follow :UserFollow?
    
    init(dict :Dictionary<String,Any>) {
        super.init()
        self.id = dict["id"] as? NSInteger
        self.userName = dict["username"] as? String
        self.name = dict["name"] as? String
        self.bio = dict["bio"] as? String
        self.weibo = dict["weibo"] as? String
        self.blog = dict["blog"] as? String
        self.themeID = dict["theme_id"] as? NSInteger
        self.createdAt = dict["created_at"] as? String
        self.state = dict["state"] as? String
        self.portrait = dict["new_portrait"] as? String
        self.email = dict["email"] as? String
        self.privateToken = dict["private_token"] as? String
        let isAdmin = dict["is_admin"] as? Bool
        self.isAdmin = isAdmin == nil ? false : isAdmin
        let canCreateGroup = dict["can_create_group"] as? Bool
        self.canCreateGroup = canCreateGroup == nil ? false : canCreateGroup!
        let canCreateProject = dict["can_create_project"] as? Bool
        self.canCreateProject = canCreateProject == nil ? false : canCreateProject!
        let canCreateTeam = dict["can_create_team"] as? Bool
        self.canCreateTeam = canCreateTeam == nil ? false : canCreateTeam!
        let followDict = dict["follow"] as? Dictionary<String,NSInteger>
        if followDict != nil {
            self.follow = UserFollow.init(dict: followDict!)
        }
    }
    
    override init() {
        super.init()
    }
    
    func saveUserProfile() {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(self.id, forKey: "User_ID")
        userDefaults.setValue(self.userName, forKey: "User_username")
        userDefaults.setValue(self.name, forKey: "User_name")
        userDefaults.setValue(self.bio, forKey: "User_bio")
        userDefaults.setValue(self.weibo, forKey: "User_weibo")
        userDefaults.setValue(self.blog, forKey: "User_blog")
        userDefaults.set(self.themeID, forKey: "User_themeid")
        userDefaults.setValue(self.createdAt, forKey: "User_createdat")
        userDefaults.setValue(self.state, forKey: "User_state")
        userDefaults.setValue(self.portrait, forKey: "User_portrait")
        userDefaults.setValue(self.email, forKey: "User_email")
        userDefaults.setValue(self.privateToken, forKey: "private_token")
        userDefaults.set(self.isAdmin, forKey: "User_isadmin")
        userDefaults.set(self.canCreateTeam, forKey: "User_cancreateteam")
        userDefaults.set(self.canCreateGroup, forKey: "User_cancreategroup")
        userDefaults.set(self.canCreateProject, forKey: "User_cancreateproject")
        userDefaults.set(self.follow?.followers, forKey: "User_followers")
        userDefaults.set(self.follow?.following, forKey: "User_following")
        userDefaults.set(self.follow?.starred, forKey: "User_starred")
        userDefaults.set(self.follow?.watched, forKey: "User_watched")
        userDefaults.synchronize()
    }
    
}
