//
//  CustomViewController.swift
//  SwiftPad
//
//  Created by hu lianghai on 2016/10/17.
//  Copyright © 2016年 buffalo. All rights reserved.
//

import UIKit
import SnapKit

class CustomViewController: UIViewController,UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    var tableViewsArray :Array<CustomTableView>
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: 构造函数
    init(title :String,subTitles :Array<String>) {
        self.tableViewsArray = Array<CustomTableView>()
        super.init(nibName: nil, bundle: nil);
        self.tabBarItem.title = title
        self.title = title
        let screenFrame = UIScreen.main.bounds
        self.scrollView.delegate = self;
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.alwaysBounceHorizontal = true
        self.scrollView.contentSize = CGSize.init(width: screenFrame.width * CGFloat(subTitles.count), height: screenFrame.height)
        self.scrollView.contentOffset = CGPoint.zero
        self.scrollView.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.scrollView)
        
        for item in subTitles {
            let tableView = CustomTableView.init(cellReuseIndentifier: item)
            self.tableViewsArray.append(tableView)
            self.scrollView.addSubview(tableView)
        }
        
        self.addConstraintForSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 添加约束
    func addConstraintForSubviews() {
        unowned let weakSelf = self
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(weakSelf.view.snp.top).offset(64)
            make.left.equalTo(weakSelf.view.snp.left)
            make.right.equalTo(weakSelf.view.snp.right)
            make.bottom.equalTo(weakSelf.view.snp.bottom)
        }
        for (index,tableView) in self.tableViewsArray.enumerated() {
            if index == 0 {
                tableView.snp.makeConstraints({ (make) in
                    make.top.equalTo(weakSelf.view.snp.top).offset(64)
                    make.bottom.equalTo(weakSelf.view.snp.bottom)
                    make.width.equalTo(weakSelf.view.snp.width)
                })
            }else {
                let tmp = self.tableViewsArray[index - 1]
                tableView.snp.makeConstraints({ (make) in
                    make.top.equalTo(weakSelf.view.snp.top).offset(64)
                    make.bottom.equalTo(weakSelf.view.snp.bottom)
                    make.width.equalTo(weakSelf.view.snp.width)
                    make.left.equalTo(tmp.snp.right)
                })
            }
        }
    }
}
