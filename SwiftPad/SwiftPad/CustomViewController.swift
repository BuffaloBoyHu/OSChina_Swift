//
//  CustomViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/17.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import MJRefresh

class CustomViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var tableView = UITableView();
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 构造函数
    init(title :String,subTitles :Array<String>) {
        super.init(nibName: nil, bundle: nil);
        self.title = title;
//        for item in subTitles {
//            
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
