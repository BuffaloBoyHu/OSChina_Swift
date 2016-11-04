//
//  UserProfileViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/3.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

let CellIdentifier = "CellIdentifier"

class UserProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let portaitCell :UITableViewCell = UITableViewCell.init()
    let tableView :UITableView = UITableView.init(frame: .zero, style: .grouped)
    let registerBtn :UIButton = UIButton.init()
    var model :CustomModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.view.addSubview(self.tableView)
        self.tableView.tableHeaderView = portaitCell
        self.tableView.tableFooterView = registerBtn
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        self.portaitCell.imageView?.image = #imageLiteral(resourceName: "portrait_loading")
        self.registerBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        
        self.addConstraintForSubView()
        
    }
    
    func addConstraintForSubView() {
        unowned let weakSelf = self
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(weakSelf.view)
            make.top.equalTo(weakSelf.view.snp.top).offset(64)
        }
    }
    //MARK: 注销
    func registerAction() {
        // todo
    }
    
    //MARK: tableview Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        let titles = indexPath.section == 0 ? ["Following:","Followers:","Starred:","Watched:"] : ["加入时间:","微博:","博客:"]
        // todo 
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // MARK: tableview Delegate
    
}
