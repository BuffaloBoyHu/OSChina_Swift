//
//  ReadMeViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/30.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ReadMeViewController: UIViewController,UIWebViewDelegate {

    let webView :UIWebView = UIWebView.init()
    var model :CustomModel? = nil
    let hud :MBProgressHUD = MBProgressHUD.showAdded(to: UIApplication.shared.windows.last!, animated: true)
    var htmlStr :String?
    var isFinishedLoad :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = self.model?.name
        self.initView()
        self.fetchObject()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.view.addSubview(self.webView)
        
        self.webView.delegate = self
        self.webView.scrollView.bounces = false
        self.webView.isOpaque = false
        self.webView.backgroundColor = UIColor.clear
        self.webView.scalesPageToFit = false
        self.webView.isHidden  = true
        
        self.isFinishedLoad = false
        
        self.addConstaintForSubView()
    }
    
    func addConstaintForSubView() {
        unowned let weakSelf = self
        self.webView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(weakSelf.view)
            make.top.equalTo(weakSelf.view.snp.top).offset(64)
        }
    }
    
    func fetchObject() {
        self.hud.isUserInteractionEnabled = false
        unowned let weakSelf = self
        let urlStr = "\(GITAPI_HTTPS_PREFIX)\(GITAPI_PROJECTS)/\((self.model?.id)!)/readme?private_token=\(Tools.privateToken())"
        
        Alamofire.request(urlStr).responseJSON { (response) in
            if response.result.isSuccess {
                weakSelf.hud.hide(animated: true, afterDelay: 1)
                if response.result.value == nil {
                    weakSelf.webView.loadHTMLString("该项目暂无Readme文件", baseURL: nil)
                }else {
                    let dict = response.result.value as! Dictionary<String,Any>
                    let htmlStr = dict["content"] as? String
                    weakSelf.htmlStr = htmlStr
                    if htmlStr != nil {
                        weakSelf.webView.loadHTMLString(htmlStr!, baseURL: nil)
                    }else {
                        weakSelf.hud.show(animated: true)
                        weakSelf.hud.mode = .customView
                        weakSelf.hud.detailsLabel.text = "无ReadMe文件"
                        weakSelf.hud.hide(animated: true, afterDelay: 1)
                    }
                }
            }else {
                // 请求失败
                weakSelf.hud.mode = .customView
                if response.result.error != nil {
                    weakSelf.hud.detailsLabel.text = "网络异常，错误代码：\(response.result.error!)"
                }else {
                    weakSelf.hud.detailsLabel.text = "网络错误"
                }
                weakSelf.hud.hide(animated: true, afterDelay: 1)
            }
        }
        
    }
    
    //MARK: UIWebViewDelegate
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        if self.isFinishedLoad {
            webView.isHidden = false
            webView.isUserInteractionEnabled = true
            return;
        }
        let widthStr :String = webView.stringByEvaluatingJavaScript(from: "document.body.scrollWidth ")!
        let width = Int(widthStr)
        let newHtmlStr = self.adjustHtml(pageWidth: CGFloat(width!), htmlStr: self.htmlStr!, webView: webView)
        webView.loadHTMLString(newHtmlStr, baseURL: nil)
        self.isFinishedLoad = true
    }
    
    //MARK: tool
    func adjustHtml(pageWidth :CGFloat,htmlStr :String,webView:UIWebView) -> String {
        let scale :CGFloat = webView.frame.size.width / pageWidth
        let headerStr = "<meta name=\"viewport\" content=\" initial-scale=\(scale), minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\">"
        let newHtmlStr = "<html><head>\(headerStr)</head><body>\(htmlStr)</body></html>"
        return newHtmlStr
    }

}
