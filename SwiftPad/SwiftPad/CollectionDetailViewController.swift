//
//  CollectionDetailViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/7.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

let Cell_ID = "Collection_CELL"

class CollectionDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var languageID :Int? = 0
    let tableView :CustomTableView = CustomTableView.init(cellReuseIndentifier: Cell_ID, isDynamicType: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.view.addSubview(self.tableView)
        self.view.backgroundColor = UITool.uniformColor()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UITool.uniformColor()
        self.tableView.languageID = self.languageID
        self.tableView.isNeedRefresh(refresh: true)
        unowned let weakSelf = self
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(weakSelf.view)
        }
    }
    
    // MARK: tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tmpTableView = tableView as! CustomTableView
        return (tmpTableView.dataArray?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tmpTableView = tableView as! CustomTableView
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell_ID, for: indexPath) as! CustomTableViewCell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tmpTableView = tableView as! CustomTableView
        let detailController = DetailViewController()
        detailController.model = tmpTableView.dataArray?[indexPath.row] as? CustomModel
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
