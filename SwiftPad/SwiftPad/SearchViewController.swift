//
//  SearchViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/7.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

let Cell_Identifier = "项目搜索"
class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    let searchBar = UISearchBar.init()
    let tableView :CustomTableView = CustomTableView.init(cellReuseIndentifier: Cell_Identifier, isDynamicType: false)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.tableView)
        self.view.backgroundColor = UITool.uniformColor()
        self.title = "项目搜索"
        
        self.searchBar.searchBarStyle = .prominent
        self.searchBar.showsCancelButton = true
        self.searchBar.placeholder = "搜索项目"
        self.searchBar.delegate = self
        self.searchBar.becomeFirstResponder()
        
        self.tableView.backgroundColor = UITool.uniformColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.addConstraintForSubView()
        
    }
    
    func addConstraintForSubView() {
        unowned let weakSelf = self
        self.searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.view.top).offset(64)
            make.left.right.equalTo(weakSelf.view)
            make.height.equalTo(50)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.searchBar.snp.bottom)
            make.left.right.bottom.equalTo(weakSelf.view)
        }
    }
    
    //MARK: tableView 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tableView.dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tmpTableView = tableView as! CustomTableView
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell_Identifier, for: indexPath) as! CustomTableViewCell
        let model = tmpTableView.dataArray?[indexPath.row] as? CustomModel
        cell.stuffCellWithModel(model: model!)
        cell.updateConstraintsForSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tmpTableView = tableView as! CustomTableView
        let model = tmpTableView.dataArray?[indexPath.row] as? CustomModel
        return (model?.rowHeight)! + 75
    }
    
    // MARK: 搜索条
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text?.isEmpty)! {
            return
        }
        searchBar.resignFirstResponder()
        let queryStr = searchBar.text
        self.tableView.queryStr = queryStr
        self.tableView.isNeedRefresh(refresh: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
