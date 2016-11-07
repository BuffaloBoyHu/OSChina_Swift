//
//  APPTabbarController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/17.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class APPTabbarController: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.title = self.selectedViewController?.title
        self.delegate = self
        
    }
    
    func initViews() {
        let projectsController = CustomViewController.init(title: "项目", subTitles: ["推荐","热门","最近更新"])
        let mineController = CustomViewController.init(title: "我的", subTitles: ["动态","项目","Star","Watch"])
        let findController  :CustomCollectionController = CustomCollectionController.init()
        projectsController.tabBarItem.image = #imageLiteral(resourceName: "projects")
        projectsController.tabBarItem.selectedImage = #imageLiteral(resourceName: "projects_selected")
        projectsController.type = ProjectType.Projects
        mineController.tabBarItem.image = #imageLiteral(resourceName: "mine")
        mineController.tabBarItem.selectedImage = #imageLiteral(resourceName: "mine_selected")
        mineController.type = ProjectType.Mine
        findController.tabBarItem.image = #imageLiteral(resourceName: "discover")
        findController.tabBarItem.selectedImage = #imageLiteral(resourceName: "discover_selected")
        findController.title = "发现"
        
        let projectsNavController = UINavigationController.init(rootViewController: projectsController)
        let findNavController = UINavigationController.init(rootViewController: findController)
        let mineNavController = UINavigationController.init(rootViewController: mineController)
        
        self.viewControllers = [projectsNavController,findNavController,mineNavController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let privateToken = Tools.privateToken()
        if privateToken == "" && viewController == tabBarController.viewControllers?[2]{
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController.init(rootViewController: loginViewController)
            self.present(navigationController, animated: true, completion: nil)
            return false
        }
        return true
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.title = viewController.title
        
    }

}
