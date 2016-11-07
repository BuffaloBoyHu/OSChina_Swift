//
//  DynamicModel.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/5.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

let kKeyId = "id";
let kKeyTargetType = "target_type";
let kKeyTargetId = "target_id";
let kKeyTitle = "title";
let kKeyData = "data";
let kKeyProjectId = "project_id";
let kKeyCreatedAt = "created_at";
let kKeyUpdatedAt = "updated_at";
let kKeyAction = "action";
let kKeyAuthorId = "author_id";
let kKeyPublic = "public";
let kKeyProject = "project";
let kKeyAuthor = "author";
let kKeyEvents = "events";
let kKeyNote = "note";
let kKeyIssue = "issue";
let kKeyIId = "iid";
let kKeyPullRequest = "pull_request";
let kKeyRef = "ref";
let kKeyCommits = "commits";
let kKeyTotalCommitCount = "total_commits_count";

enum ActionType : Int {
    case CREATED = 1, UPDATED, CLOSED, REOPENED, PUSHED, COMMENTED, MERGED, JOINED, LEFT, FORKED = 11
}

class DynamicModel: NSObject {
    
    var dynamicID :Int64?
    var targetType :String?
    var targetID :Int64?
    var title :String?
    var data :NSDictionary?
    var projectID :Int64?
    var createdAt :String?
    var updatedAt :String?
    var action :Int?
    var authorID :Int64?
    var isPublic :Bool?
    var customModel :CustomModel?
    var userProfile :UserProfile?
    var events :NSDictionary?
    
    init(dict :Dictionary<String,Any>) {
        super.init()
        self.dynamicID = dict[kKeyId] as? Int64
        self.targetID = dict[kKeyTargetId] as? Int64
        self.targetType = dict[kKeyTargetType] as? String
        self.title = dict[kKeyTitle] as? String
        self.data = dict[kKeyData] as? NSDictionary
        self.projectID = dict[kKeyProjectId] as? Int64
        self.createdAt = dict[kKeyCreatedAt] as? String
        self.updatedAt = dict[kKeyUpdatedAt] as? String
        self.action = dict[kKeyAction] as? Int
        self.authorID = dict[kKeyAuthorId] as? Int64
        self.isPublic = dict[kKeyPublic] as? Bool
        let customDict = dict[kKeyProject] as? Dictionary<String,Any>
        if customDict != nil {
            self.customModel = CustomModel.init(dict: customDict!)
        }
        let userDict = dict[kKeyAuthor] as? Dictionary<String,Any>
        if userDict != nil {
            self.userProfile = UserProfile.init(dict: userDict!)
        }
        self.events = dict[kKeyEvents] as? NSDictionary
    }

    
    func dynamicAttributeDescriptionStr() -> NSAttributedString {
        let authorFont = UIFont.init(name: "Arial-BoldMT", size: 15)
        let authorStrColor = UIColor.init(red: 14 / 255.0, green: 89 / 255.0, blue: 134 / 255.0, alpha: 1)
        let authorStrAttributes = [NSFontAttributeName : authorFont,NSForegroundColorAttributeName:authorStrColor]
        var eventStr :NSMutableAttributedString = NSMutableAttributedString.init(string: (self.userProfile?.name)!, attributes: authorStrAttributes)
        
        let actionFontColor = UIColor.init(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1)
        let actionAttributes = [NSFontAttributeName :UIFont.systemFont(ofSize: 15),NSForegroundColorAttributeName:actionFontColor]
        
        let projectFont = UIFont.systemFont(ofSize: 15)
        let projectFontColor = UIColor.init(red: 13 / 255.0, green: 109 / 255.0, blue: 168 / 255.0, alpha: 1)
        let projectAttribute = [NSForegroundColorAttributeName:projectFontColor,NSFontAttributeName:projectFont]
        let projectStr :NSMutableAttributedString = NSMutableAttributedString.init(string: "\((self.customModel?.owner?.name)!) / \((self.customModel?.name)!)", attributes: projectAttribute)
        
        
        var actionStr :NSMutableAttributedString?
        switch self.action! {
        case 1:
            actionStr = NSMutableAttributedString.init(string: " 在项目  创建了 ", attributes: actionAttributes)
            actionStr?.insert(projectStr, at: 5)
            actionStr?.append(NSAttributedString.init(string: self.eventTitle(), attributes: projectAttribute))
        case 2:
            actionStr = NSMutableAttributedString.init(string: " 更新了项目 ", attributes: actionAttributes)
            actionStr?.append(projectStr)
        case 3:
            actionStr = NSMutableAttributedString.init(string: " 关闭了项目  的 ", attributes: actionAttributes)
            actionStr?.insert(projectStr, at: 7)
            actionStr?.append(NSAttributedString.init(string: self.eventTitle(), attributes: projectAttribute))
        case 4:
            actionStr = NSMutableAttributedString.init(string: " 重新打开了项目  的 ", attributes: actionAttributes)
            actionStr?.insert(projectStr, at: 9)
            actionStr?.append(.init(string: self.eventTitle(), attributes: projectAttribute))
        case 5:
            actionStr = NSMutableAttributedString.init(string: " 推送到了项目  的分支", attributes: actionAttributes)
            actionStr?.insert(projectStr, at: 8)
            let tmpStr = self.data?.value(forKey: "ref") as? NSString
            let lastPath = tmpStr?.lastPathComponent
            actionStr?.insert(.init(string: lastPath!, attributes: projectAttribute), at: (actionStr?.length)! - 2)
        case 6:
            actionStr = NSMutableAttributedString.init(string: " 评论了项目  的 ", attributes: actionAttributes)
            actionStr?.insert(projectStr, at: 7)
            actionStr?.append(.init(string: self.eventTitle(), attributes: projectAttribute))
        case 8:
            actionStr = NSMutableAttributedString.init(string: " 接受了项目  的 ", attributes: actionAttributes)
            actionStr?.insert(projectStr, at: 7)
            actionStr?.append(.init(string: self.eventTitle(), attributes: projectAttribute))
        case 9:
            actionStr = NSMutableAttributedString.init(string: " 加入了项目 ", attributes: actionAttributes)
            actionStr?.append(projectStr)
        case 10:
            actionStr = NSMutableAttributedString.init(string: " 离开了项目 ", attributes: actionAttributes)
            actionStr?.append(projectStr)
        case 11:
            actionStr = NSMutableAttributedString.init(string: " Fork了项目 ", attributes: actionAttributes)
            actionStr?.append(projectStr)
        default:
            actionStr = NSMutableAttributedString.init(string: " 更新了动态", attributes: actionAttributes)
        }
        eventStr.append(actionStr!)
        return eventStr
    }
    
    func eventTitle() -> String {
        var eventTitle :String = ""
        let pullDict = self.events?.value(forKey: "pull_request") as? Dictionary<String,Any>
        let issueDict = self.events?.value(forKey: "issue") as? Dictionary<String,Any>
        if pullDict != nil && (pullDict?.count)! > 0 {
            let string = pullDict?["iid"] as? String
            eventTitle = "Pull Request #\(string!)"
        }else if issueDict != nil && (issueDict?.count)! > 0 {
            let string = issueDict?["iid"] as? String
            eventTitle = "Issue #\(string!)"
        }
        
        return eventTitle
    }
}
