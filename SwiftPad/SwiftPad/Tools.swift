//
//  Tools.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/30.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import Foundation

class Tools: NSObject {
    
    class public func privateToken() -> String {
        let userDefaults = UserDefaults.standard
        var tokenStr :String? = userDefaults.value(forKey: "private_token") as? String
        if tokenStr == nil {
           tokenStr = ""
        }
        return tokenStr!
    }
    
    // MARK:  文件相关 
    class func fileNameSuffix(fileName :String) ->String {
        return (fileName.components(separatedBy: ".").last?.lowercased())!
    }
    
    class func codeFileSuffixes() -> Array<String> {
        let codeSuffixes = ["java","confg","ini","xml","json","txt","go",
                            "php","php3","php4","php5","js","css","html",
                            "properties","c","hpp","h","hh","cpp","cfg",
                            "rb","example","gitignore","project","classpath",
                            "mm","md","rst","vm","cl","py","pl","haml",
                            "erb","scss","bat","coffee","as","sh","m","pas",
                            "cs","groovy","scala","sql","bas","xml","vb",
                            "xsl","swift","ftl","yml","ru","jsp","markdown",
                            "cshap","apsx","sass","less","ftl","haml","log",
                            "tx","csproj","sln","clj","scm","xhml","xaml",
                            "lua","pch"]
        return codeSuffixes
    }
    
    class func sepecialFileName() ->Array<String> {
        let names = [ "LICENSE",  "README",  "readme",  "makefile",  "gemfile",
                       "gemfile.*",  "gemfile.lock",  "TODO",  "CHANGELOG"]
        return names
    }
    
    class public func isCodeFile(fileName :String) ->Bool {
        let fileSuffix = Tools.fileNameSuffix(fileName: fileName)
        
        if Tools.codeFileSuffixes().contains(fileSuffix) {
            return true
        }
        
        if Tools.sepecialFileName().contains(fileSuffix) {
            return true
        }
        
        return false
    }
    
    class func imageSuffixes() ->Array<String> {
        let imageSuffixes = [ "png",  "jpg",  "jpeg",  "jpe",  "bmp",  "exif",  "dxf",  "wbmp",  "ico",  "jpe",  "gif",  "pcx",  "fpx",  "ufo",
                              "tiff",  "svg",  "eps",  "ai",  "tga",  "pcd",  "hdri"]
        return imageSuffixes
    }
    
    class func isImageFile(fileName :String) ->Bool {
        let fileSuffix = Tools.fileNameSuffix(fileName: fileName)
        return Tools.imageSuffixes().contains(fileSuffix) ? true: false
        
    }
    
    class func escapeHTML(htmlStr :String) ->String {
        var resultStr = htmlStr as NSString
        let length :Int = resultStr.length
        resultStr.replacingOccurrences(of: "&", with: "&amp", options: .literal, range: NSRange.init(location: 0, length: length))
        resultStr.replacingOccurrences(of: "<", with: "&lt", options: .literal, range: NSRange.init(location: 0, length: length))
        resultStr.replacingOccurrences(of: ">", with: "&gt", options: .literal, range: NSRange.init(location: 0, length: length))
        resultStr.replacingOccurrences(of: "\"", with: "&quot", options: .literal, range: NSRange.init(location: 0, length: length))
        resultStr.replacingOccurrences(of: "'", with: "&#39", options: .literal, range: NSRange.init(location: 0, length: length))
        return String(resultStr)
        
    }
    
}
