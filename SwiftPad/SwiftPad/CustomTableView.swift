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

    init() {
        super.init(frame: UIScreen.main.bounds, style: UITableViewStyle.plain);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func addMjRefreshControl() {
        self.mj_header = MJRefreshHeader.init(refreshingTarget: self, refreshingAction: )
    }
}
