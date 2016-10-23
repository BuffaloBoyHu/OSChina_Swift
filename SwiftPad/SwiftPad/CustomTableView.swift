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

class CustomTableView: UITableView,UITableViewDelegate {

    var tableName :String? = nil
    var dataArray :Array<Any>? = [Any]()
    
    // MARK: 构造函数
    init(cellReuseIndentifier :String) {
        self.tableName = cellReuseIndentifier
        super.init(frame: UIScreen.main.bounds, style: UITableViewStyle.plain);
        self.register(CustomTableViewCell.self, forCellReuseIdentifier: cellReuseIndentifier)
        self.addMjRefreshControl()
        self.isNeedRefresh(refresh: true)
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
        
        let requestType = self.tableRequestType(name: self.tableName!)
        let urlString = urlStrigOfType(type: requestType!, pageId: 1, privateToken: nil, userID: nil, languageID: nil, queryStr: nil)
        Alamofire.request(urlString).responseJSON { (response) in
            let tmpArray = response.result.value as? Array<Any>
//            self.dataArray! += tmpArray!
            for item in tmpArray! {
                let dict = item as? Dictionary<String,Any>
                let model = CustomModel.init(dict: dict!)
                self.dataArray?.append(model)
            }
            self.mj_header.endRefreshing()
            self.reloadData()
        }
        
    }
    
    func pullToLoadMore() {
        //上拉加载更多
    }
}
