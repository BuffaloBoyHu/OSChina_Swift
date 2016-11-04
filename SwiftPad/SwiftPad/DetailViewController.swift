//
//  DetailViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/23.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import MBProgressHUD

private let reuseIdentifier = "Cell"

class DetailViewController: UITableViewController {

    var model :CustomModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "projectDetails_more"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(shareAction))
        
        self.tableView.register(DetailViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.lightGray
        self.tableView.autoresizingMask = .flexibleWidth
        self.tableView.separatorStyle = .none
        self.title = model?.owner?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  分享
    func shareAction() {
        unowned let weakSelf = self
        let alertController :UIAlertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.sourceView = self.navigationController?.navigationBar
        let originY = self.navigationController?.navigationBar.frame.size.height
        let orientation = UIApplication.shared.statusBarOrientation
        let originX = (orientation == .portrait || orientation == .portraitUpsideDown) ? (self.view.frame.size.width - 40):(self.view.frame.size.width - 35)
        alertController.popoverPresentationController?.sourceRect = CGRect.init(origin: CGPoint.init(x: originX, y: originY!), size: .zero)
        
        alertController.addAction(UIAlertAction.init(title: "分享项目", style: .default, handler: { (action) in
            weakSelf.showShareView()
            
        }))
        alertController.addAction(UIAlertAction.init(title: "复制链接", style: .default, handler: { (action) in
            
            let pastedBoard :UIPasteboard = UIPasteboard.general
            let httpStr = GITAPI_HTTPS_PREFIX.components(separatedBy: "/api/v3/").first
            let projectURL = "\(httpStr!)/\((self.model?.owner?.userName)!)/\((self.model?.path)!)"
            pastedBoard.string = projectURL
            
            // 显示toast 
            let progressHUD = MBProgressHUD.showAdded(to: self.tableView, animated: true)
            progressHUD.mode = .text
            progressHUD.label.text = "链接已复制到剪贴板"
            progressHUD.removeFromSuperViewOnHide = true
            progressHUD.hide(animated: true, afterDelay: 2.0)
            
        }))
        alertController.addAction(UIAlertAction.init(title: "在浏览器中打开", style: .default, handler: { (action) in
            let httpStr = GITAPI_HTTPS_PREFIX.components(separatedBy: "/api/v3/").first
            let projectURL = "\(httpStr!)/\((self.model?.owner?.userName)!)/\((self.model?.path)!)"
            UIApplication.shared.openURL(URL.init(string: projectURL)!)
            
        }))
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
            
        }))
        self.present(alertController, animated: true) {
            
        }
    }
    
    func showShareView() {
        // toDo 添加友盟支持
        let httpStr = GITAPI_HTTPS_PREFIX.components(separatedBy: "/api/v3/").first
        let projectURL = "\(httpStr!)/\((self.model?.owner?.userName)!)/\((self.model?.path)!)"
        // 微信设置
        UMSocialData.default().extConfig.wxMessageType = UMSocialWXMessageTypeWeb
        UMSocialData.default().extConfig.wechatSessionData.url = projectURL
        UMSocialData.default().extConfig.wechatTimelineData.url = projectURL
        UMSocialData.default().extConfig.title = self.model?.name
        
        // qq设置
        UMSocialData.default().extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault
        UMSocialData.default().extConfig.qqData.title = self.model?.name
        UMSocialData.default().extConfig.qqData.url = "\(httpStr!)/\((self.model?.owner?.userName)!)/\((self.model?.path)!)"
        
        // 新浪
        UMSocialData.default().extConfig.sinaData.urlResource.setResourceType(UMSocialUrlResourceTypeDefault, url: "\(httpStr!)/\((self.model?.owner?.userName)!)/\((self.model?.path)!)")
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "5423cd47fd98c58f04000c52", shareText: "我在关注\((self.model?.owner?.name)!)的项目\((self.model?.name)!)，你也来瞧瞧呗！\(projectURL)", shareImage: nil, shareToSnsNames: [UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina], delegate: nil)
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        }
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = DetailProfileCell_Title.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
                cell.stuffCellWithModel(model: self.model!)
                return cell
            }else {
                let cell = DetailProfileCell_Content.init(style: .default, reuseIdentifier: nil)
                cell.stuffCellWithModel(model: self.model!)
                return cell
            }
        case 1:
            let cell = DetailStateCell.init(style: .default, reuseIdentifier: nil)
            cell.stuffCellWithModel(model: self.model!)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DetailViewCell
            let imageArray = [#imageLiteral(resourceName: "projectDetails_owner"),#imageLiteral(resourceName: "projectDetails_readme"),#imageLiteral(resourceName: "projectDetails_code"),#imageLiteral(resourceName: "projectDetails_issue"),#imageLiteral(resourceName: "projectDetails_branch")]
            let names = ["拥有者","Readme","代码","问题","提交"]
            if indexPath.row == 0 {
                let attribureStr = NSMutableAttributedString.init(string: names[indexPath.row])
                attribureStr.setAttributes([NSForegroundColorAttributeName:UIColor.gray])
                let nameAttributeStr = NSAttributedString.init(string: (self.model?.owner?.name)!)
                attribureStr.append(nameAttributeStr)
                cell.titleLabel?.attributedText = attribureStr
            }else {
                cell.titleLabel?.text = names[indexPath.row]
            }
            cell.iconImageView?.image = imageArray[indexPath.row]
            return cell
        }
        
    }

    // MARK: Tableview Delegate 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return indexPath.row == 0 ? 85 : 100 + (self.model?.rowHeight)!
        case 1:
            return 80
        case 2:
            return 44
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 20
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 {
            if indexPath.row == 1 {
                let readMeController = ReadMeViewController()
                readMeController.model = self.model
                self.navigationController?.pushViewController(readMeController, animated: true)
            }else if indexPath.row == 2 {
                let codeController = CodeTableViewController()
                codeController.projectId = "\((self.model?.id)!)"
                codeController.ownerName = self.model?.owner?.userName
                codeController.currentPath = ""
                codeController.nameSpace = self.model?.path_with_namespace
                codeController.projectName = self.model?.name
                codeController.view.backgroundColor = UIColor.white
                self.navigationController?.pushViewController(codeController, animated: true)
            }
        }
    }

    //MARK:  旋转
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portraitUpsideDown
    }
    override var shouldAutorotate: Bool {
        return false
    }
}
