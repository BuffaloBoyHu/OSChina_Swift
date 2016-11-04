//
//  SetUpViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/3.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class SetUpViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UITool.uniformColor()
        self.view.backgroundColor = UITool.uniformColor()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let titles = ["摇一摇","清除缓存","意见反馈","关于"];
        cell.textLabel?.text = titles[indexPath.row]
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
        switch indexPath.row {
        case 0:
            // 摇一摇
            let shakingViewController = ShakingViewController()
            self.navigationController?.pushViewController(shakingViewController, animated: true)
        case 1:
            // 清除缓存
            let alertController = UIAlertController.init(title: "确定清除缓存？", message: nil, preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        case 2:
            // 意见反馈
            break
        default:
            // 关于
            break
        }
    }

}
