//
//  CustomTableView.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/17.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import YYKit
import MBProgressHUD

class CustomTableView: UITableView,UITableViewDelegate {

    var tableName :String? = nil
    var dataArray :Array<Any>? = [Any]()
    var page :NSInteger = 1
    var isDynamicType :Bool = false //  标示是否是“我的“ 栏目里面的动态
    var userID :Int64? = Tools.userID()
    var languageID :Int? = 0
    var privateToken :String? = Tools.privateToken()
    var queryStr :String? = nil
    // MARK: 构造函数
    init(cellReuseIndentifier :String,isDynamicType :Bool) {
        self.tableName = cellReuseIndentifier
        self.isDynamicType = isDynamicType
        super.init(frame: UIScreen.main.bounds, style: UITableViewStyle.plain);
        if isDynamicType {
            self.register(DynamicTableViewCell.self, forCellReuseIdentifier: cellReuseIndentifier)
        }else {
            self.register(CustomTableViewCell.self, forCellReuseIdentifier: cellReuseIndentifier)
        }
        
        self.addMjRefreshControl()
        self.isNeedRefresh(refresh: true)
        let footLabel = UILabel.init(frame: CGRect.init(origin: .zero, size: .init(width: 300, height: 100)))
        footLabel.backgroundColor = UIColor.clear
        footLabel.textColor = UIColor.darkText
        footLabel.text = "已全部加载完毕"
        footLabel.textAlignment = .center
        self.tableFooterView = footLabel
        self.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: 添加刷新控件
    func addMjRefreshControl() {
        self.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(pullToRefresh))
        self.mj_footer = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(pullToLoadMore))
    }
    
    open func isNeedRefresh(refresh :Bool) {
        if refresh {
            self.mj_header.beginRefreshing()
        }else {
            self.mj_header.endRefreshing()
        }
    }
    
    // MARK: 数据处理
    // 根据 tableName 转换为请求类型
    func tableRequestType(name :String) -> RequestType? {
        switch name {
        case "推荐":
            return  RequestType.Featured
        case "热门":
            return RequestType.popular
        case "最近更新":
            return RequestType.Latest
        case "动态":
            return RequestType.EventForUser
        case "项目":
            return RequestType.Projects
        case "Star":
            return RequestType.Stared
        case "Watch":
            return RequestType.Watched
        default:
            return nil
        }
    }
    
    func pullToRefresh()  {
        // 下拉刷新
        unowned let weakSelf = self
        let progressHUD = MBProgressHUD.showAdded(to: UIApplication.shared.windows.last!, animated: true)
        progressHUD.mode = .customView
        progressHUD.isUserInteractionEnabled = false
        self.page = 1
        self.dataArray?.removeAll()
        let requestType = self.tableRequestType(name: self.tableName!)
        var urlString = urlStrigOfType(type: requestType!, pageId: self.page, privateToken: self.privateToken, userID: self.userID, languageID: self.languageID, queryStr: self.queryStr)
        
        if self.isDynamicType {
            if Tools.privateToken() != "" {
                urlString = "\(GITAPI_HTTPS_PREFIX)\(GITAPI_EVENTS)?private_token=\(Tools.privateToken())&page=\(self.page)"
            }else {
                urlString = "\(GITAPI_HTTPS_PREFIX)\(GITAPI_EVENTS)/user/\(self.userID!)?page=\(self.page)"
            }
        }
        Alamofire.request(urlString).responseJSON { (response) in
            if response.result.isSuccess {
                if let tmpArray = response.result.value as? Array<Any> {
                    weakSelf.dataArray?.removeAll()
                    for item in tmpArray {
                        let dict = item as? Dictionary<String,Any>
                        if weakSelf.isDynamicType {
                            let model = DynamicModel.init(dict: dict!)
                            weakSelf.dataArray?.append(model)
                        }else {
                            let model = CustomModel.init(dict: dict!)
                            weakSelf.dataArray?.append(model)
                        }
                        
                    }
                    progressHUD.hide(animated: true)
                    weakSelf.mj_header.endRefreshing()
                    weakSelf.reloadData()
                    weakSelf.scrollToTop()
                }
            }else {
                progressHUD.label.text = "刷新失败"
                progressHUD.detailsLabel.text = "请检查网络是否可用"
                progressHUD.hide(animated: true, afterDelay: 3)
            }
        }
        
    }
    
    func pullToLoadMore() {
        //上拉加载更多
        unowned let weakSelf = self
        let progressHUD = MBProgressHUD.showAdded(to: UIApplication.shared.windows.last!, animated: true)
        progressHUD.mode = .customView
        progressHUD.isUserInteractionEnabled = false
        self.page += 1
        let requestType = self.tableRequestType(name: self.tableName!)
        let urlString = urlStrigOfType(type: requestType!, pageId: self.page, privateToken: self.privateToken, userID: self.userID, languageID: self.languageID, queryStr: self.queryStr)
        Alamofire.request(urlString).responseJSON { (response) in
            if response.result.isSuccess {
                if let tmpArray = response.result.value as? Array<Any> {
                    for item in tmpArray {
                        let dict = item as? Dictionary<String,Any>
                        if weakSelf.isDynamicType {
                            let model = DynamicModel.init(dict: dict!)
                            weakSelf.dataArray?.append(model)
                        }else {
                            let model = CustomModel.init(dict: dict!)
                            weakSelf.dataArray?.append(model)
                        }
                        
                    }
                    weakSelf.mj_header.endRefreshing()
                    weakSelf.reloadData()
                    weakSelf.scrollToTop()
                    progressHUD.hide(animated: true)
                }else{
                    progressHUD.label.text = "加载更多失败"
                    progressHUD.detailsLabel.text = "请检查网络是否可用"
                    progressHUD.hide(animated: true, afterDelay: 3)
                }
                
            }else{
                progressHUD.label.text = "加载失败"
                progressHUD.detailsLabel.text = "请检查网络是否可用"
                progressHUD.hide(animated: true, afterDelay: 3)
            }
        }
        
    }
}
