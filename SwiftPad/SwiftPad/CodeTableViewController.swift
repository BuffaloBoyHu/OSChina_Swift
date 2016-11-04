//
//  CodeTableViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/31.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class CodeTableViewController: UITableViewController {

    var projectId :String? = nil
    var projectName :String? = nil
    var ownerName :String? = nil
    var nameSpace :String? = nil
    
    var dataArray  = [CodeModel]()
    var currentPath :String? = ""
    
    let ReusedIdentifier = "CodeCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = self.projectName
        self.tableView.register(DetailViewCell.self, forCellReuseIdentifier: ReusedIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UITool.uniformColor()
        self.tableView.separatorStyle = .none
        self.fetchObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusedIdentifier, for: indexPath) as! DetailViewCell

        cell.titleLabel?.text = self.dataArray[indexPath.row].name
        cell.iconImageView?.image = self.dataArray[indexPath.row].isFolder! ? #imageLiteral(resourceName: "folder") : #imageLiteral(resourceName: "file")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArray[indexPath.row]
        if model.isFolder! {
            let codeController  = CodeTableViewController()
            codeController.projectId = self.projectId
            codeController.projectName = model.name
            codeController.currentPath = "\(self.currentPath!)\(model.name!)/"
            codeController.nameSpace = self.nameSpace
            codeController.ownerName = self.ownerName
            self.navigationController?.pushViewController(codeController, animated: true)
        }else {
            self.showFile(model: model)
        }
    }
    
    // MARK: 获取数据
    func fetchObject() {
        unowned let weakSelf = self
        let privateToken = Tools.privateToken()
        let path = self.currentPath!
        let parameters :Dictionary<String,String> = ["private_token":privateToken,"ref_name":"master","path":path]
        
        
        let urlStr = "\(GITAPI_HTTPS_PREFIX)\(GITAPI_PROJECTS)/\(self.projectId!)/repository/tree"
        Alamofire.request(urlStr, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON  { (respone) in
            if respone.result.isSuccess {
                if respone.result.value == nil {
                    let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
                    progressHUD.mode = .customView
                    progressHUD.detailsLabel.text = "还没有相关文件"
                    progressHUD.hide(animated: true, afterDelay: 2)
                }else {
                    let tmpArray = respone.result.value as? Array<Dictionary<String,String>>
                    for dict in tmpArray!{
                        weakSelf.dataArray.append(CodeModel.init(dict: dict))
                    }
                    weakSelf.tableView.reloadData()
                }
                
            }else {
                let progressHud = MBProgressHUD.showAdded(to: self.view, animated: true)
                progressHud.mode = .customView
                progressHud.detailsLabel.text = "网络错误"
                progressHud.hide(animated: true, afterDelay: 2)
            }
        }
        
    }
    
    // MARK:打开文件
    func showFile(model :CodeModel) {
        let urlHeader = GITAPI_HTTPS_PREFIX.components(separatedBy: "/api/v3/").first
        if Tools.isCodeFile(fileName: model.name!) {
            let codeWebController = CodeWebViewController.init(projectId: self.projectId, path: self.currentPath, fileName: model.name!, nameSpace: self.nameSpace)
            self.navigationController?.pushViewController(codeWebController, animated: true)
        }else if Tools.isImageFile(fileName: model.name!) {
            // 显示图片
            let codeImageViewController = CodeImageViewController()
            let imageUrl = "\(urlHeader!)/\(self.ownerName!)/\(self.projectName!)/raw/master/\(self.currentPath!)\(model.name!)?private_token=\(Tools.privateToken())"
            codeImageViewController.imageUrl = imageUrl
            self.navigationController?.pushViewController(codeImageViewController, animated: true)
        }else {
            let urlStr = "\(urlHeader!)\(self.ownerName!)\(self.projectName!)/blob/master/\(self.currentPath!)\(model.name!)?private_token=\(Tools.privateToken())"
            UIApplication.shared.openURL(URL.init(string: urlStr)!)
        }
    }
}
