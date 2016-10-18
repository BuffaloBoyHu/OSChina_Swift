//
//  CustomTableView.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/17.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import MJRefresh

class CustomTableView: UITableView {

    var tableName :String? = nil
    
    // MARK: 构造函数
    init(cellReuseIndentifier :String) {
        self.tableName = cellReuseIndentifier
        super.init(frame: UIScreen.main.bounds, style: UITableViewStyle.plain);
        self.addMjRefreshControl(needRefresh: true)
        self.register(CustomTableViewCell.self, forCellReuseIdentifier: cellReuseIndentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: 添加刷新控件
    func addMjRefreshControl(needRefresh :Bool) {
        self.mj_header = MJRefreshHeader.init(refreshingTarget: self, refreshingAction: #selector(CustomTableView.pullToRefresh))
        self.mj_footer = MJRefreshFooter.init(refreshingTarget: self, refreshingAction: #selector(CustomTableView.pullToLoadMore))
        if needRefresh {
            self.mj_header.beginRefreshing()
        }
    }
    
    func pullToRefresh()  {
        // 下拉刷新
        
    }
    
    func pullToLoadMore() {
        //上拉加载更多
    }
}
