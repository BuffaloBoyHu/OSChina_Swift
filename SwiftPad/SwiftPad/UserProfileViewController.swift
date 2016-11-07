//
//  UserProfileViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/11/3.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

let CellIdentifier = "CellIdentifier"

class UserProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let portaitCell :UITableViewCell = UITableViewCell.init()
    let tableView :UITableView = UITableView.init(frame: .zero, style: .grouped)
    let registerBtn :UIButton = UIButton.init()
    var userProfile :UserProfile = UserProfile.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的资料"
        self.fetchObject()
        self.initView()
        self.view.backgroundColor = UITool.uniformColor()
        self.tableView.backgroundColor = UITool.uniformColor()
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.view.addSubview(self.tableView)
        self.tableView.tableHeaderView = portaitCell
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        
        self.portaitCell.imageView?.image = #imageLiteral(resourceName: "portrait_loading")
        self.portaitCell.imageView?.layer.cornerRadius = 5
        self.portaitCell.imageView?.layer.masksToBounds = true
        Alamofire.request(self.userProfile.portrait!).responseImage { (response) in
            if response.result.isSuccess {
                self.portaitCell.imageView?.image = response.result.value
            }
        }
        self.portaitCell.textLabel?.text = self.userProfile.name
        
        self.registerBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        self.registerBtn.backgroundColor = UIColor.red
        self.registerBtn.setTitle("注销登录", for: .normal)
        self.registerBtn.setTitleColor(UIColor.white, for: .normal)
        
        self.addConstraintForSubView()
        
    }
    
    func addConstraintForSubView() {
        unowned let weakSelf = self
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(weakSelf.view)
            make.top.equalTo(weakSelf.view.snp.top).offset(64)
        }
    }
    
    func fetchObject() {
        let userDefaults = UserDefaults.standard
        self.userProfile.id  = userDefaults.value(forKey: "User_ID") as? NSInteger
        self.userProfile.userName = userDefaults.value(forKey: "User_username") as? String
        self.userProfile.name =  userDefaults.value(forKey: "User_name") as? String
        self.userProfile.bio =  userDefaults.value(forKey: "User_bio") as? String
        self.userProfile.weibo =  userDefaults.value(forKey: "User_weibo") as? String
        self.userProfile.blog =   userDefaults.value(forKey: "User_blog") as? String
        self.userProfile.themeID = userDefaults.integer(forKey: "User_themeid")
        self.userProfile.createdAt = userDefaults.value(forKey: "User_createdat") as? String
        self.userProfile.state =  userDefaults.value(forKey: "User_state") as? String
        self.userProfile.portrait =   userDefaults.value(forKey: "User_portrait") as? String
        self.userProfile.email =   userDefaults.value(forKey: "User_email") as? String
        self.userProfile.privateToken =   userDefaults.value(forKey: "private_token") as? String
        self.userProfile.isAdmin =  userDefaults.bool(forKey: "User_isadmin")
        self.userProfile.canCreateTeam = userDefaults.bool(forKey: "User_cancreateteam")
        self.userProfile.canCreateGroup = userDefaults.bool(forKey: "User_cancreategroup")
        self.userProfile.canCreateProject = userDefaults.bool(forKey: "User_cancreateproject")
        self.userProfile.follow?.followers = userDefaults.integer(forKey: "User_followers")
        self.userProfile.follow?.following = userDefaults.integer(forKey: "User_following")
        self.userProfile.follow?.starred = userDefaults.integer(forKey: "User_starred")
        self.userProfile.follow?.watched = userDefaults.integer(forKey: "User_watched")
    }
    
    //MARK: 注销
    func registerAction() {
        // todo
        let uerDefaults = UserDefaults.standard
        uerDefaults.set("", forKey: "private_token")
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popViewController(animated: true)
        
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
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let following = self.userProfile.follow?.following == nil ? 0 : (self.userProfile.follow?.following)!
                cell?.textLabel?.text = "\(titles[0])\(following)"
            case 1:
                let followers = self.userProfile.follow?.followers == nil ? 0 : (self.userProfile.follow?.followers)!
                cell?.textLabel?.text = "\(titles[1])\(followers)"
            case 2:
                let starred = self.userProfile.follow?.starred == nil ? 0 : (self.userProfile.follow?.starred)!
                cell?.textLabel?.text = "\(titles[2])\(starred)"
            default:
                let watched = self.userProfile.follow?.watched == nil ? 0 : (self.userProfile.follow?.watched)!
                cell?.textLabel?.text = "\(titles[3])\(watched)"
            }
        }else {
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "\(titles[0])\((self.userProfile.createdAt)!)"
            case 1:
                let weibo = self.userProfile.weibo == nil ? "" : (self.userProfile.weibo)!
                cell?.textLabel?.text = "\(titles[1])\(weibo)"
            default:
                let blog = self.userProfile.blog == nil ? "" : (self.userProfile.blog)!
                cell?.textLabel?.text = "\(titles[2])\(blog)"
            }
        }
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // MARK: tableview Delegate
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return self.registerBtn
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
}
