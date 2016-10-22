//
//  APPTabbarController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/17.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit

class APPTabbarController: UITabBarController,UITabBarControllerDelegate {
    let projectsController = CustomViewController.init(title: "项目", subTitles: ["推荐","热门","最近跟新"])
    let mineController = CustomViewController.init(title: "我的", subTitles: ["动态","项目","Star","Watch"])
    let findController  :CustomCollectionController = CustomCollectionController.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.projectsController.tabBarItem.image = #imageLiteral(resourceName: "projects")
        self.projectsController.tabBarItem.selectedImage = #imageLiteral(resourceName: "projects_selected")
        self.mineController.tabBarItem.image = #imageLiteral(resourceName: "mine")
        self.mineController.tabBarItem.selectedImage = #imageLiteral(resourceName: "mine_selected")
        self.findController.tabBarItem.image = #imageLiteral(resourceName: "discover")
        self.findController.tabBarItem.selectedImage = #imageLiteral(resourceName: "discover_selected")
        self.findController.title = "发现"
        
        self.viewControllers = [self.projectsController,self.findController,self.mineController]
        self.title = self.selectedViewController?.title
        self.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.title = viewController.title
    }

}
