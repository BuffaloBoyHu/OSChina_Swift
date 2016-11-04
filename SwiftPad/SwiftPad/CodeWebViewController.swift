//
//  CodeWebViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/31.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class CodeWebViewController: UIViewController,UIWebViewDelegate{
    
    let webView :UIWebView = UIWebView()
    var projectIdStr :String? = nil
    var currentPath :String? = nil
    var fileName :String? = nil
    var nameSpace :String? = nil
    var contentStr :String? = nil
    init(projectId:String?,path:String?,fileName:String?,nameSpace:String?) {
        super.init(nibName: nil, bundle: nil)
        self.projectIdStr = projectId
        self.currentPath = path
        self.fileName = fileName
        self.nameSpace = nameSpace
        
        self.view.addSubview(self.webView)
        self.webView.frame = self.view.frame
        self.webView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.webView.scrollView.bounces = false
        self.webView.delegate = self
        self.webView.dataDetectorTypes = .all
        self.webView.scalesPageToFit = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchObject() {
        let progressHUD = MBProgressHUD.showAdded(to: UIApplication.shared.windows.last!, animated: true)
        progressHUD.isUserInteractionEnabled = true
        progressHUD.mode = .customView
        
        let urlStr = "\(GITAPI_HTTPS_PREFIX)\(GITAPI_PROJECTS)/\(self.projectIdStr!)/repository/files"

        let filePath = "\(self.currentPath!)\(self.fileName!)"
        let parameters = ["private_token" : Tools.privateToken(),
                          "ref"           : "master",
                          "file_path"     : filePath
                        ]
        
        unowned let weakSelf = self
        Alamofire.request(urlStr, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                progressHUD.hide(animated: true, afterDelay: 1)
                let dict = response.result.value as? Dictionary<String,Any>
                weakSelf.contentStr = dict?["content"] as? String
                self.renderWebView()
            }else {
                progressHUD.detailsLabel.text = "网络错误"
                progressHUD.hide(animated: true, afterDelay: 1)
            }
        }
        
    }
    
    func renderWebView() {
        let baseURL :URL = URL.init(fileURLWithPath: Bundle.main.bundlePath)
        let isLineNumbers = true //[[defaults valueForKey:kLineNumbersDefaultsKey] boolValue];
        let lang = self.fileName?.components(separatedBy: ".").last
        let theme = "github"
        let formatPath = Bundle.main.path(forResource: "code", ofType: "html")
        
        let highlightJSPath = Bundle.main.path(forResource: "highlight.pack", ofType: "js")
        let themeCSSPath = Bundle.main.path(forResource: theme, ofType: "css")
        let codeCSSPath = Bundle.main.path(forResource: "code", ofType: "css")
        let lineNums = isLineNumbers ? "true" : "false"
        var formate :String? = nil
        do {
            try formate = String.init(contentsOfFile: formatPath!)
        } catch  {
            
        }
        let escapeCode = Tools.escapeHTML(htmlStr: self.contentStr!)
        let contentHTML = String.init(format:formate! ,themeCSSPath!,codeCSSPath!,highlightJSPath!,lineNums,lang!,escapeCode)
        self.webView.loadHTMLString(contentHTML, baseURL: baseURL)
    }

}
