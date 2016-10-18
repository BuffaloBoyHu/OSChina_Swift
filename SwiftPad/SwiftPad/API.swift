//
//  API.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/18.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import Foundation

public enum RequestType :Int {
    case Featured = 0,popular,Latest,EventForUser,Stared,Watched,Language,Search,Projects
}

let GITAPI_HTTPS_PREFIX = "https://git.oschina.net/api/v3/"
let GITAPI_PROJECTS = "projects"
let GITAPI_USER = "user"
let GITAPI_EVENTS = "events"
let GITAPI_LANGUAGE = "languages"

// 数据请求字符串
public func urlStrigOfType(type :RequestType,pageId :Int,privateToken:String?,userID:Int64?,languageID:Int?,queryStr:String?) ->String {
    var urlString = GITAPI_HTTPS_PREFIX
    switch type {
    case .Featured:// 推荐
        urlString += GITAPI_PROJECTS
        urlString += "/featured"
    case .popular: //热门
        urlString += GITAPI_PROJECTS
        urlString += "/popular"
    case .Latest: // 最近
        urlString += GITAPI_HTTPS_PREFIX
        urlString += "/latest"
    case .Stared: // star
        urlString += GITAPI_USER + "/"
        urlString += String.init(describing: userID)
        urlString += "/stared_projects"
    case .Watched: // watch
        urlString += GITAPI_USER + "/"
        urlString += String.init(describing: userID)
        urlString += "/watched_projects"
    case .Projects:// 项目
        if privateToken?.characters.count != 0 {
            urlString += GITAPI_PROJECTS + "?private_token="
            urlString += privateToken! + "&"
        }else {
            urlString += GITAPI_USER + "/"
            urlString += String.init(describing: userID) + "/"
            urlString += GITAPI_PROJECTS + "?"
        }
    case .Language:
        urlString += GITAPI_PROJECTS
        urlString += "/languages/"
        urlString += String.init(describing: languageID) + "?"
    case .Search:
        urlString += GITAPI_PROJECTS
        urlString += "/search/"
        urlString += queryStr!
        urlString += "?private_token="
        urlString += privateToken! + "&"
    case .EventForUser:
        urlString += GITAPI_EVENTS + "/"
        urlString += GITAPI_USER + "/"
        urlString += String.init(describing: userID) + "?"
    }
    urlString += String.init(describing: pageId)
    return urlString;
}





		
