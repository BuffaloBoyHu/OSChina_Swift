//
//  SetUpViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/3.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

let CELL_Identifier = "SETUPCELL"

class SetUpViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        self.tableView.backgroundColor = UITool.uniformColor()
        self.view.backgroundColor = UITool.uniformColor()
        self.tableView.register(DetailViewCell.self, forCellReuseIdentifier: CELL_Identifier)
        self.tableView.separatorStyle = .none

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_Identifier, for: indexPath) as! DetailViewCell
        let titles = ["摇一摇","清除缓存","意见反馈","关于"];
        let row = indexPath.section == 0 ? indexPath.row : indexPath.row + 1
        cell.titleLabel?.text = titles[row]
        return cell
    }
    
    
    // MARK: delegate
    override  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let shakingViewController = ShakingViewController()
            self.navigationController?.pushViewController(shakingViewController, animated: true)
        }else{
            switch indexPath.row {
            case 0:
                // 清除缓存
                let alertController = UIAlertController.init(title: "确定清除缓存？", message: nil, preferredStyle: .alert)
                let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
                    
                })
                let sureAction = UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
                    
                })
                alertController.addAction(cancelAction)
                alertController.addAction(sureAction)
                self.present(alertController, animated: true, completion: nil)
            case 1:
                // 意见反馈
                break
            default:
                // 关于
                break
            }
        }

    }

}
